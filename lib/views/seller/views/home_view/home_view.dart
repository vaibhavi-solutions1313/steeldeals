import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/views/seller/views/home_view/tabs_view/menu_tab.dart';
import 'package:services_provider_application/views/seller/views/home_view/tabs_view/my_orders_tab.dart';
import 'package:services_provider_application/views/seller/views/home_view/tabs_view/product_listing.dart';
import 'package:services_provider_application/views/seller/views/home_view/tabs_view/home_tab.dart';
import '../../../../main.dart';
import '../../controllers/seller_home_controller.dart';
import 'tabs_view/profile_tab.dart';

class SellerHomeView extends StatefulWidget {
  const SellerHomeView({Key? key}) : super(key: key);

  @override
  State<SellerHomeView> createState() => _SellerHomeViewState();
}

class _SellerHomeViewState extends State<SellerHomeView> {
  final homeControl = Get.put(SellerHomeController());

  @override
  void initState() {
    if (homeControl.sellerHomePageController.hasClients) homeControl.sellerHomePageController.jumpTo(0);
    homeControl.currentNavIndex.value = 0;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFE5E5E5),
      body: PageView(
        controller: homeControl.sellerHomePageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [SellerHomeTab(), SellerOrdersTab(), ShopListingTab(), SellerProfileTab(), SellerMenuTab()],
      ),
      bottomNavigationBar: Obx(() => homeSellerController.isStoreCreated.value == true
          ? Theme(
              data: ThemeData(
                useMaterial3: true,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: Color(0xFF213C63),
                    unselectedLabelStyle: TextStyle(color: Colors.white38),
                    unselectedIconTheme: IconThemeData(color: Color(0xFFF5951D).withOpacity(0.5)),
                    selectedIconTheme: IconThemeData(color: Color(0xFFF5951D)),
                    selectedLabelStyle: TextStyle(color: Colors.black54)),
              ),
              child: BottomNavigationBar(
                iconSize: 24.sp,
                selectedFontSize: 16.sp,
                type: BottomNavigationBarType.shifting,
                onTap: (value) {
                  homeControl.sellerHomePageController.jumpToPage(value);
                  homeControl.currentNavIndex.value = value;
                },
                currentIndex: homeControl.currentNavIndex.value,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                    backgroundColor: Color(0xFF213C63),
                  ),
                   BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_basket_sharp),
                    label: "My Orders",
                    backgroundColor: Color(0xFF213C63),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: "Product List",
                    backgroundColor: Color(0xFF213C63),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: "Account",
                    backgroundColor: Color(0xFF213C63),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.more),
                    label: "More",
                    backgroundColor: Color(0xFF213C63),
                  ),
                ],
              ),
            )
          : Row()),
    );
  }
}
