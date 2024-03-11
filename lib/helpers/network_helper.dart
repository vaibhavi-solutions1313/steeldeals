import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:services_provider_application/constants.dart';

// GET REQUEST EXAMPLE BELOW
// Map<String,dynamic> query = {
//   "type":"CATEGORY"
// };
// Map<String,String> header = {};
// NetworkHelper().getRequest("https://jayeshkumarp2.sg-host.com/api/catalogs",header,query);

// TODO:// MAKE TOAST OR SNACK BAR FOR NETWORK ISSUES OR SERVER ERROR | FOR NOW, I HAVE ADDED DEFAULT GET X SNACK BAR.

class NetworkHelper extends GetConnect {
  Future<bool> isInternetAvailable() async {
    bool isNetAvailable = false;
    final InternetConnectionChecker customInstance = InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 1),
      checkInterval: const Duration(seconds: 1),
    );
    bool result = await customInstance.hasConnection;
    if (result == true) {
      print('Internet working!');
      isNetAvailable = true;
    } else {
      print('No internet :(');
      isNetAvailable = false;
      Get.snackbar("Internet Not Working", "Check your internet connection and try again"); // CAN ADD YOUR OWN TOAST OR SNACK BAR
    }
    return await isNetAvailable;
  }

  Future<bool> isServerDown() async {
    bool isServerDown = false;
    try {
      final response = await get(Constants.baseUrl);
      print(response.statusCode);
      if (response.statusCode == 500 || response.statusCode == null) {
        isServerDown = true;
        Get.snackbar("Server Down", "It seems server is down, we are doing our best to fix it."); // CAN ADD YOUR OWN TOAST OR SNACK BAR
      }
    } on SocketException catch (e) {
      print(e);
      isServerDown = true;
      Get.snackbar("Server Down", "It seems server is down, we are doing our best to fix it."); // CAN ADD YOUR OWN TOAST OR SNACK BAR
      // TODO
    }
    return isServerDown;
  }

  Future<bool> isNetworkAndServerOkay() async {
    if (await isInternetAvailable()) {
      if (await isServerDown() == false) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<Response> getRequest(String url, Map<String, String> header, Map<String, dynamic> query) async {
    String contentType = "Accept:application/json";
    if(kIsWeb) {
      var responseBody = await get(url, headers: header, query: query, contentType: contentType);
      return Response(serverStatusCode: responseBody.statusCode, serverStatusText: responseBody.statusText, responseBody: responseBody.bodyString);
    }
    if (await isNetworkAndServerOkay()) {
      var responseBody = await get(url, headers: header, query: query, contentType: contentType);
      return Response(serverStatusCode: responseBody.statusCode, serverStatusText: responseBody.statusText, responseBody: responseBody.bodyString);
    } else {
      return Response();
    }
  }

  Future<Response> postRequest(String url, Map<String, String> header, Map<String, dynamic> query, bool isForm, dynamic json) async {
    String contentType = "Accept:application/json";
    FormData formData = FormData(query);
    if(kIsWeb) {
      var responseBody = await post(url, json, query: isForm == true? formData as Map<String, dynamic> : query, headers: header, contentType: contentType);
      return Response(responseBody: responseBody.bodyString, serverStatusCode: responseBody.statusCode, serverStatusText: responseBody.statusText);
    } else {
      if (await isNetworkAndServerOkay()) {
        var responseBody = await post(url, json, query: query, headers: header, contentType: contentType);
        return Response(responseBody: responseBody.bodyString, serverStatusCode: responseBody.statusCode, serverStatusText: responseBody.statusText);
      } else {
        return Response();
      }
    }
  }

  Future<Response> deleteRequest(String url, Map<String, String> header, Map<String, dynamic> query) async {
    String contentType = "Accept:application/json";
    if (await isNetworkAndServerOkay()) {
      var responseBody = await delete(url, query: query, headers: header, contentType: contentType);
      return Response(responseBody: responseBody.bodyString, serverStatusCode: responseBody.statusCode, serverStatusText: responseBody.statusText);
    } else {
      return Response();
    }
  }
}

class Response {
  final String? serverStatusText;
  final int? serverStatusCode;
  final String? responseStatusText;
  final int? responseStatusCode;
  final String? responseBody;

  Response({this.serverStatusText = "", this.serverStatusCode = 0, this.responseStatusText = "", this.responseStatusCode = 0, this.responseBody = ""});
}
