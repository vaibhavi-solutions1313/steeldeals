import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/main.dart';
import 'package:services_provider_application/views/chat_views/chat_list_view.dart';
import 'package:services_provider_application/views/seller/views/menu_views/add_category.dart';
import 'package:services_provider_application/views/seller/views/menu_views/add_product/add_stock.dart';
import 'package:services_provider_application/views/terms_condition_view.dart';

import '../../../../splash_view.dart';
import '../../custom_size_views/custom_size_list_view.dart';
import '../../menu_views/add_product/add_new_product.dart';
import '../../menu_views/bargain_views/bargain_lists.dart';
import 'add_more_product_size.dart';

class SellerMenuTab extends StatefulWidget {
  const SellerMenuTab({Key? key}) : super(key: key);

  @override
  State<SellerMenuTab> createState() => _SellerMenuTabState();
}

class _SellerMenuTabState extends State<SellerMenuTab> {
  List<Map> menuItems = [
    {"icon": Icons.add, "title": "Add New Product"},
    {"icon": Icons.shopping_bag, "title": "Add Product Stock"},
    {"icon": Icons.photo_size_select_large, "title": "Add More Product Size"},
    {"icon": Icons.category, "title": "Add Category"},
    {"icon": Icons.balance, "title": "Bargain Requests"},
    {"icon": Icons.photo_size_select_small_rounded, "title": "Custom Size Requests"},
    {"icon": Icons.chat_bubble, "title": "Chat with Buyers"},
    {"icon": Icons.rule, "title": "Terms & Conditions"},
    {"icon": Icons.info, "title": "About Us"},
    {"icon": Icons.login_outlined, "title": "Logout"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black.withOpacity(0.6),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF0FAFF),
              Color(0xFFFFF7EE),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.sp),
                    ),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
                      child: Image.asset(
                        'assets/buyer/images/logo.png',
                        width: Get.width / 2.5,
                        height: Get.width / 2.5,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF213C63),
                      shape: BoxShape.rectangle, // BoxShape.circle or BoxShape.retangle
                      //color: const Color(0xFF66BB6A),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                        ),
                      ]),
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: Get.width < 600 ? 3: 4,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 15.sp),
                    children: List.generate(
                      menuItems.length,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.all(10.0.sp),
                          child: InkWell(
                            onTap: () {
                              if (index == 0) {
                                Get.to(AddProductAndSizeView(), transition: Transition.downToUp);
                              }
                              if (index == 1) {
                                Get.to(SetAvailabilityView(), transition: Transition.downToUp);
                              }
                              if (index == 2) {
                                Get.to(AddMoreProductSize(), transition: Transition.downToUp);
                              }
                              if (index == 3) {
                                Get.to(AddCategory(), transition: Transition.downToUp);
                              }
                              if (index == 4) {
                                Get.to(SellerBargainView(), transition: Transition.downToUp);
                              }
                              if (index == 5) {
                                Get.to(CustomSizeListView(), transition: Transition.downToUp);
                              }
                              if (index == 6) {
                                Get.to(ChatListView(), transition: Transition.downToUp);
                              }
                              if (index == 7) {
                                Get.to(TermsAndCondition(), transition: Transition.downToUp);
                              }
                              if (index == 8) {
                                Get.to(TermsAndCondition(), transition: Transition.downToUp);
                              }
                              if (index == 9) {
                                box.erase();
                                Get.offAll(SplashView());
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 4.sp),
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0.sp),
                                ),
                              ),
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      menuItems[index]['icon'],
                                      size: 30.sp,
                                      color: Color(0xFFF5951D),
                                    ),
                                    SizedBox(
                                      height: 5.sp,
                                    ),
                                    Text(
                                      menuItems[index]['title'],
                                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
