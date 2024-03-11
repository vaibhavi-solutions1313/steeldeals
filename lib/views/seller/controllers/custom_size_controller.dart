import 'dart:convert';

import 'package:get/get.dart';
import '../../../apis/seller/custom_size_related.dart';

class SellerCustomSizeController extends GetxController {
  var customSizeRequestList = [].obs;

  @override
  void onInit() {
    getLists();
    // TODO: implement onInit
    super.onInit();
  }

  Future getLists() async {
    try {
      await SellerCustomSizeRequestsApis().getRequestsList().then((value) {
        if (value.serverStatusCode == 200) {
          var json = jsonDecode(value.responseBody!);
          customSizeRequestList.value = json['data'];
        }
      });
    } catch (e) {
      // TODO
    }
  }

  Future updateStatus(String statusUpdate, String id) async {
    return await SellerCustomSizeRequestsApis().updateStatus(statusUpdate, id);
  }
}
