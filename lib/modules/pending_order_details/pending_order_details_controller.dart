import 'package:get/get.dart';

class PendingOrderDetailsController extends GetxController {
  RxBool buttonSwtich = true.obs;

  onButtonPressed() {
    buttonSwtich.value = !buttonSwtich.value;
  }
}
