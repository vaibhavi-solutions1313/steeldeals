import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../Utils/constants.dart';
import '../../apis/buyer/home_apis.dart';
import '../../main.dart';
import '../../views/buyer/views/cart_view.dart';
import '../../views/buyer/views/subcat_view.dart';
import '../../views/products_listing.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    catControl.getCategories();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cartController.getCartItems(); /// REFRESH CART ITEMS FOR CART ICON.
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF1FAFF),
                  Color(0xFFFFF7EE),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (() => buyerHomeControl.onDrawerPressed()),
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SvgPicture.asset('assets/menu.svg'),
                        ),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/buyer/images/logo_flat.png',
                            width: 120,
                          )),
                      // Row(
                      //   children: [
                      //     InkWell(
                      //       onTap: (() => controller.onDrawerPressed()),
                      //       child: Container(
                      //         width: 24,
                      //         height: 24,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(8),
                      //         ),
                      //         child: SvgPicture.asset('assets/menu.svg'),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Text(
                      //       'Hey, sambhav',
                      //       style: TextStyle(
                      //           fontSize: 16, fontWeight: FontWeight.w500),
                      //     )
                      //   ],
                      // ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0x0c000000),
                                width: 1,
                              ),
                              color: Color(0xfff6f6f6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: SvgPicture.asset('assets/bell.svg'),
                            ),
                          ),
                          SizedBox(width: 15),
                          InkWell(
                            onTap: () {
                              Get.to(CartView(),transition: Transition.rightToLeft);
                            },
                            child: Badge(
                              label: Obx(() => Text(cartController.cartItemsList.length.toString())),
                              largeSize: 12,
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Color(0x0c000000),
                                    width: 1,
                                  ),
                                  color: Color(0xfff6f6f6),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: SvgPicture.asset('assets/cart.svg'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    textAlign: TextAlign.start,
                    controller: buyerHomeControl.searchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Search Products',
                        hintStyle: const TextStyle(fontSize: 16, color: Colors.black45),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if(buyerHomeControl.searchController.text.isNotEmpty) {
                              context.loaderOverlay.show();
                              try {
                                HomeApis().searchProduct(buyerHomeControl.searchController.text.toString()).then((value) {
                                  context.loaderOverlay.hide();
                                  if (value.serverStatusCode == 200) {
                                    var jsonData = jsonDecode(value.responseBody!);
                                    if(jsonData['data'].isNotEmpty) {
                                      productController.buyerProductList.value = jsonData['data'];
                                      Get.to(ProductsListingView(catName: buyerHomeControl.searchController.text,));
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Product Found.")));
                                    }
                                  }
                                });
                              } catch (e) {
                                context.loaderOverlay.hide();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
                                // TODO
                              }
                            }
                          },
                          icon: Icon(
                            Icons.search_outlined,
                            color: Colors.black,
                          ),
                        )
                        // fillColor: colorSearchBg,
                        ),
                  ),
                ),

                /**
                 * ? image slider
                 */

                ImageSlideshow(
                  width: double.infinity,
                  indicatorColor: Constants.primaryButtonColor,
                  initialPage: 0,
                  onPageChanged: (value) {
                    buyerHomeControl.onPageChanged(value);
                  },
                  autoPlayInterval: 3000,
                  isLoop: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage('https://2.wlimg.com/product_images/bc-full/dir_29/862362/iron-rods-1429612.jpg'), fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.made-in-china.com/2f0j00ozaYBUtcaCbd/Steel-Rebar-Deformed-Steel-Bar-Iron-Rods-for-Construction-Concrete-Building.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://img1.exportersindia.com/product_images/bc-full/dir_146/4377190/steel-rebar-deformed-steel-bar-iron-rods-from-1485076775-2696426.jpeg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )
                  ],
                ),

                /**
                 * ? category view
                 */

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Categories",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.40,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() => GridView.count(
                            crossAxisCount: 3,
                            childAspectRatio: .8,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 10),
                            children: List.generate(catControl.categories.value.length, (index) {
                              String catImgUrl = catControl.categories[index]['thumb'] ?? "";
                              return Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                shadowColor: Colors.black26.withOpacity(0.2),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: InkWell(
                                    onTap: () {
                                      print(catControl.categories.value[index]);
                                      // Get.defaultDialog(
                                      //   title: '',
                                      //   content: SizedBox(
                                      //     width: 300,
                                      //     child: Column(
                                      //       children: [
                                      //         TextButton(
                                      //           style: TextButton.styleFrom(
                                      //             padding: const EdgeInsets.symmetric(
                                      //                 horizontal: 45, vertical: 12),
                                      //             backgroundColor: const Color(0xFFF5951D),
                                      //           ),
                                      //           onPressed: () {
                                      //             Get.back();
                                      //             buyerHomeControl.onCategoryPressed();
                                      //           },
                                      //           child: const Text(
                                      //             "ISI-Brand",
                                      //             style:
                                      //             TextStyle(color: Colors.white),
                                      //           ),
                                      //         ),
                                      //         OutlinedButton(
                                      //           style: OutlinedButton.styleFrom(
                                      //             padding: const EdgeInsets.symmetric(
                                      //                 horizontal: 50),
                                      //           ),
                                      //           onPressed: () {
                                      //             Get.back();
                                      //             buyerHomeControl.onCategoryPressed();
                                      //           },
                                      //           child: const Text(
                                      //             "Non-ISI",
                                      //             style: TextStyle(
                                      //               color: Color(0xFFF5951D),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // );
                                      // controller.onCategoryPressed();
                                      if (catControl.categories[index]['subcategory'].isNotEmpty) {
                                        Get.to(
                                          SubCatView(
                                            data: catControl.categories[index]['subcategory'],
                                            title: catControl.categories[index]['name'],
                                          ),
                                        );
                                      } else {
                                        /// SHOW DIRECT PRODUCT
                                        Get.to(ProductsListingView(catId: catControl.categories[index]['id'].toString(),catName: catControl.categories[index]['name'].toString(),));
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                onError: (exception, stackTrace) => Image.asset("assets/ph.jpg"),
                                                image:
                                                    catImgUrl.isNotEmpty ? NetworkImage(catControl.categories[index]['thumb']) : AssetImage("assets/ph.jpg") as ImageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                              color: Constants.primaryButtonColor.withOpacity(.05),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          catControl.categories.value[index]['name'].toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            letterSpacing: 0.24,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
