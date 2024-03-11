import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../apis/seller/product_related.dart';

class SellerHomeController extends GetxController {
  PageController sellerHomePageController = PageController();
  Rx<int> currentNavIndex = 0.obs;
  var shopInfo = {}.obs;
  var isStoreCreated = false.obs;
  var orderList = [].obs;
  var selectedOrderStatus = {}.obs;
  var bannerList = [].obs;

  Future<dynamic> getOrdersList() async {
    return await ProductsRelate().getProductOrdersList().then((value) {
      if (value.serverStatusCode == 200) {
        var jsonData = jsonDecode(value.responseBody!);
        orderList.value = jsonData['data'];
        var found = jsonData['data'].where((p0) {
          if (p0['order'] != null) {
            return p0['order']['status'] == selectedOrderStatus['id'];
          } else {
            return false;
          }
        }).toList();
        if (selectedOrderStatus.value['id'] == -1) {
          return orderList.value;
        } else {
          return found;
        }
      }
    });
  }

  String joinedDate() {
    DateTime parsedJoinedDate = DateTime.parse(shopInfo['created_at']);
    return DateTime.now().difference(parsedJoinedDate).inDays.toString();
  }

  Future<dynamic> getSellerBanners() async {
    bannerList.clear();
    return await ProductsRelate().getSellerBanners().then((value) {
      if (value.serverStatusCode == 200) {
        var jsonData = jsonDecode(value.responseBody!);
        List a = jsonData['data'];
        a.forEach((element) {
          if (element['approve'] == 1) {
            bannerList.add(element);
          }
        });
      }
    });
  }
}
