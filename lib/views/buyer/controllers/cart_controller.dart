import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:services_provider_application/apis/buyer/cart_apis.dart';
import 'package:services_provider_application/main.dart';
import '../model/cart_reformat_model.dart';

class CartController extends GetxController {
  var itemGstTotal = 0.0.obs;
  var gst = "".obs;
  var total = "".obs;
  var grandTotalValue = "".obs;
  var isCartEmpty = false.obs;
  var cartItemsList = [].obs;
  var reformattedCartList = <CartReformatModel>[].obs;
  var refreshCart = false.obs;

  Future<List<CartReformatModel>> getCartItems() async {
    return await CartApis().getCartItems().then((value) async {
      if (value.serverStatusCode == 200) {
        var json = jsonDecode(value.responseBody!);
        gst.value = json['data']['gst'].toString();
        total.value = json['data']['total'].toString();
        grandTotal();
        cartItemsList.value = json['data']['cart_items'];
        return refactorCart();
      } else {
        return [];
      }
    });
  }

  List<CartReformatModel> finalList = [];

  /// REFACTOR CART DATA
  Future<List<CartReformatModel>> refactorCart() async {
    finalList.clear();
    List<int> ids = [];
    for (var value in cartItemsList) {
      ids.add(value['product']['shop_id']);
    }
    ids.toSet().toList().forEach((id) {
      var found = cartItemsList.where((p0) => p0['product']['shop_id'] == id).toList();
      String imagePath = "";
      String fullName = "";
      String price = "0";
      String sellerName = "";
      String grandTotal = "0";

      List<ProductList> productList = [];
      found.asMap().forEach((index, element) {
        if (found.length > 0 && index == 1) {
          fullName = found[0]['product']['name'] + " & ${found.length - 1}More";
        } else {
          fullName = element['product']['name'];
        }
        imagePath = found[0]['product']['images'][0]['url'];
        sellerName = element['product']['shop']['shop_name'];
        price = element['total'].toString();
        grandTotal = (double.parse(grandTotal) + double.parse(element['total'].toString())).toString();

        var size = sizeController.preDefinedSizesList.firstWhereOrNull((element2) => element2['id'].toString() == element["size_id"].toString()); // FIND SIZE BY ID
        productList.add(ProductList(
            productId: element['id'].toString(),
            productImage: element['product']['images'][0]['url'],
            productName: element['product']['name'].toString(),
            quantity: element['qty'].toString(),
            size: size != null ? size['size'].toString() : null,
            amount: element['total'].toString()));
      });

      reformattedCartList.add(
        CartReformatModel(
          firstProductImage: imagePath,
          allName: fullName,
          sellerName: sellerName,
          totalPrice: grandTotal,
          productList: productList,
          summary: Summary(
            cgst: "0",
            igst: "0",
            insurance: "0",
            loadingAmount: "0",
            sgst: "0",
            tcs: "0",
            others: "0",
            grandTotal: grandTotal,
          ),
        ),
      );
    });
    finalList = reformattedCartList;
    return finalList;
  }

  String findStoreNameById(String storeId) {
    var found = customerHomeControl.storesList.firstWhereOrNull((p0) => p0['id'].toString() == storeId);
    print(found);
    if (found != null) {
      return found['name'];
    } else {
      return "Seller";
    }
  }

  void grandTotal() {
    double lTotal = 0.0;
    try {
      lTotal = double.parse(total.value.toString()) + double.parse(gst.value.toString());
      grandTotalValue.value = lTotal.toString();
    } catch (e) {
      // TODO
    }
  }

  Future emptyCart(BuildContext context) async {
    try {
      context.loaderOverlay.show();
      return await CartApis().emptyCart().then((value) async {
        await getCartItems().then((value2) {
          context.loaderOverlay.hide();
          if (value.serverStatusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cart is empty!")));
          }
        });
      });
    } catch (e) {
      context.loaderOverlay.hide();
      // TODO
    }
  }

  /// UTILS
  String reformattedNumbers(String number,bool isRefactor) {
    final formatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹',decimalDigits: isRefactor ? 2:0);
    String formattedNumber = formatter.format(double.parse(number));
    return formattedNumber;
  }
}
