import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/views/seller/views/menu_views/add_product/product_update_view.dart';
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
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: productController.storeSearchedProduct,
              decoration: InputDecoration(
                hintText: 'Search Product',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.25), width:2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.25), width: 2.0),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    productController.isSearch.value = true;
                    setState(() {

                    });
                  },
                  icon: Icon(Icons.search,color: Color(0xFFF5951D),),
                )
              )
            ),
          ),
          Expanded(
            child: FutureBuilder<dynamic>(
              future: productController.getProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Color(0xFFF5951D),));
                }
                if (snapshot.hasData) {
                  if(snapshot.data.length != 0) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String singleImage = "";
                        if (snapshot.data[index]['instock'] != null) {
                          if (snapshot.data[index]['instock']['images'].isNotEmpty) {
                            singleImage = snapshot.data[index]['instock']['images'][0].toString();
                          }
                        }
                        return InkWell(
                          onTap: () {
                            // Get.to(OrderSummaryView());
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), shape: BoxShape.rectangle, boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                              ),
                            ]),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    child: Image.network(
                                      singleImage.toString(),
                                      errorBuilder: (context, error, stackTrace) {
                                        return Center(
                                          child: Text(
                                            "⚠\nerror",
                                            textAlign: TextAlign.center, style: TextStyle(fontSize: 16),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        snapshot.data[index]['name'].toString(),
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text("₹ ${snapshot.data[index]['price'].toString()}"),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(25),
                                      onTap: () {
                                        if (snapshot.data[index]['instock'] != null) {
                                          Get.to(ProductUpdateView(
                                            id: snapshot.data[index]['id'].toString(),
                                            name: snapshot.data[index]['name'].toString(),
                                            categoryId: snapshot.data[index]['category_id'].toString(),
                                            categoryInfo: snapshot.data[index]['category'],
                                            sizes: snapshot.data[index]['sizes'],
                                            price: snapshot.data[index]['price'].toString(),
                                            random: snapshot.data[index]['random'].toString(),
                                            clearCut: snapshot.data[index]['clear_cut'].toString(),
                                            description: snapshot.data[index]['instock']['description'] ?? "",
                                          ), transition: Transition.rightToLeft)!.then((value) {
                                            setState(() {

                                            });
                                          });
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            backgroundColor: Colors.red, content: Text("Stock is empty, Please add stock before edit."), duration: Duration(seconds: 2),));
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(25)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(6.0),
                                          child: Icon(
                                            Icons.edit,
                                            color: Color(0xFFF5951D),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    InkWell(
                                      borderRadius: BorderRadius.circular(25),
                                      onTap: () {
                                        /// DELETE PRODUCT CALLED.
                                        productController.deleteProduct(context, snapshot.data[index]['id'].toString()).then((value) {
                                          if (value) {
                                            setState(() {

                                            });
                                          }
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(25)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(6.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Color(0xFFF5951D),
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
