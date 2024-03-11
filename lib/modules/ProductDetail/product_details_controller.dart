import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../apis/buyer/cart_apis.dart';
import '../../views/buyer/views/cart_view.dart';

class ProductDetailsController extends GetxController {
  RxList selectedCategory = [].obs;
  RxList selectedAngleSize = [].obs;

  var cartItems = [].obs;
  dynamic productData;

  onCategoryPressed(Map data, int index) {
    var found = selectedAngleSize
        .firstWhereOrNull((element) => element['size'] == data['size']);
    if (found == null) {
      selectedAngleSize.add(data);
    } else {
      selectedAngleSize.remove(data);
    }

    selectedCategory.contains(index)
        ? selectedCategory.remove(index)
        : selectedCategory.add(index);
  }

  void addToCart(BuildContext context) async {
    context.loaderOverlay.show();
    try {
      await CartApis()
          .addToCart(
        productData['id'].toString(),
        productData['instock']['id'].toString(),
        selectedAngleSize.value,
        "1",
        productData['basic_price'],
        productData['type'],
      )
          .then((value) {
        print(value.responseBody!);
        context.loaderOverlay.hide();
        if (value.serverStatusCode == 200) {
          Get.to(() => CartView());
        }
      });
    } catch (e) {
      context.loaderOverlay.hide();
      // TODO
    }
  }
}
