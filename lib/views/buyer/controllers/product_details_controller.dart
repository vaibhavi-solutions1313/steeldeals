import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../apis/buyer/cart_apis.dart';
import '../../../apis/buyer/product_apis.dart';
import '../../../main.dart';

class CustomerProductDetailsController extends GetxController {
  var variationIndex = 0.obs;
  Rx<double> quantity = 1.0.obs; // QUANTITY IN TON
  var quantityTextField =
      TextEditingController(text: "1").obs; // QUANTITY IN TON
  RxList selectedCategory = [].obs;
  RxList selectedAngleSize = [].obs;
  ScrollController productScrollController = ScrollController();
  var type = "basic".obs;
  TextEditingController typeTextController = TextEditingController();
  var typeContainerIndex = 0.obs;
  // Reactive variable to track the unit type
  RxString unitType = "".obs;

  var cartItems = [].obs;
  dynamic productData;
  // var totalPrice = "".obs;
  double baseTotal = 0.0;
  double variationPrice = 0.0;
  String sellerPrice = '';

  RxDouble productPricePerKg = 0.0.obs;
  RxDouble productPricePerMt = 0.0.obs;

  RxString totalPrice = "".obs;

  void updateUnitType() {
    if (quantity.value < 1.000) {
      unitType.value = "KG";
    } else {
      unitType.value = "Megaton";
    }
  }

  void onMinus(
    String variationTotal,
    String baseTotal,
  ) {
    quantity.value = double.parse(quantityTextField.value.text.toString());
    if (quantity > 0) {
      if (quantity >= 0.1 || quantity <= 0.9) {
        quantity -= 0.001;
        type.value = "basic";
        updateUnitType(); // Call the method to update unit type
      } else {
        quantity -= 1.000;
        type.value = "mt";
        updateUnitType(); // Call the method to update unit type
      }
      quantityTextField.value.text = quantity.toStringAsFixed(3);
      var tot = double.parse(variationTotal) + double.parse(baseTotal);
      totalPrice.value = (tot * quantity.value).toStringAsFixed(3);
    }
    /*if (quantity > 1) {
      if (customerProductDetailControl.quantityTextField.value.text.isEmpty || double.parse(customerProductDetailControl.quantityTextField.value.text.toString()) < 1.99) {
        customerProductDetailControl.quantityTextField.value.text = "1";
        quantity.value = 1;
        type.value = "basic";
      } else {
        quantity.value = double.parse(quantityTextField.value.text.toString());
        quantity = quantity - 1;
        if(quantity < 1){
          type.value = "basic";
        } else{
          type.value = "mt";
        }
      }
      customerProductDetailControl.quantityTextField.value.text = quantity.toString();
      var tot = double.parse(variationTotal) + double.parse(baseTotal);
      totalPrice.value = (tot * quantity.value).toString();
    }*/
  }

  void onEditQuantity(
    String variationTotal,
    String baseTotal,
  ) {
    quantity.value = double.parse(quantityTextField.value.text.toString());
    if (quantity > 0) {
      if (quantity >= 0.1 || quantity <= 0.9) {
        type.value = "basic";
        print('Decremented KG Quantity : ${quantity}');
        _updatePrices(json); // Call the method to update unit type
      } else {
        type.value = "mt";
        print('Decremented MT Quantity : ${quantity}');
        _updatePrices(json); // Call the method to update unit type
      }
      quantityTextField.value.text = quantity.toStringAsFixed(3);
      var tot = double.parse(variationTotal) + double.parse(baseTotal);
      totalPrice.value = (tot * quantity.value).toStringAsFixed(3);
    }
  }

  // KG: 0.001
  // Megaton: 1.0
  void onAddition(
    String variationTotal,
    String baseTotal,
  ) {
    quantity.value = double.parse(quantityTextField.value.text.toString());
    if (quantity > 0) {
      if (quantity >= 0.1 || quantity <= 0.9) {
        quantity += 0.001;
        type.value = "basic";
        print('Incremented KG Quantity : ${quantity}');
        updateUnitType(); // Call the method to update unit type
      } else {
        quantity += 1.000;
        type.value = "mt";
        print('Incremented MT Quantity : ${quantity}');
        updateUnitType(); // Call the method to update unit type
      }
      quantityTextField.value.text = quantity.toStringAsFixed(3);
      var tot = double.parse(variationTotal) + double.parse(baseTotal);
      totalPrice.value = (tot * quantity.value).toStringAsFixed(3);
    }
  }

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

