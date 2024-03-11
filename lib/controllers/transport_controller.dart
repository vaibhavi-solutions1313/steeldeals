import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../apis/buyer/home_apis.dart';

class TransportController extends GetxController {
  var selectedTab = 0.obs;
  var transportList = [].obs;
  var searchedTransportList = [].obs;
  TextEditingController searchText = TextEditingController();

  Future getTransportList() async {
    return await HomeApis().getTransports().then((value) {
      if (value.serverStatusCode == 200) {
        var jsonData = jsonDecode(value.responseBody!);
        transportList.value = jsonData['data'];
        searchedTransportList.value = List.from(transportList.value);
      }
    });
  }

  void searchedText() {
    if (searchText.text.isNotEmpty) {
      var found = transportList
          .where((p0) =>
              p0['name'].toString().toLowerCase().contains(searchText.text.toLowerCase()) ||
              p0['city'].toString().toLowerCase().contains(searchText.text.toLowerCase()) ||
              p0['state'].toString().toLowerCase().contains(searchText.text.toLowerCase()) ||
              p0['pin_code'].toString().toLowerCase().contains(searchText.text.toLowerCase()) ||
              p0['address'].toString().toLowerCase().contains(searchText.text.toLowerCase()))
          .toList();
      searchedTransportList.value = List.from(found);
    } else {
      searchedTransportList.value = List.from(transportList.value);
    }
  }
}
