import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/modules/sold_to_page/sold_to_page_view.dart';

class ShippingDetailController extends GetxController {
  RxBool checked = false.obs;

  var houseNoController = TextEditingController().obs;

  void onCheckBoxChange(bool? value) {
    checked.value = value ?? false;
  }

  onCheckOutPressed() {
    Get.to(() => SoldToPageView());
  }
}
