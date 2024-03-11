import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../apis/seller/product_related.dart';
import '../models/product_size_model.dart';
import 'package:image_picker/image_picker.dart';
import '../views/menu_views/add_product/add_stock.dart';

class AddProductController extends GetxController {
  TextEditingController productName = TextEditingController();
  TextEditingController productKgPrice = TextEditingController();
  TextEditingController productMtPrice = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController random = TextEditingController();
  TextEditingController clearCut = TextEditingController();
  TextEditingController sizePrice = TextEditingController();
  TextEditingController sizeDescription = TextEditingController();
  TextEditingController gstPercent = TextEditingController();
  TextEditingController priceType = TextEditingController();
  List<TextEditingController> measurementFields = [];
  var imagePath = "".obs;

  TextEditingController widthMM = TextEditingController();
  TextEditingController thicknessMM = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController heightMM = TextEditingController();
  TextEditingController diameterMM = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final sizeForm = GlobalKey<FormState>();
  final productNameForm = GlobalKey<FormState>();
  var selectedSizesList = <Size>[].obs;
  var preDefinedSizesList = [].obs;
  var categoryList = [].obs;
  Rx<String> sizeId = "".obs;
  var selectedCategory = {}.obs;
  var selectedImages = <XFile>[].obs;
  var lengthSelected = {}.obs;

  ///STOCK ADD
  var selectedProduct = {};
  var selectedProductInStock = {}.obs;
  TextEditingController length = TextEditingController();
  TextEditingController loadingAmountStock = TextEditingController();
  String selectedBrandType = "";

  /// UPDATE PRODUCT
  var isSizeTurnOn = false.obs;
  var selectedSizeForUpdateIndex = 0.obs;

  void updateSize() {
    selectedSizesList.refresh();
  }

  void addProduct() {

  }

  void addSize() {
    Size tempList = Size();
    selectedCategory['measurement_attributes'].asMap().forEach((index,
        element) {
      if (element == "width_in_mm") {
        tempList.widthInMm = measurementFields[index].text;
      }
      if (element == "height_in_mm") {
        tempList.heightInMm = measurementFields[index].text;
      }
      if (element == "diameter_in_mm") {
        tempList.diameterInMm = measurementFields[index].text;
      }
      if (element == "thickness_in_mm") {
        tempList.thicknessInMm = measurementFields[index].text;
      }
      if (element == "length_in_mm") {
        tempList.lengthInMm = measurementFields[index].text;
      }
      tempList.price = productKgPrice.text;
      tempList.description = sizeDescription.text;
    });
    selectedSizesList.add(tempList);
    measurementFields.clear();
    sizePrice.clear();
    for (var a in selectedCategory['measurement_attributes']) {
      measurementFields.add(TextEditingController());
    }
    updateSize();
  }

  /// FOR ADD MORE PRODUCT SIZE VIEW
  void addProductMoreSize(List measurements, String price,
      List<TextEditingController> textControlLists) {
    Size tempList = Size();
    measurements.asMap().forEach((index, element) {
      if (element == "width_in_mm") {
        tempList.widthInMm = textControlLists[index].text;
      }
      if (element == "height_in_mm") {
        tempList.heightInMm = textControlLists[index].text;
      }
      if (element == "diameter_in_mm") {
        tempList.diameterInMm = textControlLists[index].text;
      }
      if (element == "thickness_in_mm") {
        tempList.thicknessInMm = textControlLists[index].text;
      }
      tempList.price = price;
    });
    selectedSizesList.add(tempList);
    sizePrice.clear();
    for (var a in measurements) {
      measurementFields.add(TextEditingController());
    }
    updateSize();
  }

