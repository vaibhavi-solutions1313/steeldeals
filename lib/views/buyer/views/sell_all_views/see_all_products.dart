import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/main.dart';
import 'package:services_provider_application/views/buyer/views/product_detail/product_details_view.dart';
import '../../../../widgets/filter_view_bottomsheet.dart';

class SeeAllProducts extends StatefulWidget {
  final String? catId;
  final String? catName;
  final bool? isExploreProduct;
  const SeeAllProducts({Key? key, this.catId, this.catName, this.isExploreProduct = false}) : super(key: key);

  @override
  State<SeeAllProducts> createState() => _SeeAllProductsState();
}

class _SeeAllProductsState extends State<SeeAllProducts> {
  @override
  void initState() {
    // if(widget.catId != null) {
    //   productController.getBuyerProducts(widget.catId!).then((value) {
    //     if (productController.buyerProductList.length != 0) {
    //       Get.showSnackbar(GetSnackBar(
    //         message: 'Long press to select product',
    //         duration: Duration(seconds: 3),
    //       ));
    //     }
    //   });
    // }
    catControl.selectedSellerData.clear();
    catControl.selectedIndex.value = 1000000000000000000;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    catControl.selectedSellerData.clear();
    catControl.selectedIndex.value = 1000000000000000000;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.3,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.orangeAccent,
          ),
        ),
        title: Text(widget.catName ?? "NIL", style: TextStyle(fontSize: 18, color: Color(0xFF213C63), fontWeight: FontWeight.w700)),
        actions: widget.isExploreProduct == true
            ? [
                IconButton(
                  onPressed: () {
                    filterSheet(context);
                  },
                  icon: Icon(
                    Icons.filter_list,
                    color: Colors.orangeAccent,
                  ),
                ),
              ]
            : [],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          Obx(
                            () => Text(
                              '${customerProductDetailControl.buyerProductList.length.toString()} Products',
                              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Obx(() => GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                            childAspectRatio: 3 / 5,
                            shrinkWrap: false,
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            children: List.generate(
                              customerProductDetailControl.buyerProductList.length,
                              (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: InkWell(
                                    onTap: () {
                                      print('-----ProductDetailView-----');
                                      Get.to(()=>ProductDetailView(
                                        data: customerProductDetailControl.buyerProductList[index],
                                      ));
                                    },
                                    // onLongPress: () {
                                    //   /// TODO: PENDING ADD MAP
                                    //   catControl.selectedSellerData.addAll({"abc": ""});
                                    //   catControl.selectedIndex.value = index;
                                    //   // Get.showSnackbar(GetSnackBar(message: 'Product selected successfully!',duration: Duration(seconds: 3),));
                                    // },
                                    child: Obx(() => Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100, borderRadius: BorderRadius.circular(18), border: Border.all(width: 1, color: Colors.grey.shade200)),
                                          // color: catControl.selectedIndex.value == index ? Color(0xFFF5951D).withOpacity(0.2) : null,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Card(
                                                    elevation: 2,
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                    child: FadeInImage(
                                                      imageErrorBuilder: (context, error, stackTrace) {
                                                        return Image.asset("assets/ph.jpg");
                                                      },
                                                      placeholder: AssetImage("assets/ph.jpg"),
                                                      image: NetworkImage(
                                                        customerProductDetailControl.buyerProductList[index]['instock'] != null
                                                            ? customerProductDetailControl.buyerProductList[index]['instock']['images'] != null
                                                                ? customerProductDetailControl.buyerProductList[index]['instock']['images'][0]
                                                                : ""
                                                            : "",
                                                      ),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(customerProductDetailControl.buyerProductList[index]['name'].toString().toUpperCase(),
                                                          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.black)),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  customerProductDetailControl.buyerProductList[index]['instock'] != null ? "In Stock" : "Out of Stock",
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w600,
                                                      color: customerProductDetailControl.buyerProductList[index]['instock'] != null ? Colors.green : Colors.grey),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.black26, width: 1)),
                                                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                                  child: Text(
                                                    "Shop ID: " + customerProductDetailControl.buyerProductList[index]['shop_id'].toString(),
                                                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.black54),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                customerProductDetailControl.buyerProductList[index]['instock'] != null
                                                    ? Text('Price Starts From', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black54))
                                                    : Row(),
                                                customerProductDetailControl.buyerProductList[index]['instock'] != null
                                                    ? SizedBox(
                                                        height: 2,
                                                      )
                                                    : Row(),
                                                customerProductDetailControl.buyerProductList[index]['instock'] != null
                                                    ? Text(
                                                        '₹${customerProductDetailControl.buyerProductList[index]['instock']['basic_price'].toString()}',
                                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                                                      )
                                                    : Row(),
                                              ],
                                            ),
                                          ),
                                        )),
                                  ),
                                );
                              },
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
