
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:services_provider_application/apis/seller/product_related.dart';

class SellerCategoryController extends GetxController {
  TextEditingController categoryName = TextEditingController();
  TextEditingController description = TextEditingController();
  String width = "";
  String height = "";
  String thickness = "";
  String diameter = "";
  String length = "";
  var selectedAttr = [].obs;
  XFile? selectedImage;
  List measurementTypes = [
    {"name": "Width", "codeName": "width_in_mmm"},
    {"name": "Height", "codeName": "height_in_mm"},
    {"name": "Thickness", "codeName": "thickness_in_mm"},
    {"name": "Diameter", "codeName": "diameter_in_mm"},
    {"name": "Length", "codeName": "length_in_mm"},
  ];

  void addCateImages() async {
    final ImagePicker _picker = ImagePicker();
    selectedImage = await _picker.pickImage(source: ImageSource.gallery) ?? XFile('');
  }

  void postCategory(BuildContext context) async {
    selectedAttr.forEach((element) {
      if (element['codeName'] == 'width_in_mmm') {
        width = element['codeName'];
      }
      if (element['codeName'] == 'height_in_mm') {
        height = element['codeName'];
      }
      if (element['codeName'] == 'thickness_in_mm') {
        thickness = element['codeName'];
      }
      if (element['codeName'] == 'diameter_in_mm') {
        diameter = element['codeName'];
      }
      if (element['codeName'] == 'length_in_mm') {
        length = element['codeName'];
      }
    });
    context.loaderOverlay.show();
    ProductsRelate().addCategory(categoryName.text, description.text, width, thickness, height, diameter, selectedImage != null ? selectedImage!.path : "",length).then((value) {
      context.loaderOverlay.hide();
      if (value.serverStatusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New Category Created Successfully!")));
        clearEverything();
        Get.back();
        // homeSellerController.currentNavIndex.value =0 ;
        // homeSellerController.sellerHomePageController = PageController(initialPage: 0);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong. Please recheck and try again.")));
      }
    });
  }

  void clearEverything() {
    categoryName.clear();
    description.clear();
    selectedAttr.clear();
    selectedImage = XFile("");
  }
}
