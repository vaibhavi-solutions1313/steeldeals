import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:services_provider_application/views/payment_method_view.dart';
// Import open_file package
import '../../../apis/buyer/checkout_apis.dart';
import '../../../main.dart';
import '../views/order_history_view.dart';

class CheckoutController extends GetxController {
  var isThreeLineAddress = false.obs;
  var payModeSelected = "".obs;

  void makePayment(BuildContext context) async {
    context.loaderOverlay.show();
    try {
      CheckoutApi().placeOrder().then((value) async {
        context.loaderOverlay.hide();
        if (value.serverStatusCode == 200) {
          Map<String, dynamic>? responseData = value.responseBody != null
              ? json.decode(value.responseBody!) as Map<String, dynamic>
              : null;

          if (responseData != null) {
            // Access the 'data' property
            Map<String, dynamic>? data = responseData['data'] as Map<String, dynamic>?;

            if (data != null) {
              // Access the 'downloadLink' and 'fileName' properties
              String downloadLink = data['downloadLink'];
              String fileName = data['fileName'];
              // Now you can use the fetched data as needed
              print('Download Link: $downloadLink');
              print('File Name: $fileName');
              // Continue with the rest of your code...
              await download(downloadLink, fileName);
              clearEverything();
              paymentMethodControl.clearEverything();
              return;
            }
          }

          clearEverything();
          paymentMethodControl.clearEverything();
        } else {
          Get.back();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong, try again.")));
        }
      });
    } catch (e) {
      context.loaderOverlay.hide();
      // TODO: Handle the error
    }
  }

  Future download(String url, String filename) async {
    var savePath = '/storage/emulated/0/Download/$filename';
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    try {
      var response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false
        ),
      );
      var file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();

      // Show a popup after successful download
      showDownloadedFilePopup();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      debugPrint((received / total * 100).toStringAsFixed(0) + '%');
    }
  }

  void showDownloadedFilePopup() {
    Get.dialog(
      AlertDialog(
        title: Text("Order Placed"),
        content: Text("Order Placed And Invoice Download Successfully."),
        actions: [
          TextButton(
            onPressed: () {
              Get.off(()=>OrderHistory());
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<String> fileLocation({required String fileName, required String url}) async {
    try {
      final dirPath = await getApplicationDocumentsDirectory();
      final filePath = "${dirPath.path}/$fileName";
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: Duration(seconds: 0),
        ),
      );
      await File(filePath).writeAsBytes(response.data);
      return filePath;
    } catch (error) {
      print('Error downloading file: $error');
      return ''; // Return an empty string or handle the error as needed
    }
  }

  String tenPercentPayAmount() {
    return (double.parse(cartController.grandTotalValue.value) / 10).toString();
  }

  void clearEverything() {
    payModeSelected.value = "";
    isThreeLineAddress.value = false;
  }
}
