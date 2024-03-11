import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../../helpers/network_helper.dart' as RR;
import '../../main.dart';

class ProfileApis {
  Future<RR.Response> updateProfile(String name, String country, String city, String state, String pinCode, String panCard, String gst, String cinNumber, String aadhar,
      String iecNumber, File profilePicPath, String panPath, String gstPath, String aadharPath, String cinPath, String iecPath) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.buyerProfileUpdate));

    request.fields.addIf(name.isNotEmpty, "name", name);
    request.fields.addIf(country.isNotEmpty, "country", country);
    request.fields.addIf(state.isNotEmpty, "state", state);
    request.fields.addIf(city.isNotEmpty, "city", city);
    request.fields.addIf(pinCode.isNotEmpty, "pin_code", pinCode);
    request.fields.addIf(panCard.isNotEmpty, "pan_card", panCard);
    request.fields.addIf(gst.isNotEmpty, "gst_number", gst);
    request.fields.addIf(cinNumber.isNotEmpty, "cin_number", cinNumber);
    request.fields.addIf(aadhar.isNotEmpty, "aadhar_number", aadhar);
    request.fields.addIf(iecNumber.isNotEmpty, "iec_number", iecNumber);
    //
    if (await profilePicPath.exists()) {
      request.files.add(await http.MultipartFile.fromPath('profile', profilePicPath.path));
    }
    // request.files.addIf(panPath.isNotEmpty, await http.MultipartFile.fromPath('pan_img', panPath));
    // request.files.addIf(gstPath.isNotEmpty, await http.MultipartFile.fromPath('gst_img', gstPath));
    // request.files.addIf(aadharPath.isNotEmpty, await http.MultipartFile.fromPath('aadhar_img', aadharPath));
    // request.files.addIf(cinPath.isNotEmpty, await http.MultipartFile.fromPath('cin_img', cinPath));
    // request.files.addIf(iecPath.isNotEmpty, await http.MultipartFile.fromPath('iec_img', iecPath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<RR.Response> getProfileInfo() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.buyerProfile));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }
}
