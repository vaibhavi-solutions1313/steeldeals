import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../apis/buyer/addresses_apis.dart';

class CustomerAddressController extends GetxController {
  MapController mapController = MapController();
  LatLng userCurrentCoordinates = LatLng(30.7333, 76.7794);
  var addressDraggedCoordinates = LatLng(30.7333, 76.7794).obs;
  var userLocalityDetected = "Not Provided".obs;
  var isCurrentLocationFound = false.obs;
  var addressList = [].obs;

  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController pincode = TextEditingController();
  var toggleDefaultAddSwitch = false.obs;

  Future<String> getAddressByCoordinates(LatLng ll) async {
    final coordinates = Coordinates(ll.latitude, ll.longitude);
    List totalAddressFound = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    Address address = totalAddressFound.first;
    userLocalityDetected.value = address.locality.toString();
    print(address.addressLine.toString() + ', ' + address.locality.toString());
    if(totalAddressFound.isNotEmpty) {
      isCurrentLocationFound.value = true;
    } else {
      isCurrentLocationFound.value = false;
    }
    return userLocalityDetected.value;
  }

  Future<Position> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.requestPermission();
      return await Geolocator.getCurrentPosition();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
        return await Geolocator.getCurrentPosition();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      await Geolocator.requestPermission();
      return await Geolocator.getCurrentPosition();
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future getAddressFromServer() async {
    return await AddressesApis().getAddresses().then((value) {
      if (value.serverStatusCode == 200) {
        var jsonData = jsonDecode(value.responseBody!);
        addressList.value = jsonData['data'];
        reOrderAddress(); // ORDER ADDRESS BY DEFAULT FIRST.
      }
    });
  }
  
  Map defaultAddressMap() {
    var found = addressList.value.firstWhereOrNull((element) => element['is_default'] == 1);
    return found;
  }

  /// ADDRESS PAGE RELATED
  void addressOnDragOrOnFetch() async {
    address1.clear();
    address2.clear();
    landmark.clear();
    city.clear();
    state.clear();
    pincode.clear();
    final coordinates = Coordinates(addressDraggedCoordinates.value.latitude, addressDraggedCoordinates.value.longitude);
    List totalAddressFound = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    Address address = totalAddressFound.first;

    if (address.featureName != null)
      address1.value = address1.value.copyWith(
        text: address.featureName,
        selection: TextSelection.collapsed(offset: address.featureName!.length),
      );

    if (address.thoroughfare != null)
      address2.value = address2.value.copyWith(
        text: address.thoroughfare,
        selection: TextSelection.collapsed(offset: address.thoroughfare!.length),
      );

    if (address.adminArea != null)
      state.value = state.value.copyWith(
        text: address.adminArea,
        selection: TextSelection.collapsed(offset: address.adminArea!.length),
      );

    if (address.locality != null)
      city.value = city.value.copyWith(
        text: address.locality,
        selection: TextSelection.collapsed(offset: address.locality!.length),
      );
    if (address.postalCode != null)
      pincode.value = pincode.value.copyWith(
        text: address.postalCode,
        selection: TextSelection.collapsed(offset: address.postalCode!.length),
      );
  }

  Future deleteAddress(BuildContext context, int id) async {
    context.loaderOverlay.show();
    await AddressesApis().deleteAddress(id.toString()).then((value) async {
      context.loaderOverlay.hide();
      if (value.serverStatusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deleted Successfully.")));
        await AddressesApis().getAddresses().then((value) {
          context.loaderOverlay.hide();
          if (value.serverStatusCode == 200) {
            var jsonData = jsonDecode(value.responseBody!);
            addressList.value = jsonData['data'];
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Address book refreshed.")));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unable to refresh address book.")));
          }
        }).onError((error, stackTrace) {
          context.loaderOverlay.hide();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong.")));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong, try again.")));
      }
    }).onError((error, stackTrace) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong.")));
    });
  }

  Future updateAddressToServer(BuildContext context, String addressId, String address1, String address2, String landmark, String city, String state, String pinCode,
      String isDefault, LatLng coordinates) async {
    context.loaderOverlay.show();
    try {
      await AddressesApis().updateAddress(addressId, address1, address2, landmark, city, state, pinCode, isDefault, coordinates).then((value) async {
        context.loaderOverlay.hide();
        print(value.responseBody);
        if (value.serverStatusCode == 200) {
          await AddressesApis().getAddresses().then((value1) {
            context.loaderOverlay.hide();
            if (value.serverStatusCode == 200) {
              var jsonData = jsonDecode(value1.responseBody!);
              addressList.value = jsonData['data'];
              reOrderAddress(); // ORDER ADDRESS BY DEFAULT FIRST.
              Get.back(); // BACK TO ADDRESS LIST VIEW.
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unable to refresh address book.")));
            }
          }).onError((error, stackTrace) {
            context.loaderOverlay.hide();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong.")));
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Address updated successfully!")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong.")));
        }
      });
    } catch (e) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong.")));
      // TODO
    }
  }

  Future addNewAddressToServer(BuildContext context, String addressId, String address1, String address2, String landmark, String city, String state, String pinCode,
      String isDefault, LatLng coordinates) async {
    context.loaderOverlay.show();
    try {
      await AddressesApis().addAddress(address1, address2, landmark, city, state, pinCode, isDefault, coordinates).then((value) async {
        context.loaderOverlay.hide();
        print(value.responseBody);
        if (value.serverStatusCode == 200) {
          await AddressesApis().getAddresses().then((value1) {
            context.loaderOverlay.hide();
            if (value.serverStatusCode == 200) {
              var jsonData = jsonDecode(value1.responseBody!);
              addressList.value = jsonData['data'];
              reOrderAddress(); // ORDER ADDRESS BY DEFAULT FIRST.
              Get.back(); // BACK TO ADDRESS LIST VIEW.
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unable to refresh address book.")));
            }
          }).onError((error, stackTrace) {
            context.loaderOverlay.hide();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong.")));
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Address created successfully!")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong.")));
        }
      });
    } catch (e) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong.")));
      // TODO
    }
  }

  void reOrderAddress() {
    addressList.sort(
      (a, b) {
        if (a['is_default'] == 1) {
          return -1;
        } else {
          return 1;
        }
      },
    );
  }
}
