import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class StoreInBuyerController extends GetxController {
  ScrollController sliverControl = ScrollController();
  var isSearchEnabled = false.obs;
  var searchControl = TextEditingController().obs;
  var selectedCatIndex = 100000.obs;

  void refreshSearch() {
    searchControl.refresh();
  }

  void sortByCategories(String catId) {
    var foundProducts = customerHomeControl.storeProductList.where((p0) => p0['category_id'].toString() == catId).toList();
    customerHomeControl.storeNewProductList.value = foundProducts;
  }

  void resetSorting() {
    selectedCatIndex.value = 100000;
    customerHomeControl.storeNewProductList.value = List.from(customerHomeControl.storeProductList);
  }
}
