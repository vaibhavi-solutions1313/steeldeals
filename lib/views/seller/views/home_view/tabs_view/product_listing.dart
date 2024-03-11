import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/views/seller/views/menu_views/add_product/product_update.dart';
import '../../../../../main.dart';

class ShopListingTab extends StatefulWidget {
  const ShopListingTab({Key? key}) : super(key: key);

  @override
  State<ShopListingTab> createState() => _ShopListingTabState();
}

class _ShopListingTabState extends State<ShopListingTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // SafeArea(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       IconButton(
          //           onPressed: () {
          //             Get.back();
          //           },
          //           icon: const Icon(Icons.undo)),
          //       Text("My Product List", style: TextStyle(color: Color(0xFF213C63), fontSize: 21, fontWeight: FontWeight.w700)),
          //       IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          //     ],
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: TextFormField(
                controller: productController.storeSearchedProduct,
                decoration: InputDecoration(
                    hintText: 'Search Product',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.25), width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.25), width: 2.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        productController.isSearch.value = true;
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.search,
                        color: Color(0xFFF5951D),
                      ),
                    ))),
          ),
          Expanded(
            child: FutureBuilder<dynamic>(
              future: productController.getProducts(),
              initialData: productController.productsList.value,
              builder: (context, snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return Center(child: CircularProgressIndicator(color: Color(0xFFF5951D),));
                // }
                if (snapshot.hasData) {
                  if (snapshot.data.length != 0) {
                    bool inStock = false;
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 18.0.sp, vertical: 8.sp),
                      itemCount: snapshot.data.length,
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
                            padding: EdgeInsets.symmetric(vertical: 2.sp, horizontal: 8.sp),
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
                                    color: Colors.black45,
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
                                      Text(
                                        "₹ ${snapshot.data[index]['price'].toString()}",
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
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
                                                    id: snapshot.data[index]['id'].toString(),
                                                    name: snapshot.data[index]['name'].toString(),
                                                    stockId: snapshot.data[index]['instock']['id'].toString(),
                                                    categoryId: snapshot.data[index]['category_id'].toString(),
                                                    categoryInfo: snapshot.data[index]['category'],
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
                                            content: Text(
                                              "Stock is empty, Please add stock before edit.",
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
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
                                        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(25.sp)),
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
                    return Center(child: Text("No Products Added"));
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
      ),
    );
  }
}
