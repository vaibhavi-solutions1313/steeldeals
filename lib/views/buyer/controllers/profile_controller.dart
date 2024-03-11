import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:services_provider_application/constants.dart';
import 'package:services_provider_application/apis/buyer/profile_apis.dart';

import '../../../apis/buyer/addresses_apis.dart';
import '../../../main.dart';

class CustomerProfileController extends GetxController {
  var currentProfilePic = "".obs;
  TextEditingController nameControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController countryControl = TextEditingController();
  TextEditingController cityControl = TextEditingController();
  TextEditingController stateControl = TextEditingController();
  TextEditingController pinCodeControl = TextEditingController();
  TextEditingController panCardControl = TextEditingController();
  TextEditingController gstControl = TextEditingController();
  TextEditingController cinControl = TextEditingController();
  TextEditingController iecControl = TextEditingController();
  TextEditingController aadharControl = TextEditingController();

  // String profilePicPath = "";
  String panPath = "";
  String gstPath = "";
  String aadharPath = "";
  String cinPath = "";
  String iecPath = "";

  var tempPic = File("").obs;

  void selectProfilePic() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      tempPic.value = File(image.path);
      // profilePicPath = image.path;
    }
  }

  Future getProfileFromServer() async {
    await ProfileApis().getProfileInfo().then((value) {
      box.write(Constants.USERDATA, jsonDecode(value.responseBody!)['data']);
      try {
        if (box.read(Constants.USERDATA)['profile'] != null) {
          currentProfilePic.value = box.read(Constants.USERDATA)['profile'];
        }
      } catch (e) {
        // TODO
      }
      try {
        if (box.read(Constants.USERDATA)['profile_pic'] != null) {
          currentProfilePic.value = box.read(Constants.USERDATA)['profile_pic'];
        }
      } catch (e) {
        // TODO
      }
      nameControl.text = box.read(Constants.USERDATA)['name'];
      emailControl.text = box.read(Constants.USERDATA)['email'];
      countryControl.text = box.read(Constants.USERDATA)['country'];
      cityControl.text = box.read(Constants.USERDATA)['city'];
      stateControl.text = box.read(Constants.USERDATA)['state'];
      pinCodeControl.text = box.read(Constants.USERDATA)['pin_code'];
      panCardControl.text = box.read(Constants.USERDATA)['pan_card'];
      gstControl.text = box.read(Constants.USERDATA)['gst_number'];
      cinControl.text = box.read(Constants.USERDATA)['cin_number'];
      iecControl.text = box.read(Constants.USERDATA)['iec_number'];
      aadharControl.text = box.read(Constants.USERDATA)['aadhar_number'];
    });
  }

  Future updateProfile(BuildContext context) async {
    context.loaderOverlay.show();
    try {
      await ProfileApis()
          .updateProfile(nameControl.text, countryControl.text, cityControl.text, stateControl.text, pinCodeControl.text, panCardControl.text, gstControl.text,
              cinControl.text, aadharControl.text, iecControl.text, tempPic.value, panPath, gstPath, aadharPath, cinPath, iecPath)
          .then((value) {
        if (value.serverStatusCode == 200) {
          context.loaderOverlay.hide();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Profile Updated"),
            duration: Duration(milliseconds: 1000),
          ));
          box.write(Constants.USERDATA, jsonDecode(value.responseBody!)['data']);
          if (box.read(Constants.USERDATA)['profile'] != null) {
            currentProfilePic.value = box.read(Constants.USERDATA)['profile'];
          }
          if (box.read(Constants.USERDATA)['profile_pic'] != null) {
            currentProfilePic.value = box.read(Constants.USERDATA)['profile_pic'];
          }
          currentProfilePic.value = box.read(Constants.USERDATA)['profile'];
          nameControl.text = box.read(Constants.USERDATA)['name'];
          emailControl.text = box.read(Constants.USERDATA)['email'];
          countryControl.text = box.read(Constants.USERDATA)['country'];
          cityControl.text = box.read(Constants.USERDATA)['city'];
          stateControl.text = box.read(Constants.USERDATA)['state'];
          pinCodeControl.text = box.read(Constants.USERDATA)['pin_code'];
          panCardControl.text = box.read(Constants.USERDATA)['pan_card'];
          gstControl.text = box.read(Constants.USERDATA)['gst_number'];
          cinControl.text = box.read(Constants.USERDATA)['cin_number'];
          iecControl.text = box.read(Constants.USERDATA)['iec_number'];
          aadharControl.text = box.read(Constants.USERDATA)['aadhar_number'];
          getProfileInfoFromLocal();
          Future.delayed(const Duration(milliseconds: 2000), () {
            Get.back();
          });
        }
      });
    } catch (e) {
      context.loaderOverlay.hide();
      // TODO
    }
  }

  void getProfileInfoFromLocal() async {
    tempPic.value = File("");
    if (box.read(Constants.USERDATA)['profile_pic'] != null) {
      currentProfilePic.value = box.read(Constants.USERDATA)['profile_pic'] ?? "";
    }
    if (box.read(Constants.USERDATA)['profile'] != null) {
      currentProfilePic.value = box.read(Constants.USERDATA)['profile'] ?? "";
    }

    nameControl.text = box.read(Constants.USERDATA)['name'];
    emailControl.text = box.read(Constants.USERDATA)['email'];
    gstControl.text = box.read(Constants.USERDATA)['gst_number'];
    aadharControl.text = box.read(Constants.USERDATA)['aadhar_number'] ?? "";
    cinControl.text = box.read(Constants.USERDATA)['cin_number'];
    countryControl.text = box.read(Constants.USERDATA)['country'];
    stateControl.text = box.read(Constants.USERDATA)['state'];
    cityControl.text = box.read(Constants.USERDATA)['city'];
    pinCodeControl.text = box.read(Constants.USERDATA)['pin_code'];
  }

  /// ADDRESS RELATED
  var addressList = [].obs;
  Future fetchAddressList() async {
    return await AddressesApis().getAddresses().then((value) {
      if (value.serverStatusCode == 200) {
        var jsonData = jsonDecode(value.responseBody!)['data'];
        addressList.value = jsonData;
      }
    });
  }

  Map findDefaultAddress() {
    return addressList.firstWhereOrNull((p0) => p0['is_default'] == 1);
  }

  void rateThisApp(BuildContext context) async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      try {
        await inAppReview.requestReview();
      } catch (e) {
        inAppReview.openStoreListing(appStoreId: '...', microsoftStoreId: '...');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("In App Review is under cool down. Redirecting to App Store.")));
      }
    } else {
      inAppReview.openStoreListing(appStoreId: '...', microsoftStoreId: '...');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("In App Review is under cool down. Redirecting to App Store.")));
    }
  }
}
