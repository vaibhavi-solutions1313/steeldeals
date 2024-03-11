import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../apis/seller/shop_related.dart';
import '../../../../../main.dart';
import '../../add_shop_view/add_shop_view.dart';
import '../../menu_views/add_product/product_update.dart';

class SellerHomeTab extends StatefulWidget {
  const SellerHomeTab({Key? key}) : super(key: key);

  @override
  State<SellerHomeTab> createState() => _SellerHomeTabState();
}

class _SellerHomeTabState extends State<SellerHomeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF0FAFF),
            Color(0xFFFFF7EE),
          ],
        ),
        //     image: DecorationImage(
        //   fit: BoxFit.cover,
        //   image: AssetImage("assets/seller/images/bc_image.jpg"),
        // ),
      ),
      child: SafeArea(
        child: Obx(() => homeSellerController.shopInfo.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('assets/seller/images/store_home.png', width: MediaQuery.of(context).size.width / 2),
                      const Text(
                        "simply dummy text of the printing and typesetting industry.",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                                backgroundColor: Color(0xFFF5951D)),
                            onPressed: () {
                              // TODO: NEEDS TO BE REMOVED
                              Get.to(const AddShopView());
                            },
                            child: const Text(
                              "Create Shop",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : AvailableShop()),
      ),
    );
  }
}

class AvailableShop extends StatefulWidget {
  const AvailableShop({
    Key? key,
  }) : super(key: key);

  @override
  State<AvailableShop> createState() => _AvailableShopState();
}

class _AvailableShopState extends State<AvailableShop> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        ListTile(
          title: Text(
            "Is Store Open?",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.8),fontSize: 16.sp),
          ),
          subtitle: Text("Update your store status.",style: TextStyle(fontSize: 15.sp),),
          trailing: Obx(
            () => Transform.scale(
              scale: 4.sp,
              child: Switch(
                // thumb color (round icon)
                activeColor: Color(0xFFF5951D),
                activeTrackColor: Colors.black54,
                inactiveThumbColor: Colors.amber.shade600,
                inactiveTrackColor: Colors.grey.shade400,
                splashRadius: 50.0,
                value: addShopController.isShopOpen.value,
                onChanged: (value) {
                  addShopController.isShopOpen.value = value;
                  try {
                    context.loaderOverlay.show();
                    ShopRelate().updateShopOpenStatus(addShopController.isShopOpen.value ? "1" : "0").then((value) {
                      context.loaderOverlay.hide();
                      if (value.serverStatusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated Successfully.")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong!")));
                      }
                    });
                  } catch (e) {
                    context.loaderOverlay.hide();
                    // TODO
                  }
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recently Added Products",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              )),
        ),
        Expanded(
          child: FutureBuilder<dynamic>(
            future: productController.getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Color(0xFFF5951D),
                ));
              }
              if (snapshot.hasData) {
                if (snapshot.data.length != 0) {
                  bool inStock = false;
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 18.0.sp, vertical: 0),
                    itemCount: snapshot.data.length >= 5 ? 5 : snapshot.data.length, // SHOW MAX 5 ITEMS
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      String singleImage = "";
                      if (snapshot.data[index]['instock'] != null) {
                        inStock = true;
                        if (snapshot.data[index]['instock']['images'].isNotEmpty) {
                          singleImage = snapshot.data[index]['instock']['images'][0].toString();
                        }
                      } else {
                        inStock = false;
                      }
                      return InkWell(
                        onTap: () {
                          // Get.to(OrderSummaryView());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 8.sp),
                          margin: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 5.sp),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), shape: BoxShape.rectangle, boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                            ),
                          ]),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.sp),
                                child: Container(
                                  height: 30.sp,
                                  width: 30.sp,
                                  child: Image.network(
                                    singleImage.toString(),
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Text(
                                          "⚠\nerror",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      snapshot.data[index]['name'].toString(),
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16.sp),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    inStock
                                        ? Text(
                                            "In Stock (${snapshot.data[index]['instock']['quantity'].toString()})",
                                            style: TextStyle(color: Colors.green, fontSize: 15.sp),
                                          )
                                        : Text(
                                            "Out of stock",
                                            style: TextStyle(color: Colors.red, fontSize: 15.sp),
                                          ),
                                    Text("₹ ${snapshot.data[index]['price'].toString()}",style: TextStyle(fontSize: 15.sp),),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(25.sp),
                                    onTap: () {
                                      if (snapshot.data[index]['instock'] != null) {
                                        Get.to(
                                                ProductUpdateView(
                                                  data: snapshot.data[index],
                                                  categoryInfo: snapshot.data[index]['category'],
                                                  id: snapshot.data[index]['id'].toString(),
                                                  stockId: snapshot.data[index]['instock']['id'].toString(),
                                                  name: snapshot.data[index]['name'].toString(),
                                                  categoryId: snapshot.data[index]['category_id'].toString(),
                                                  sizes: snapshot.data[index]['sizes'],
                                                  price: snapshot.data[index]['price'].toString(),
                                                  random: snapshot.data[index]['random'].toString(),
                                                  clearCut: snapshot.data[index]['clear_cut'].toString(),
                                                  description: snapshot.data[index]['instock']['description'] ?? "",
                                                ),
                                                transition: Transition.rightToLeft)!
                                            .then((value) {
                                          setState(() {});
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text("Stock is empty, Please add stock before edit.",style: TextStyle(fontSize: 16.sp),),
                                          duration: Duration(seconds: 2),
                                        ));
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(25)),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0.sp),
                                        child: Icon(
                                          Icons.edit,
                                          color: Color(0xFFF5951D),
                                          size: 18.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.sp),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(25.sp),
                                    onTap: () {
                                      /// DELETE PRODUCT CALLED.
                                      productController.deleteProduct(context, snapshot.data[index]['id'].toString()).then((value) {
                                        if (value) {
                                          setState(() {});
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(25)),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0.sp),
                                        child: Icon(
                                          Icons.delete,
                                          color: Color(0xFFF5951D),
                                          size: 18.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No Products Added."));
                }
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Failed to get data."),
                    TextButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text("Retry"))
                  ],
                );
              }
            },
          ),
        )
      ],
    );
  }
}
