
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaymentMethodController extends GetxController {
  var cardNumber = '5158452569854250'.obs;
  var expiry = '0'.obs;
  var cardHolderName = '0'.obs;
  var cvv = '0'.obs;
  var showBackFocused = false.obs;
  TextEditingController bankName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController accountHolderName = TextEditingController();
  TextEditingController ifsc = TextEditingController();
  TextEditingController branch = TextEditingController();

  void clearEverything() {
    bankName.clear();
    accountNumber.clear();
    accountHolderName.clear();
    ifsc.clear();
    branch.clear();
  }
}