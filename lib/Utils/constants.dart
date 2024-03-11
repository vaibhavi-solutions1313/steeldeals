import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constants {
  static Color primaryButtonColor = const Color(0xFFF5951D);
  static Color secondaryButtonColor = const Color(0xFFFFFFFF);

  //////////////////////////////////////////////////////////////////////////

  static Size returnScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static void showSnackBar(String s) {
    Get.showSnackbar(GetSnackBar(
      message: s,
      duration: const Duration(seconds: 3),
    ));
  }

  /// ENDPOINTS
  static String baseUrl = "https://webada.lol";
  // static String baseUrl = "https://steel-deal.stavbook.com";
  // static String baseUrl = "http://steel-deal-api.shopxy.online"; // OLD
  static String signUpBuyer = "/api/register";
  static String signIn = "/api/login";
  static String validateOtp = "/api/validate/otp";
  static String buyerHomeBanners = "/api/buyer/banner/list";
  static String buyerProducts = "/api/product/category/";
  static String buyerProductsByProductId = "/api/product/fetch/";
  static String buyerCart = "/api/customer/cart";
  static String buyerCartList = "/api/customer/fetch-cart";
  static String buyerCheckout = "/api/customer/checkout";
  static String buyerAddressesLists = "/api/customer/all-addresses";
  static String buyerAddNewAddress = "/api/customer/address/add";
  static String buyerDeleteAddress = "/api/customer/address/delete/";
  static String searchProduct = "/api/search/product?keyword=";
  static String categoryList = "/api/category/list";
  static String sellerAddProduct = "/api/seller/product/add";
  static String sellerAddCategory = "/api/seller/category/add";
  static String sellerProductSizeList = "/api/seller/size";
  static String updateProduct = "/api/seller/product/update/";
  static String deleteProduct = "/api/seller/product/delete/";
  static String sellerProductsList = "/api/seller/product/list";
  static String sellerCreateShop = "/api/seller/shop";
  static String sellerMyShopInfo = "/api/seller/my/shop";
  static String sellerStoreTimings = "/api/seller/shop-time";
  static String sellerStoreTimingsUpdate = "/api/seller/update-shop-time";
  static String sellerProductOrderList = "/api/seller/order/items";
  static String sellerCategoryList = "/api/seller/category/list";
  static String sellerAddStock = "/api/seller/stock/add";

  /// USER INFO
  String bearerToken = "";

  /// ORDER STATUS CODE MEANING
  static List<Map<String, dynamic>> orderStatusList = [
    {"id": 2, "mean": "PENDING","name":"Pending"},
    {"id": 3, "mean": "ON_PROCESSING","name":"On Processing"},
    {"id": 4, "mean": "DELIVERED","name":"Delivered"},
    {"id": 1, "mean": "COMPLETED","name":"Completed"},
    {"id": 0, "mean": "CANCELED","name":"Canceled"},
    {"id": 5, "mean": "RETURNED","name":"Returned"},
  ];
}
