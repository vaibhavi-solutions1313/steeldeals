import 'dart:convert';

import 'package:get/get.dart';
import '../constants.dart';
import '../apis/config_api.dart';
import '../main.dart';
import '../views/buyer/views/home_with_nav_view.dart';
import '../views/onboard/onboarding_one.dart';
import '../views/seller/views/home_view/home_view.dart';

class SplashController extends GetxController {
  var appInfo = {}.obs;

  Future getAppInfo() async {
    return await ConfigApis().getAppInfo().then((value) {
      if (value.serverStatusCode == 200) {
        var jsonData = jsonDecode(value.responseBody!);
        appInfo.value = jsonData['data'];
      }
    });
  }

  Future loadDataAndNavigate() async {
    print("box.read(Constants.USERTYPE)");
    print(box.read(Constants.USERTYPE));
    var userData = box.read(Constants.USERDATA) ?? {};
    if (userData == {}) {
      box.erase();
    }
    await Future.delayed(const Duration(milliseconds: 500), () async {
      if (box.read(Constants.BEARERTOKEN) != null) {
        myConstants.bearerToken = box.read(Constants.BEARERTOKEN) ?? "";
        if (box.read(Constants.USERTYPE) == 1) {
          await loadBuyerData(); // AUTH USERS DATA FETCH;
          try {
            await customerProfileControl.getProfileFromServer().then((value) {
              Get.offAll(HomeViewNav());
            });
          } catch (e) {
            box.erase();
            Get.offAll(OnBoardingOne());
            // TODO
          }
        } else if (box.read(Constants.USERTYPE) == 2) {
          await addShopController.getShopInfo().then((value) async {
            if (value) {
              await Future.wait([homeSellerController.getSellerBanners()]);
            }
          });

          Get.offAll(SellerHomeView());
        } else {
          Get.offAll(OnBoardingOne());
        }
      } else {
        Get.offAll(OnBoardingOne());
      }
    });

    // if (box.read(Constants.USERTYPE) == 0 && box.read(Constants.USERDATA) != null) {
    //   await buyerProfileControl.getProfileFromServer();
    //   if (box.read(Constants.USERTYPE) == 0 && box.read(Constants.USERDATA) != null) {
    //     Get.offAll(HomeViewNav());
    //   } else if (box.read(Constants.USERTYPE) == 1 && box.read(Constants.USERDATA) != null) {
    //     Get.offAll(SellerHomeView());
    //   } else {
    //     Get.offAll(OnBoardingOne());
    //   }
    // }
  }

  Future loadBuyerData() async {
    await Future.wait([
      getAppInfo(),
      catControl.getCategories(),
      customerProfileControl.fetchAddressList(),
      transportControl.getTransportList(),
      customerAddControl.getAddressFromServer(),
      customerHomeControl.getBannersList(),
      customerHomeControl.getStoresList(),
      customerHomeControl.getAllProducts(),
    ]);
    sizeController.getPreDefinedSizes();
    await cartController.getCartItems();
  }

  Future loadSellerData() async {
    await addShopController.getShopInfo().then((value) async {
      if (value) {
        await Future.wait([getAppInfo(), homeSellerController.getSellerBanners()]);
      }
    });
    sizeController.getPreDefinedSizes();
  }
}
