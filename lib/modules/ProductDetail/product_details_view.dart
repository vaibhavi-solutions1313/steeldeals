import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/main.dart';
import 'package:services_provider_application/modules/ProductDetail/product_details_controller.dart';
import '../../Utils/constants.dart';
import '../../widgets/simple_app_bar.dart';

class ProductDetailView extends StatefulWidget {
  final dynamic data;
  const ProductDetailView({Key? key, this.data}) : super(key: key);

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  ProductDetailsController controller = Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SimpleAppBar('Product details'),
          FutureBuilder<dynamic>(
            future: productController.getProductsByProductId(widget.data["id"].toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 250,),
                    CircularProgressIndicator(
                      color: Color(0xFFF5951D),
                    ),
                  ],
                );
              }
              if(snapshot.hasData) {
                controller.productData = snapshot.data; // keep data
                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data['name'].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    letterSpacing: 0.20,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Base Price : ${snapshot.data['basic_price'].toString()}",
                                  style: TextStyle(
                                    color: Color(0x7f000000),
                                    fontSize: 14,
                                    letterSpacing: 0.14,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  snapshot.data['description'].toString(),
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: Container(
                              height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: FadeInImage(
                                    imageErrorBuilder: (context, error, stackTrace) {
                                      return Image.asset("assets/ph.jpg");
                                    },
                                    placeholder: AssetImage("assets/ph.jpg"), image: NetworkImage(snapshot.data['images'][0] ?? "",))),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Constants.primaryButtonColor.withOpacity(.1),
                      ),

                      /**
                       * ? angle size selction grid view
                       */
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Angle size type :",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            letterSpacing: 0.20,
                          ),
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 10),
                        children: List.generate(snapshot.data['sizes'].length, (index) {
                          return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Obx(
                                    () => InkWell(
                                  onTap: (() => controller.onCategoryPressed(snapshot.data['sizes'][index],index)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: controller.selectedCategory.contains(index) ? Constants.primaryButtonColor : Colors.transparent),
                                        color: Constants.primaryButtonColor.withOpacity(.05)),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text(
                                          "Size : ${snapshot.data['sizes'][index]['size'].toString()}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            // fontSize: 14,
                                            // letterSpacing:1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        }),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: OutlinedButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              side: BorderSide(width: 1.0, color: Color(0xFFF5951D)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Customise Size",
                              style: TextStyle(color: Color(0xFFF5951D)),
                            )),
                      ),

                      /**
                       * ? selected size info
                       */
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Selected Size",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            letterSpacing: 0.20,
                          ),
                        ),
                      ),
                      /**
                       * ? size info and amount
                       */
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Constants.primaryButtonColor.withOpacity(.05),
                                  ),
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      child: Text(
                                        "Size : 40*5",
                                        style: TextStyle(
                                          color: Color(0x4c000000),
                                          fontSize: 14,
                                          letterSpacing: 0.28,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xfff5951d),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 60),
                          Container(
                            width: 88,
                            height: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xfff3f3f3),
                            ),
                            child: const Center(
                              child: Text(
                                "₹8000.00",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  letterSpacing: 0.28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      /**
                       * ? type selection
                       */

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xfff3f3f3),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  child: Text(
                                    "Length",
                                    style: TextStyle(
                                      color: Color(0x4c000000),
                                      fontSize: 14,
                                      letterSpacing: 0.28,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Icon(Icons.expand_more),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xfff3f3f3),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Text(
                                "Random",
                                style: TextStyle(
                                  color: Color(0x4c000000),
                                  fontSize: 14,
                                  letterSpacing: 0.28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      /**
                       * ? loading amount
                       */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xfff3f3f3),
                            ),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Text(
                                  "Loading Amount",
                                  style: TextStyle(
                                    color: Color(0x4c000000),
                                    fontSize: 14,
                                    letterSpacing: 0.28,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xfff3f3f3),
                            ),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Text(
                                  "₹8000.00",
                                  style: TextStyle(
                                    color: Color(0x4c000000),
                                    fontSize: 14,
                                    letterSpacing: 0.28,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      /**
                       * ? GST amount
                       */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "GST ",
                                style: TextStyle(
                                  color: Color(0x4c000000),
                                  fontSize: 14,
                                  letterSpacing: 0.28,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Amount ₹90000.00",
                                style: TextStyle(
                                  color: Color(0x4c000000),
                                  fontSize: 10,
                                  letterSpacing: 0.20,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xfff3f3f3),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Text(
                                "Amount+GST",
                                style: TextStyle(
                                  color: Color(0x4c000000),
                                  fontSize: 14,
                                  letterSpacing: 0.28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      /**
                       * ? divider line
                       */

                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Constants.primaryButtonColor.withOpacity(.1),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "Grand Total",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              letterSpacing: 0.30,
                            ),
                          ),
                          Text(
                            "₹,782,000.00",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              letterSpacing: 0.24,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Constants.primaryButtonColor.withOpacity(.1),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(backgroundColor: Color(0xFF213C63), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.sell_outlined,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Text("Request for Approval", style: TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                style: TextButton.styleFrom(
                                    side: BorderSide(width: 1.0, color: Color(0xFF213C63)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Color(0xFF213C63),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Text("Add more Products", style: TextStyle(color: Color(0xFF213C63))),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 250,),
                    Text("Product not found! May removed by seller."),
                    TextButton(onPressed: () {
                      Get.back();
                    }, child: Text("Go Back"))
                  ],
                );
              }
            },
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 18),
        child: InkWell(
          onTap: () {
            controller.addToCart(context);
          },
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xfff5951d),
            ),
            child: const Center(
              child: Text(
                "ADD TO CART",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
