import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../helpers/network_helper.dart' as RH;
import '../../main.dart';
import 'package:http/http.dart' as http;

class GeneralApis {
  Future<RH.Response> getCities() async {
    var headers = {'Accept': 'application/json'};
    var request = http.Request('GET', Uri.parse(Constants.cities));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return RH.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<RH.Response> submitFcm() async {
    String? fcm = await FirebaseMessaging.instance.getToken();
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.postEnquiry));
    request.fields.addIf(fcm != null, 'fcm_token', fcm ?? "");

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return RH.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<RH.Response> postEnquiry(String name, String quantity, String length, String width, String thickness, String specification) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.postEnquiry));

    request.fields.addIf(name.isNotEmpty, 'item_name', name);
    request.fields.addIf(quantity.isNotEmpty, 'quantity', quantity);
    request.fields.addIf(length.isNotEmpty, 'length', length);
    request.fields.addIf(width.isNotEmpty, 'width', width);
    request.fields.addIf(thickness.isNotEmpty, 'thickness', thickness);
    request.fields.addIf(specification.isNotEmpty, 'specification', specification);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    return RH.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }
}
