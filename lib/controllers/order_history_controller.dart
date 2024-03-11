import 'dart:convert';
import 'package:get/get.dart';
import 'package:services_provider_application/views/order_tracking.dart';
import '../apis/buyer/orders_apis.dart';

class OrderHistoryController extends GetxController {
  var selectedOrderStatus = 0.obs;
  var orderHistoryList = [].obs;
  var orderSortedList = [].obs;

  Future getOrdersList() async{
    await OrderApis().getOrdersList().then((value) {
      if(value.serverStatusCode == 200) {
        var jsonData = jsonDecode(value.responseBody!);
        orderHistoryList.value = jsonData['data'];
        orderSortedList.value = orderHistoryList.value;
      }
    });
  }


  onOrderStatusChanged(int index,int id) {
    selectedOrderStatus.value = index;
    var found = orderHistoryList.where((p0) => p0['status'] == id).toList();
    if(id != -1) {
      orderSortedList.value = found;
    } else {
      orderSortedList.value = orderHistoryList.value;
    }
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


  goToTrackOrder() {
    Get.to(()=>const OrderTrackingView());
  }
}