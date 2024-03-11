import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../apis/buyer/product_apis.dart';
import '../apis/seller/product_related.dart';

class SellerProductsController extends GetxController {
  /// SELLER
  var productsList = [].obs;
  var isSearch = false.obs;
  TextEditingController storeSearchedProduct = TextEditingController();


  Future<dynamic> getProducts() async {
    return await ProductsRelate().getProductsList().then((value) async {
      if (value.serverStatusCode == 200) {
        var json = jsonDecode(value.responseBody!);
        productsList.value = json['data'];
        if(storeSearchedProduct.text.isNotEmpty && isSearch.value == true) {
          var found = productsList.value.where((element) => element['name'].toString().toLowerCase().contains(storeSearchedProduct.text.toString().toLowerCase()));
          isSearch.value = false;
          return found.toList();
        } else {
          return json['data'];
        }
      } else {
        return null;
      }
    });
  }

  /*Future<dynamic> getProductsByProductId(String productId) async {
    return await BuyerProductApis().getProductsByProductId(productId).then((value) async {
      if (value.serverStatusCode == 200) {
        var json = jsonDecode(value.responseBody!);
        print('JSON Body: $json');
        return json['data'];
      } else {
        return null;
      }
    });
  }*/

  Future<bool> deleteProduct(BuildContext context,String productId) async {
    return await ProductsRelate().deleteProduct(productId).then((value) async {
      if(value.serverStatusCode == 200) {
        Get.showSnackbar(GetSnackBar(duration: Duration(seconds: 2),title: 'Success',message: "Product Deleted Successfully.",));
        return true;
      } else {
        Get.showSnackbar(GetSnackBar(duration: Duration(seconds: 2),title: 'Failed',message: "Something went wrong.",));
        return false;
      }
    });
  }
}
