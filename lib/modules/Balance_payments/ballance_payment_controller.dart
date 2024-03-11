import 'package:get/get.dart';

class BalancePaymentController extends GetxController {
  List selectedIndex = [].obs;

  onSelected(int index) {
    selectedIndex.contains(index)
        ? selectedIndex.remove(index)
        : selectedIndex.add(index);
  }
}