  void selectProductImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path;
    }
    imagePath.refresh();
  }

  Future<dynamic> postProduct(BuildContext context) async {
    context.loaderOverlay.show();
    try {
      ProductsRelate()
          .addProduct(
          selectedCategory['id'].toString(),
          productName.text,
          productDescription.text,
          productKgPrice.text,
          productMtPrice.text,
          gstPercent.text,
          priceType.text,
          random.text,
          clearCut.text,
          imagePath.value,
          selectedSizesList.value)
          .then((value) {
        var jsonData = jsonDecode(value.responseBody!);
        context.loaderOverlay.hide();
        if (value.serverStatusCode == 200) {
          clearEverything();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Product Added Successfully. Would you like to add stock as well?"),
            duration: Duration(days: 365),
            action: SnackBarAction(
              onPressed: () {
                Get.off(const SetAvailabilityView());
              },
              label: 'OKAY',
            ),
          ));
          // Constants.showSnackBar('Added Successfully!');
        } else if (value.serverStatusCode == 400) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(jsonData['message'][jsonData['message'].keys
                  .toList()
                  .first][0])));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(value.serverStatusText.toString())));
        }
      });
    } catch (e) {
      context.loaderOverlay.hide();
      // TODO
    }
  }

  Future<dynamic> getPreDefinedSizes() async {
    await ProductsRelate().getSizeList().then((value) {
      if (value.serverStatusCode == 200) {
        var json = jsonDecode(value.responseBody!);
        preDefinedSizesList.value = json['data'];
      }
    });
  }

  Future<dynamic> getCategories() async {
    await ProductsRelate().getCategories().then((value) {
      if (value.serverStatusCode == 200) {
        var json = jsonDecode(value.responseBody!);
        categoryList.value = json['data'];
      }
    });
  }

  Future<dynamic> postUpdateProduct(BuildContext context, String productId,
      String name, String price, String random, String clearCut,
      String description, String imagePath) async {
    context.loaderOverlay.show();
    try {
      await ProductsRelate().updateProduct(
          productId,
          name,
          price,
          random,
          clearCut,
          description,
          imagePath).then((value) {
        context.loaderOverlay.hide();
        if (value.serverStatusCode == 200) {
          clearEverything();
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Product updated successfully.")));
          Get.back();
        }
      });
    } catch (e) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())));
      // TODO
    }
  }

  Future<dynamic> addStock(BuildContext context, bool isFromAddProduct,
      String productId, String productBasePrice, String isiOrNot, String size,
      String length,
      String loadingAmount, String quantity, String description) async {
    context.loaderOverlay.show();
    await ProductsRelate().addStock(
        productId,
        productBasePrice,
        isiOrNot,
        size,
        length,
        loadingAmount,
        quantity,
        description,
        selectedImages.value).then((value) {
      context.loaderOverlay.hide();
      var jsonData = jsonDecode(value.responseBody!);
      if (value.serverStatusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Stock added successfully.")));
        Get.back();
        if (isFromAddProduct == true) {
          Get.back();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonData['message'])));
      }
    });
  }

  Future<dynamic> updateStock(BuildContext context, bool isFromAddProduct,
      String stockId, String productId, String productBasePrice,
      String isiOrNot, String size,
      String length, String loadingAmount, String quantity) async {
    context.loaderOverlay.show();
    List<String> imagePaths = [];
    selectedImages.value.forEach((element) {
      imagePaths.add(element.path);
    });
    await ProductsRelate().updateStock(
        stockId,
        productId,
        productBasePrice,
        isiOrNot,
        size,
        length,
        loadingAmount,
        quantity,
        imagePaths).then((value) {
      context.loaderOverlay.hide();
      var jsonData = jsonDecode(value.responseBody!);
      if (value.serverStatusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Stock added successfully.")));
        Get.back();
        if (isFromAddProduct == true) {
          Get.back();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonData['message'])));
      }
    });
  }

  void clearSizes() {
    price.clear();
    random.clear();
    widthMM.clear();
    thicknessMM.clear();
    clearCut.clear();
    quantity.clear();
    heightMM.clear();
    diameterMM.clear();
    selectedSizesList.clear();
    measurementFields.clear();
    sizePrice.clear();
    selectedCategory.clear();
    imagePath.value = "";
  }

  /// ADD PRODUCT IMAGES
  Future addProductImages() async {
    final ImagePicker _picker = ImagePicker();
    selectedImages.value = await _picker.pickMultiImage();
    selectedImages.refresh();
    updateSize();
  }

  void clearEverything() {
    productName.clear();
    productKgPrice.clear();
    productMtPrice.clear();
    productDescription.clear();
    price.clear();
    gstPercent.clear();
    random.clear();
    widthMM.clear();
    diameterMM.clear();
    thicknessMM.clear();
    clearCut.clear();
    quantity.clear();
    heightMM.clear();
    selectedSizesList.clear();
    measurementFields.clear();
    sizePrice.clear();
    selectedCategory.clear();
    priceType.clear();
    imagePath.value = "";
  }
}