  var buyerProductList = [].obs;

  Future<dynamic> getBuyerProducts(String catId) async {
    return await BuyerProductApis()
        .getProductsByCatId(catId)
        .then((value) async {
      if (value.serverStatusCode == 200) {
        var json = jsonDecode(value.responseBody!);
        print(json);
        buyerProductList.value = json['data'];
        return json['data'];
      } else {
        return null;
      }
    });
  }

  void _updatePrices(dynamic json) {
    productPricePerKg.value = json["price_per_kg"] ?? 0.0;
    // print("Kg price----------------: ${productPricePerKg.value}");
    productPricePerMt.value = json["price_per_mt"] ?? 0.0;
    // print("Megaton price---------------------: ${productPricePerMt.value}");
  }

  Future<dynamic> getProductsByProductId(String productId) async {
    print('Calling getProductsByProductId method...');
    return await BuyerProductApis()
        .getProductsByProductId(productId)
        .then((value) async {
      if (value.serverStatusCode == 200) {
        var json = jsonDecode(value.responseBody!);
        print('JSON Body: $json');

        print(" price---------------------: ${json['data']['price']}");

        // set product's price

        _updatePrices(json);
        print("Successful price display");
        // set seller's price
        sellerPrice = json['data']['price'] ?? "0.0";
        print(sellerPrice);
        update();
        return json['data'];
      } else {
        return null;
      }
    });
  }

  /*Future<dynamic> productsPrice(String productId) async{
    print('Product price method display');
    return await ProductsRelate().getProductsList().then((value) async {
      if(value.serverStatusCode == 200){
        var json = jsonDecode(value.responseBody!);
        print('JSON Body: $json');

        productPricePerKg = json['price_per_kg'];
        productPricePerMt = json['price_per_mt'];
        if(quantity.value < 1.0){
          // Display price_per_kg value
          print(json['data']);
          return productPricePerKg;
        } else{
          // Display price_per_mt value
          print(json['data']);
          return productPricePerMt;
        }
      } else{
        return null;
      }
    });
  }*/

  Future<void> productsPrice(String productId) async {
    print('Calling productsPrice method...');
    try {
      final response =
          await BuyerProductApis().getProductsByProductId(productId);
      if (response.serverStatusCode == 200) {
        final json = jsonDecode(response.responseBody!);
        productPricePerKg.value = json["price_per_kg"] ?? 0.0;
        productPricePerMt.value = json["price_per_mt"] ?? 0.0;
      }
    } catch (e) {
      print("Error fetching prices: $e");
    }
  }

  void clearcutOrRandomAdd(String amount) {
    customerProductDetailControl.totalPrice.value = baseTotal.toString();
    customerProductDetailControl.totalPrice.value =
        ((double.parse(customerProductDetailControl.baseTotal.toString()) +
                    double.parse(amount)) *
                quantity.value)
            .toString();
  }

  void addClearRandomToTotal(String amount) {
    customerProductDetailControl.totalPrice.value = baseTotal.toString();
    customerProductDetailControl.totalPrice.value =
        ((double.parse(customerProductDetailControl.totalPrice.value) +
                double.parse(typeTextController.text) * quantity.value))
            .toString();
  }

  Future addToCart(BuildContext context, bool isLoadingAmountPay) async {
    try {
      context.loaderOverlay.show();
      await CartApis()
          .addToCart(
              productData['id'].toString(),
              productData['instock']['id'].toString(),
              selectedAngleSize.value,
              quantity.value.toString(),
              productData['instock']['basic_price'].toString(),
              type.value)
          .then((value) async {
        try {
          await cartController.getCartItems().then((value1) {
            context.loaderOverlay.hide();
            if (value.serverStatusCode == 200) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Added to cart successfully.")));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Something went wrong.")));
            }
          });
        } catch (e) {
          context.loaderOverlay.hide();
          // TODO
        }
      });
    } catch (e) {
      context.loaderOverlay.hide();
      // TODO
    }
  }
}
