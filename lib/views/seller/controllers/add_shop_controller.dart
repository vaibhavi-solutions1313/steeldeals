import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:services_provider_application/helpers/network_helper.dart' as NN;
import '../../../apis/seller/shop_related.dart';
import '../../../main.dart';

class AddShopController extends GetxController {
  TextEditingController shopName = TextEditingController();
  TextEditingController shopDescription = TextEditingController();
  TextEditingController shopNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController openTimeTEC = TextEditingController();
  TextEditingController closeTimeTEC = TextEditingController();
  TextEditingController storeOpenTime = TextEditingController();
  TextEditingController storeCloseTime = TextEditingController();
  var shopPic = "".obs;
  var isShopOpen = false.obs;
  var isGeneralReadModeOn = true.obs;
  var isTimingsReadModeOn = true.obs;
  bool isShopProfilePicSelected = false;
  String shopProfilePicPath = "";

  var selectedShopImages = [].obs;
  var selectedBannerImages = [].obs;
  var selectedVideos = [].obs;
  final shopForm = GlobalKey<FormState>();

  Future<String> openTimeSelector(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 0, minute: 0));
    if (picked != null) {
      return "${picked.hour}:${picked.minute}";
    } else {
      return "";
    }
  }

  Future<File?> selectDocument() async {
    isShopProfilePicSelected = false;
    shopProfilePicPath = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      isShopProfilePicSelected = true;
      shopProfilePicPath = file.path;
      return file;
    } else {
      return null;
      // User canceled the picker
    }
  }

  Future<NN.Response> createShop() async {
    return ShopRelate().createShop(shopName.text, shopNumber.text, shopDescription.text, address.text, openTimeTEC.text, closeTimeTEC.text, phoneNumber.text,
        selectedShopImages.join(','), selectedBannerImages.join(","), selectedVideos.join(","));
  }

  Future getShopTimings() async {
    return await ShopRelate().getShopTimings().then((value) {
      if (value.serverStatusCode == 200) {
        var jsonData = jsonDecode(value.responseBody!);
        storeOpenTime.text = jsonData['data']['open_time'];
        storeCloseTime.text = jsonData['data']['close_time'];
      }
    });
  }

  Future<bool> getShopInfo() async {
    return await ShopRelate().getShopInfo().then((value) async {
      var json = jsonDecode(value.responseBody!);
      if (value.serverStatusCode == 200) {
        homeSellerController.shopInfo.value = json['data'];
        shopPic.value = json['data']['image'][0] ?? "";
        if (json['data']['is_online'] == 1) {
          isShopOpen.value = true;
          homeSellerController.isStoreCreated.value = true;
        } else {
          isShopOpen.value = false;
          homeSellerController.isStoreCreated.value = false;
        }
        shopName.text = json['data']['shop_name'];
        shopDescription.text = json['data']['description'];
        shopNumber.text = json['data']['shop_number'];
        phoneNumber.text = json['data']['mobile'];
        address.text = json['data']['address'];
        customerAddControl.addressDraggedCoordinates.value = LatLng(double.parse(json['data']['latitude'].toString()), double.parse(json['data']['longitude'].toString()));
      }
      return isShopOpen.value;
    });
  }
}
