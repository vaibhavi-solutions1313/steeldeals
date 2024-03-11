import 'dart:convert';

import 'package:get/get.dart';
import 'package:services_provider_application/modules/pending_order_details/pending_order_details.dart';

import '../../../apis/buyer/orders_apis.dart';

class PendingOrderController extends GetxController {
  var orderPendingHistoryList = [].obs;

  String reformatImages(List data) {
    if (data.length != 0) {
      if (data.length == 1) {
        if (data[0]['product']['images'].isNotEmpty) {
          return data[0]['product']['images'][0]['url'].toString();
        } else {
          return "";
        }
      }
    } else {
      return "";
    }
    return "";
  }

  String reformatName(List data) {
    if (data.length != 0) {
      if (data.length == 1) {
        return data[0]['product']['name'];
      } else {
        return data[0]['product']['name'] + " and ${data.length - 1} more.";
      }
    } else {
      return "Product not found";
    }
  }

  Future getPendingOrdersList() async {
    await OrderApis().getPendingOrdersList().then((value) {
      if (value.serverStatusCode == 200) {
        var jsonData = jsonDecode(value.responseBody!);
        orderPendingHistoryList.value = jsonData['data'];
      }
    });
  }

  onOrderPressed(int index) {
    Get.to(() => PendingOrderDetails());
  }
}
