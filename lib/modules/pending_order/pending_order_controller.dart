import 'package:get/get.dart';
import 'package:services_provider_application/modules/pending_order_details/pending_order_details.dart';

class PendingOrderController extends GetxController {
  onOrderPressed(int index) {
    Get.to(() => PendingOrderDetails());
  }
}
