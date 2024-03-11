import 'dart:convert';

import 'package:get/get.dart';

import '../../../apis/seller/bargain_related.dart';

class SellerBargainController extends GetxController {
  var isWaitingForSeller = false.obs;


  Future<List> getBargainList() async {
    return await SellerBargainRelated().getBargainList().then((value) {
      if(value.serverStatusCode == 200) {
        var json = jsonDecode(value.responseBody!);
        List data = json['data'];
        return json['data'];
      } else {
        return [];
      }
    });
  }
}