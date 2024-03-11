import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/Utils/constants.dart';
import 'package:services_provider_application/main.dart';
import 'package:services_provider_application/modules/ProductDetail/product_details_view.dart';
import '../widgets/filter_view_bottomsheet.dart';

class ProductsListingView extends StatefulWidget {
  final String? catId;
  final String? catName;
  const ProductsListingView({Key? key, this.catId, this.catName}) : super(key: key);

  @override
  State<ProductsListingView> createState() => _ProductsListingViewState();
}

class _ProductsListingViewState extends State<ProductsListingView> {
  @override
  void initState() {
    if(widget.catId != null) {
      productController.getBuyerProducts(widget.catId!).then((value) {
        if (productController.buyerProductList.length != 0) {
          Get.showSnackbar(GetSnackBar(
            message: 'Long press to select product',
            duration: Duration(seconds: 3),
          ));
        }
      });
    }
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
      bottomNavigationBar: Obx(() => catControl.selectedSellerData.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: (() => catControl.onCounterPricePressed()),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Constants.primaryButtonColor,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Counter Price",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Row()),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(widget.catName ?? "NIL", style: TextStyle(fontSize: 18, color: Color(0xFF213C63), fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      filterSheet(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(10)),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.filter_list,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                              '${productController.buyerProductList.length.toString()} Products',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Obx(() => GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 0.0,
                            childAspectRatio: 1 / 1.5,
                            shrinkWrap: false,
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            children: List.generate(
                              productController.buyerProductList.length,
                              (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(ProductDetailView(
                                        data: productController.buyerProductList[index],
                                      ));
                                    },
                                    onLongPress: () {
                                      /// TODO: PENDING ADD MAP
                                      catControl.selectedSellerData.addAll({"abc": ""});
                                      catControl.selectedIndex.value = index;
                                      // Get.showSnackbar(GetSnackBar(message: 'Product selected successfully!',duration: Duration(seconds: 3),));
                                    },
                                    child: Obx(() => Container(
                                          color: catControl.selectedIndex.value == index ? Color(0xFFF5951D).withOpacity(0.2) : null,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: FadeInImage(
                                                        imageErrorBuilder: (context, error, stackTrace) {
                                                          return Image.asset("assets/ph.jpg");
                                                        },
                                                        placeholder: AssetImage("assets/ph.jpg"),
                                                        image: NetworkImage(
                                                          productController.buyerProductList[index]['instock'] != null? productController.buyerProductList[index]['instock']['images'] != null?  productController.buyerProductList[index]['instock']['images'][0]: "":"",
                                                        ),
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(productController.buyerProductList[index]['name'].toString(),
                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                const Text('Price Starts From', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black54)),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  '₹${productController.buyerProductList[index]['instock']['basic_price'].toString()}',
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                                                ),
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
