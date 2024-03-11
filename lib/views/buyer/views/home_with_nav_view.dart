import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/views/buyer/views/home/cart_view.dart';
import 'package:services_provider_application/views/buyer/views/home/profile_view.dart';
import 'package:services_provider_application/views/buyer/views/home/transport_view.dart';
import '../../../constants.dart';
import '../../../main.dart';
import '../../../modules/account_information/account_info_form_view.dart';
import 'home/home_view.dart';

class HomeViewNav extends StatefulWidget {
  const HomeViewNav({Key? key}) : super(key: key);

  @override
  State<HomeViewNav> createState() => _HomeViewNavState();
}

class _HomeViewNavState extends State<HomeViewNav> {
  bool isFirst = true;

  @override
  void initState() {
    if (isFirst == true) {
      Future.delayed(const Duration(milliseconds: 500), () {
        customerHomeControl.getUserLocation();
        if (customerProfileControl.aadharControl.text.isEmpty) {
          Get.defaultDialog(
              title: 'Information',
              content: Text(
                "For smooth experience, please fill all the account details.",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              confirm: TextButton(
                  onPressed: () {
                    Get.back();
                    customerHomeControl.selectedTab.value = 3;
                    customerHomeControl.pageController.jumpToPage(3);
                    FocusManager.instance.primaryFocus?.unfocus();
                    Get.to(AccountInfoView(), transition: Transition.rightToLeft)?.then((value) {
                      setState(() {});
                    });
                  },
                  child: Text("Okay")),
              cancel: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Remind me later")));
        }
        isFirst = false;
      });
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // customerHomeControl.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        if (customerHomeControl.drawerController.value.value.visible) {
          customerHomeControl.drawerController.value.hideDrawer();
          return await false;
        } else {
          final timegap = DateTime.now().difference(customerHomeControl.pre_backpress.value);
          final cantExit = timegap >= const Duration(seconds: 2);
          customerHomeControl.pre_backpress.value = DateTime.now();
          if (cantExit) {
            //show snackbar
            Constants.showSnackBar('Press Back button again to Exit');
            return false;
          } else {
            return true;
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: customerHomeControl.pageController,
              onPageChanged: (v) {
                customerHomeControl.selectedTab.value = v;
              },
              children: [HomeView(), TransportView(), CartView(), ProfileView()],
            ),
            Positioned(
              bottom: 0,
              width: mediaWidth,
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0.sp, vertical: 15.0.sp),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.sp),
                    child: Container(
                      // color: Color(0xFF11111B),
                      color: Color(0xFF213C63),
                      // padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Obx(
                        () => Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15.sp),
                                color: customerHomeControl.selectedTab.value == 0 ? Color(0xFFD9D9D9) : Colors.transparent,
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      customerHomeControl.selectedTab.value = 0;
                                      customerHomeControl.pageController.jumpToPage(0);
                                    },
                                    icon: Icon(Icons.home, size: 22.sp, color: customerHomeControl.selectedTab.value == 0 ? Color(0xFFF5951D) : Colors.white54),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15.sp),
                                color: customerHomeControl.selectedTab.value == 1 ? Color(0xFFD9D9D9) : Colors.transparent,
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      customerHomeControl.selectedTab.value = 1;
                                      customerHomeControl.pageController.jumpToPage(1);
                                      FocusManager.instance.primaryFocus?.unfocus();
                                    },
                                    icon: Icon(Icons.directions_transit, size: 22.sp, color: customerHomeControl.selectedTab.value == 1 ? Color(0xFFF5951D) : Colors.white54),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15.sp),
                                color: customerHomeControl.selectedTab.value == 2 ? Color(0xFFD9D9D9) : Colors.transparent,
                                child: Center(
                                  child: Stack(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          customerHomeControl.selectedTab.value = 2;
                                          customerHomeControl.pageController.jumpToPage(2);
                                        },
                                        icon: Icon(Icons.shopping_bag, size: 22.sp, color: customerHomeControl.selectedTab.value == 2 ? Color(0xFFF5951D) : Colors.white54),
                                      ),
                                      if (cartController.cartItemsList.isNotEmpty)
                                        Positioned(
                                          right: 5,
                                          top: 0,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(4),
                                            child: Container(
                                              color: Colors.red,
                                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                              child: Text(
                                                cartController.cartItemsList.length.toString(),
                                                style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Expanded(
                            //   child: Container(
                            //     padding: const EdgeInsets.symmetric(vertical: 12),
                            //     color: buyerHomeControl.selectedTab.value == 3 ? Color(0xFFD9D9D9) :Colors.transparent,
                            //     child: IconButton(
                            //       onPressed: () {
                            //         buyerHomeControl.selectedTab.value = 3;
                            //         pageController.jumpToPage(3);
                            //       },
                            //       icon: Icon(Icons.settings,size: 30, color: buyerHomeControl.selectedTab.value == 3 ? Color(0xFFF5951D) : Colors.white54),
                            //     ),
                            //   ),
                            // ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15.sp),
                                color: customerHomeControl.selectedTab.value == 3 ? Color(0xFFD9D9D9) : Colors.transparent,
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      customerHomeControl.selectedTab.value = 3;
                                      customerHomeControl.pageController.jumpToPage(3);
                                      FocusManager.instance.primaryFocus?.unfocus();
                                    },
                                    icon: Icon(Icons.menu, size: 22.sp, color: customerHomeControl.selectedTab.value == 3 ? Color(0xFFF5951D) : Colors.white54),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
