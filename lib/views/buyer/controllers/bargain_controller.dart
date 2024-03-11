import 'dart:convert';

import 'package:get/get.dart';

import '../../../apis/buyer/bargain_related.dart';

class CustomerBargainController extends GetxController {
  var isWaitingForBuyer = false.obs;


  Future<List> getBargainList() async {
    return await CustomerBargainRelated().getBargainList().then((value) {
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