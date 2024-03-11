import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../apis/buyer/general_apis.dart';
import '../../../../constants.dart';
import '../../../../apis/buyer/home_apis.dart';
import '../../../../main.dart';
import '../notification_view.dart';
import '../product_detail/product_details_view.dart';
import '../sell_all_views/see_all_categories.dart';
import '../sell_all_views/see_all_stores.dart';
import '../sell_all_views/see_all_products.dart';
import '../widgets/city_selector.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    customerHomeControl.searchController.clear();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(customerHomeControl.bannerList[2]['banner']);
    print('${Constants.baseUrl}${customerHomeControl.bannerList[2]['banner']}');
    return Scaffold(
      body: Container(
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
        child: SafeArea(
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.sp),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.sp),
                      child: InkWell(
                        onTap: () {
                          context.loaderOverlay.show();
                          try {
                            GeneralApis().getCities().then((value) {
                              context.loaderOverlay.hide();
                              List jsonData = jsonDecode(value.responseBody!);
                              print(jsonData);
                              jsonData.sort((a, b) => a['name'].compareTo(b['name']));
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return MyAlertDialog(
                                    data: jsonData,
                                  );
                                },
                              );
                            });
                          } catch (e) {
                            context.loaderOverlay.hide();
                            // TODO
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('My Location', style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w600)),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    size: 18.sp,
                                    color: Colors.black54,
                                  ),
                                )
                              ],
                            ),
                            Obx(() =>
                                Text(customerAddControl.userLocalityDetected.value, style: TextStyle(fontSize: 14.sp, color: Colors.black45, fontWeight: FontWeight.w400)))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 18.0.sp),
                      child: InkWell(
                        onTap: () {
                          Get.to(NotificationView(), transition: Transition.cupertino);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Color(0x0c000000),
                              width: 1,
                            ),
                            color: Color(0xfff6f6f6),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5.sp),
                            child: SvgPicture.asset(
                              'assets/bell.svg',
                              color: Colors.orangeAccent,
                              width: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0.sp, vertical: 18.sp),
                child: TextField(
                  textAlign: TextAlign.start,
                  controller: customerHomeControl.searchController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      hintText: 'Search Products',
                      hintStyle: TextStyle(fontSize: 14.sp, color: Colors.black.withOpacity(0.7)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.all(16.sp),
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (customerHomeControl.searchController.text.isNotEmpty) {
                            context.loaderOverlay.show();
                            try {
                              HomeApis().searchProduct(customerHomeControl.searchController.text.toString()).then((value) {
                                context.loaderOverlay.hide();
                                if (value.serverStatusCode == 200) {
                                  var jsonData = jsonDecode(value.responseBody!);
                                  if (jsonData['data'].isNotEmpty) {
                                    customerProductDetailControl.buyerProductList.value = jsonData['data'];
                                    Get.to(SeeAllProducts(
                                      catName: customerHomeControl.searchController.text,
                                    ));
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
                          color: Colors.black.withOpacity(0.7),
                          size: 16.sp,
                        ),
                      )
                      // fillColor: colorSearchBg,
                      ),
                ),
              ),

              /**
               * ? image slider
               */

              Obx(
                () => ImageSlideshow(
                  width: double.infinity,
                  indicatorColor: Constants.primaryButtonColor,
                  initialPage: 0,
                  onPageChanged: (value) {
                    // buyerHomeControl.onPageChanged(value);
                  },
                  autoPlayInterval: 3000,
                  isLoop: false,
                  children: List.generate(
                      1,

                      /// TODO:// REMOVE STATIC INDEX OF BANNER
                      (index) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              height: Get.height / 4,
                              child: FadeInImage(
                                placeholder: AssetImage("assets/ph.jpg"),
                                imageErrorBuilder: (context, error, stackTrace) {
                                  return Image.asset("assets/ph.jpg");
                                },
                                fit: BoxFit.cover,
                                image: NetworkImage('${Constants.baseUrl}${customerHomeControl.bannerList[2]['banner']}'),
                              ),
                              decoration: BoxDecoration(
                                  // image: DecorationImage(
                                  //     image: NetworkImage(
                                  //       buyerHomeControl.bannerList[index]['banner'].toString(),
                                  //     ),
                                  //     fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(20.sp)),
                            ),
                          )),
                ),
              ),

              /**
               * ? category view
               */

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.40,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(()=>SeeAllCategoriesView(), transition: Transition.cupertino);
                          },
                          child: Text(
                            "See all",
                            style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.w600, fontSize: 16.sp),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: .8,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 10.sp),
                        children: List.generate(catControl.categories.value.length > 6 ? 6 : catControl.categories.value.length, (index) {
                          String catImgUrl = catControl.categories[index]['thumb'] ?? "";
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100, borderRadius: BorderRadius.circular(18), border: Border.all(width: 1.sp, color: Colors.grey.shade200)),
                              child: InkWell(
                                onTap: () {
                                  try {
                                    context.loaderOverlay.show();
                                    customerProductDetailControl.getBuyerProducts(catControl.categories[index]['id'].toString()).then((value) {
                                      context.loaderOverlay.hide();
                                      if (customerProductDetailControl.buyerProductList.length != 0) {
                                        Get.to(
                                            SeeAllProducts(
                                              catId: catControl.categories[index]['id'].toString(),
                                              catName: catControl.categories[index]['name'].toString(),
                                            ),
                                            transition: Transition.cupertino);
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text("No Products Found!"),
                                          duration: Duration(seconds: 1),
                                        ));
                                      }
                                    });
                                  } catch (e) {
                                    context.loaderOverlay.hide();
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text("Unable to fetch. retry!"),
                                      duration: Duration(seconds: 1),
                                    ));
                                    // TODO
                                  }
                                },
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Card(
                                        elevation: 3,
                                        color: Colors.white,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: FadeInImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(Constants.baseUrl+catImgUrl),
                                            placeholder: AssetImage("assets/ph.jpg"),
                                            imageErrorBuilder: (context, error, stackTrace) {
                                              return Center(child: Image.asset("assets/ph.jpg"));
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 4.0.sp),
                                      child: Text(
                                        catControl.categories.value[index]['name'].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          letterSpacing: 0.24,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18.0.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Explore Products",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.40,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        customerProductDetailControl.buyerProductList.value = List.from(customerHomeControl.allProducts);
                        Get.to(
                            SeeAllProducts(
                              isExploreProduct: true,
                              catName: 'All Products',
                            ),
                            transition: Transition.cupertino);
                      },
                      child: Text(
                        "See all",
                        style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.w600, fontSize: 16.sp),
                      ),
                    )
                  ],
                ),
              ),
              Obx(() => SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 18.sp),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        customerHomeControl.allProducts.length > 5 ? 5 : customerHomeControl.allProducts.length,
                        (index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 8.0.sp),
                            child: InkWell(
                              onTap: () {
                                Get.to(ProductDetailView(
                                  data: customerHomeControl.allProducts[index],
                                ));
                              },
                              // onLongPress: () {
                              //   /// TODO: PENDING ADD MAP
                              //   catControl.selectedSellerData.addAll({"abc": ""});
                              //   catControl.selectedIndex.value = index;
                              //   // Get.showSnackbar(GetSnackBar(message: 'Product selected successfully!',duration: Duration(seconds: 3),));
                              // },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100, borderRadius: BorderRadius.circular(18), border: Border.all(width: 1, color: Colors.grey.shade200)),
                                // color: catControl.selectedIndex.value == index ? Color(0xFFF5951D).withOpacity(0.2) : null,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0.sp),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: Get.width / 2.5,
                                        height: Get.width / 2.5,
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          child: FadeInImage(
                                            imageErrorBuilder: (context, error, stackTrace) {
                                              return Image.asset("assets/ph.jpg");
                                            },
                                            placeholder: AssetImage("assets/ph.jpg"),
                                            image: NetworkImage(
                                              customerHomeControl.allProducts[index]['instock'] != null
                                                  ? customerHomeControl.allProducts[index]['instock']['images'] != null
                                                      ? customerHomeControl.allProducts[index]['instock']['images'][0]
                                                      : ""
                                                  : "",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(customerHomeControl.allProducts[index]['name'].toString().toUpperCase(),
                                              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.black)),
                                        ],
                                      ),
                                      Text(
                                        customerHomeControl.allProducts[index]['instock'] != null ? "In Stock" : "Out of Stock",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: customerHomeControl.allProducts[index]['instock'] != null ? Colors.green : Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 2.sp,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.sp), border: Border.all(color: Colors.black26, width: 1)),
                                        padding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 4.sp),
                                        child: Text(
                                          "Shop ID: " + customerHomeControl.allProducts[index]['shop_id'].toString(),
                                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.black54),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.sp,
                                      ),
                                      customerHomeControl.allProducts[index]['instock'] != null
                                          ? Text('Price Starts From', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black54))
                                          : Row(),
                                      customerHomeControl.allProducts[index]['instock'] != null
                                          ? SizedBox(
                                              height: 2.sp,
                                            )
                                          : Row(),
                                      customerHomeControl.allProducts[index]['instock'] != null
                                          ? Text(
                                              '₹${customerHomeControl.allProducts[index]['instock']['basic_price'].toString()}',
                                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black87),
                                            )
                                          : Row(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.all(18.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            customerAddControl.isCurrentLocationFound.value == false ? "Explore Our Partners" : "Nearby Partners",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.40,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(SeeAllStoresView(), transition: Transition.cupertino);
                          },
                          child: Text(
                            "See all",
                            style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.w600, fontSize: 16.sp),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 18.sp,
                    ),
                    Obx(
                      () => Column(
                        children: List.generate(customerHomeControl.storesList.value.length > 6 ? 6 : customerHomeControl.storesList.value.length, (index) {
                          String catImgUrl = customerHomeControl.storesList.value[index]['image'][0] ?? "";
                          return Padding(
                            padding: EdgeInsets.all(5.sp),
                            child: InkWell(
                              onTap: () async {
                                customerHomeControl.onViewStoreDetail(context, index, catImgUrl);
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 45.sp,
                                    height: 45.sp,
                                    decoration: BoxDecoration(
                                      // color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(15.sp),
                                      border: Border.all(width: 0.25, color: Colors.grey.shade200),
                                    ),
                                    child: Card(
                                      
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15.sp),
                                        child: FadeInImage(
                                          image: NetworkImage(Constants.baseUrl+catImgUrl),
                                          placeholder: AssetImage("assets/ph.jpg"),
                                          imageErrorBuilder: (context, error, stackTrace) {
                                            return Center(child: Image.asset("assets/ph.jpg"));
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 15.0.sp, left: 18.sp),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            customerHomeControl.storesList.value[index]['shop_name'].toString(),
                                            style: TextStyle(color: Colors.black, fontSize: 18.sp, letterSpacing: 0.24, fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 8.sp,
                                          ),
                                          Row(
                                            children: [
                                              customerAddControl.isCurrentLocationFound.value == true
                                                  ? Flexible(
                                                      child: Text(
                                                        customerHomeControl.findNearestStores()[index]['restData']['address'] != null
                                                            ? "${customerHomeControl.findNearestStores()[index]['restData']['address'] ?? ""} • ${customerHomeControl.getDistance(customerHomeControl.findNearestStores()[index]['restData']['latitude'], customerHomeControl.findNearestStores()[index]['restData']['longitude']).toStringAsFixed(1)}km"
                                                            : "",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 14.sp,
                                                          color: Colors.black.withOpacity(0.70),
                                                        ),
                                                        maxLines: 2,
                                                      ),
                                                    )
                                                  : Text(
                                                      customerHomeControl.findNearestStores()[index]['restData']['address'] ?? "",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14.sp,
                                                        color: Colors.black.withOpacity(0.70),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8.sp,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: <Color>[
                                                  const Color(0xFFF5951D).withOpacity(0.7),
                                                  const Color(0xFFF5951D).withOpacity(0.3),
                                                  const Color(0xFFF5951D).withOpacity(0.08),
                                                  const Color(0xFFF5951D).withOpacity(0.01),
                                                ],
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(10.0.sp),
                                                  child: Container(
                                                    padding: EdgeInsets.all(10.sp),
                                                    decoration: BoxDecoration(color: Color(0xFF213C63), borderRadius: BorderRadius.circular(15.sp)),
                                                    child: Icon(
                                                      Icons.online_prediction,
                                                      color: Colors.white,
                                                      size: 14.sp,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "SHOP IS ONLINE",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.sp,
                                                    color: Colors.black,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
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
    );
  }
}
