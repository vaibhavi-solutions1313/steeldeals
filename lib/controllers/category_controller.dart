import 'dart:convert';

import 'package:get/get.dart';

import '../apis/buyer/home_apis.dart';

class CategoryController extends GetxController {
  var categories = [].obs;
  var subCatIndex = 0.obs;

  var selectedSellerData = {}.obs;
  var selectedIndex = 1000000000000000000.obs;

  Future getCategories() async {
    return await HomeApis().getCategories().then((value) {
      if (value.serverStatusCode == 200) {
        var json = jsonDecode(value.responseBody!);
        categories.value = json['data'];
        print("11122233"+json.toString());
      }
    });
  }

  void clearEverything() {
    selectedIndex.value = 1000000000000000000;
    selectedSellerData.clear();
  }

  @override
  void dispose() {
    clearEverything();
    // TODO: implement dispose
    super.dispose();
  }
}
