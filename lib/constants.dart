import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constants {
  static Color primaryButtonColor = const Color(0xFFF5951D);
  static Color secondaryButtonColor = const Color(0xFFFFFFFF);
  DateTime time = DateTime(2023, 5, 17);

  //////////////////////////////////////gbhjhjhjfhgghhjhghghgjhjjjghg////////////////////////////////////

  static Size returnScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static void showSnackBar(String s) {
    Get.showSnackbar(GetSnackBar(
      message: s,
      duration: const Duration(seconds: 2),
    ));
  }

  /// ENDPOINTS
  static String baseUrl = "https://webada.lol";
  static String cities = "https://raw.githubusercontent.com/nshntarora/Indian-Cities-JSON/master/cities.json";
  static String appInfo = "/api/app-info";
  static String signUpBuyer = "/api/register";
  static String signIn = "/api/login";
  static String validateOtp = "/api/validate/otp";
  static String buyerHomeBanners = "/api/customer/banner/list";
  static String buyerAllProducts = "/api/product/all";
  static String buyerProductsByCatId = "/api/product/category/";
  static String buyerProductsByProductId = "/api/product/fetch/";
  static String buyerProductCounterPrice = "/api/customer/product/counter";
  static String buyerProductFilter = "/api/filter/product";
  static String buyerCart = "/api/customer/cart";
  static String buyerRemoveItemCart = "/api/customer/cart/item-remove/";
  static String buyerEmptyCart = "/api/customer/cart/item/empty";
  static String buyerCartList = "/api/customer/fetch-cart";
  static String buyerCheckout = "/api/customer/checkout";
  static String buyerDefaultAddress = "/api/customer/all-addresses";
  static String buyerAddressesLists = "/api/customer/all-addresses";
  static String buyerOrdersLists = "/api/customer/all-orders";
  static String buyerPendingOrdersLists = "/api/customer/orders/pending/data";
  static String buyerAddNewAddress = "/api/customer/address/add";
  static String buyerUpdateAddress = "/api/customer/address/update/";
  static String buyerDeleteAddress = "/api/customer/address/delete/";
  static String buyerProfile = "/api/get-update";
  static String buyerProfileUpdate = "/api/profile-update";
  static String buyerCustomSizeRequest = "/api/customer/size/request";
  static String searchProduct = "/api/search/product?keyword=";
  static String categoryList = "/api/category/list";
  static String buyerStoresList = "/api/shops/1";
  static String buyerCategoriesByStoreId = "/api/customer/shop/";
  static String buyerProductsByStoreId = "/api/product/shop/";
  static String postEnquiry = "/api/customer/product-enquiry/new";
  static String transportList = "/api/all-transporters";
  // static String sellerAddProduct = "/api/seller/product/add"; // OLD
  static String sellerAddProduct = "/api/seller/product/add-with-sizes";
  static String sellerAddMoreProductSize = "/api/seller/product/add-sizes";
  static String sellerAddCategory = "/api/seller/category/add";
  static String sellerProductSizeList = "/api/seller/size";
  static String updateProduct = "/api/seller/product/update/";
  static String updateProductSize = "/api/seller/product/update-size-details";
  static String updateStock = "/api/seller/stock/update";
  static String deleteProduct = "/api/seller/product/delete/";
  static String sellerProductsList = "/api/seller/product/list";
  static String sellerCreateShop = "/api/seller/shop";
  static String sellerMyShopInfo = "/api/seller/my/shop";
  static String sellerShopOpenStatus = "/api/seller/update-status";
  static String sellerStoreTimings = "/api/seller/shop-time";
  static String sellerStoreTimingsUpdate = "/api/seller/update-shop-time";
  static String sellerStoreGenUpdate = "/api/seller/update-shop/";
  static String sellerProductOrderList = "/api/seller/order/items";
  static String sellerCategoryList = "/api/seller/category/list";
  static String sellerAddStock = "/api/seller/stock/add";
  static String sellerGetBanners = "/api/seller/banner/list";
  static String sellerBargainList = "/api/seller/product/counter/list";
  static String sellerBargainUpdatePrice = "/api/seller/product/counter/update/";
  static String sellerSizeRequestLists = "/api/seller/custom-size-requests?status=0";
  static String sellerSizeRequestUpdate = "/api/seller/custom-size-request/";
  static String sellerAcceptBargain = "/api/product/counter/accept/";
  static String bargainList = "/api/customer/product/counter/list";
  static String bargainRaise = "/api/customer/product/counter";
  static String bargainUpdatePrice = "/api/customer/product/counter/update/";
  static String bargainAccept = "/api/product/counter/accept/";
  static String chatList = "/api/messages/users-list";
  static String chatMsgs = "/api/messages/user/";
  static String chatSendMsg = "/api/messages/send-message";
  static String chatDelete = "/api/messages/";

  /// USER INFO
  String bearerToken = "";

  /// ORDER STATUS CODE MEANING
  static List<Map<String, dynamic>> orderStatusList = [
    {"id": -1, "mean": "ALL_ORDERS", "name": "All Orders"},
    {"id": 2, "mean": "PENDING", "name": "Pending"},
    {"id": 3, "mean": "ON_PROCESSING", "name": "In Processing"},
    {"id": 4, "mean": "DELIVERED", "name": "Delivered"},
    {"id": 1, "mean": "COMPLETED", "name": "Completed"},
    {"id": 0, "mean": "CANCELED", "name": "Cancelled"},
    // {"id": 5, "mean": "RETURNED","name":"Returned"},
  ];

  static const USERTYPE = "userType";
  static const USERDATA = "userInfo";
  static const BEARERTOKEN = "bearerToken";
}
