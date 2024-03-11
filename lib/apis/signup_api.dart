import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:services_provider_application/constants.dart';
import '../helpers/network_helper.dart' as HR;

class AuthApi {
  Future<HR.Response> signUp(String name, String email, String phone, String address, String city, String state, String country, String pinCode, String panCard, String gst,
      String userType, String cin, String aadhar, String iecNumber, String aadharImgPath, String panImgPath, String cinImgPath, String gstImgPath, String iecImgPath) async {
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.signUpBuyer));
    request.fields.addAll({
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'pin_code': pinCode,
      'pan_card': panCard,
      'gst_number': gst,
      'type': userType,
      'cin_number': cin,
      'aadhar_number': aadhar,
      'iec_number': iecNumber
    });
    if (aadharImgPath.isNotEmpty) request.files.addIf(aadharImgPath.isNotEmpty, await http.MultipartFile.fromPath('aadhar_img', aadharImgPath));
    if (panImgPath.isNotEmpty) request.files.addIf(panImgPath.isNotEmpty, await http.MultipartFile.fromPath('pan_img', panImgPath));
    if (cinImgPath.isNotEmpty) request.files.addIf(cinImgPath.isNotEmpty, await http.MultipartFile.fromPath('cin_img', cinImgPath));
    if (gstImgPath.isNotEmpty) request.files.addIf(gstImgPath.isNotEmpty, await http.MultipartFile.fromPath('gst_img', gstImgPath));
    if (iecImgPath.isNotEmpty) request.files.addIf(iecImgPath.isNotEmpty, await http.MultipartFile.fromPath('iec_img', iecImgPath));

    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString();
    print(responseBody);
    return HR.Response(responseBody: responseBody, serverStatusCode: response.statusCode, serverStatusText: response.reasonPhrase);
  }

  Future<HR.Response> signIn(String userEmail) async {
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.signIn));
    var token = await FirebaseMessaging.instance.getToken();
    
    request.fields.addAll({'username': userEmail, 'device_id': token ?? ""});

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    return HR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<HR.Response> validateOtp(String validateToken, String otp) async {
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.validateOtp));
    request.fields.addAll({'token': validateToken, 'otp': otp});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      print(responseData);
      return HR.Response(responseBody: responseData, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
    } else {
      print(response.reasonPhrase);
      return HR.Response(responseBody: '', responseStatusCode: 0, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
    }
  }
}
