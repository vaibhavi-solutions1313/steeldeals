import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:services_provider_application/main.dart';

import '../../../apis/buyer/home_apis.dart';
import '../views/sell_all_views/see_all_products.dart';
import '../views/store_view.dart';

class HomeViewController extends GetxController {
  RxInt currentIndex = 0.obs;
  PageController pageController = PageController();
  TextEditingController searchController = TextEditingController();
  var selectedTab = 0.obs;
  var bannerList = [].obs;
  var storesList = [].obs;
  var storeCatList = [].obs;
  var storeProductList = [].obs;
  var storeNewProductList = [].obs;
  var isSearchEnabled = false.obs;
  var allProducts = [].obs;

  void getUserLocation() {
    customerAddControl.userLocalityDetected.value = "Locating...";
    customerAddControl.getUserLocation().then((position) {
      customerAddControl.userCurrentCoordinates = LatLng(position.latitude, position.longitude);
      customerAddControl.getAddressByCoordinates(customerAddControl.userCurrentCoordinates);
    }).onError((error, stackTrace) {
      customerAddControl.userLocalityDetected.value = "Not Provided";
    });
  }


  Future getBannersList() async {
    return await HomeApis().getBanners().then((value) {
      if (value.serverStatusCode == 200) {
        var jsonData = jsonDecode(value.responseBody!);
        bannerList.value = jsonData['data'];
      }
    });
  }

  Future getAllProducts() async {
    return await HomeApis().getAllProducts().then((value) {
      if(value.serverStatusCode == 200) {
        var json = jsonDecode(value.responseBody!);
        allProducts.value = json['data'];
      }
    });
  }

  Future getStoresList() async {
    return await HomeApis().getStores().then((value) {
      if (value.serverStatusCode == 200) {
        var jsonData = jsonDecode(value.responseBody!);
        storesList.value = jsonData['data'];
      }
    });
  }

  double getDistance(dynamic b1, dynamic b2) {
    if (b1 != null && b2 != null) {
      double totalKms = Geolocator.distanceBetween(
              customerAddControl.userCurrentCoordinates.latitude, customerAddControl.userCurrentCoordinates.longitude, double.parse(b1), double.parse(b2)) /
          1000;
      return totalKms;
    } else {
      return 0.0;
    }
  }

  List findNearestStores() {
    List b = [];
    for (var element in storesList) {
      b.add({"restData": element, "distanceMeters": getDistance(element['latitude'], element['longitude'])});
    }
    b.sort(
      (a, b) {
        if (b['distanceMeters'] != 0.0) {
          return a['distanceMeters'].compareTo(b['distanceMeters']);
        } else {
          return 0;
        }
      },
    );
    return b;
  }

  void onViewStoreDetail(BuildContext context,int index,String imagePath) async {
    try {
      context.loaderOverlay.show();
      await HomeApis().getStoreProductsById(customerHomeControl.storesList.value[index]['id'].toString()).then((value) async {
        if (value.serverStatusCode == 200) {
          var jsonData = jsonDecode(value.responseBody!);
          customerHomeControl.storeProductList.value = jsonData['data'];
          await HomeApis().getStoreCategoriesById(customerHomeControl.storesList.value[index]['id'].toString()).then((value1) {
            context.loaderOverlay.hide();
            if (value1.serverStatusCode == 200) {
              var jsonData1 = jsonDecode(value1.responseBody!);
              customerHomeControl.storeCatList.value = jsonData1['data'];
              customerHomeControl.storeNewProductList.value.clear();
              customerHomeControl.storeNewProductList.value = List.from(customerHomeControl.storeProductList.value);
              customerHomeControl.isSearchEnabled.value = false;
              Get.to(
                  StoreView(
                      storeName: customerHomeControl.storesList.value[index]['shop_name'].toString(),
                      data: customerHomeControl.storesList.value[index],
                      storeImage: imagePath),
                  transition: Transition.cupertino);
            } else {
              context.loaderOverlay.hide();
            }
          });
        } else {
          context.loaderOverlay.hide();
        }
      });
    } catch (e) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Something went wrong!"),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 1),
      ));
      // TODO
    }
  }

  var drawerController = AdvancedDrawerController().obs;
  Rx<DateTime> pre_backpress = DateTime.now().obs;

  void onPageChanged(int value) {
    currentIndex.value = value;
  }

  onCategoryPressed() {
    Get.to(() => const SeeAllProducts());
  }

  onDrawerPressed() {
    drawerController.value.showDrawer();
  }
}
