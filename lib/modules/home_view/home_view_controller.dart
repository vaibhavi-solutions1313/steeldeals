import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

import '../../views/products_listing.dart';

class HomeViewController extends GetxController {
  RxInt currentIndex = 0.obs;
  TextEditingController searchController = TextEditingController();
  var selectedTab = 0.obs;


  var drawerController = AdvancedDrawerController().obs;
  Rx<DateTime> pre_backpress = DateTime.now().obs;

  void onPageChanged(int value) {
    currentIndex.value = value;
  }

  onCategoryPressed() {
    Get.to(() => const ProductsListingView());
  }

  onDrawerPressed() {
    drawerController.value.showDrawer();
  }
}
