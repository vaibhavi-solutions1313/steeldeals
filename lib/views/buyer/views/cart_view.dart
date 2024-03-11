import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import '../../../widgets/simple_app_bar.dart';
import 'checkout_view.dart';

class CartView extends StatefulWidget {
  CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

  @override
  void initState() {
    cartController.grandTotalValue.value = '';
    cartController.total.value = '';
    cartController.gst.value = '';
    // TODO: implement initState
    super.initState();
  }

  // @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SimpleAppBar('Cart'),
          /**
           * ? divider and title
           */

          FutureBuilder<dynamic>(
            future: cartController.getCartItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(child: Center(child: CircularProgressIndicator(color: Colors.orangeAccent,)));
              }
              if (snapshot.hasData) {
                if(snapshot.data['cart_items'].length != 0) {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    cartController.isCartEmpty.value = false;
                  });
                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data['cart_items'].length,
                              itemBuilder: (ctx, index) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.orangeAccent,
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(100),bottomLeft: Radius.circular(100))
                                        ),
                                        width: 3,
                                        height: 85,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: DataTable(
                                          horizontalMargin: 10,
                                          columns: const [
                                            DataColumn(label: Text('Store ID')),
                                            DataColumn(label: Text('Product')),
                                            DataColumn(label: Text('Size')),
                                            DataColumn(label: Text('Quantity')),
                                            DataColumn(label: Text('Random')),
                                            DataColumn(label: Text('Clearcut')),
                                            DataColumn(label: Text('Price')),
                                          ],
                                          rows: List.generate(
                                              1,
                                                  (index1) => DataRow(cells: [
                                                DataCell(Text(snapshot.data['cart_items'][index]['stock_id'].toString())),
                                                DataCell(Text(snapshot.data['cart_items'][index]['product']['name'].toString())),
                                                DataCell(Text(snapshot.data['cart_items'][index]['stock_id'].toString())),
                                                DataCell(Text(snapshot.data['cart_items'][index]['qty'].toString())),
                                                DataCell(Text(snapshot.data['cart_items'][index]['product']['random'].toString())),
                                                DataCell(Text(snapshot.data['cart_items'][index]['product']['clear_cut'].toString())),
                                                DataCell(Text(snapshot.data['cart_items'][index]['price'].toString())),
                                              ])),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Sub Total",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                  Text("₹${cartController.total.value.toString()}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                ],
                              ),
                              Divider(color: Colors.orangeAccent,thickness: 0.4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("GST",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                  Text("₹${cartController.gst.value.toString()}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                ],
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    cartController.isCartEmpty.value = true;
                  });

                  return Expanded(child: Center(child: Text("Cart is empty")));
                }

              } else {
                return Expanded(child: Center(child: Text("Cart is empty")));
              }
            },
          ),

          /**
           * ? total
           */
          Obx(() => cartController.grandTotalValue.value.isNotEmpty  && cartController.isCartEmpty.value == false ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Divider(color: Colors.orangeAccent,thickness: 0.4,),
          ) : Row()),
          Obx(() => cartController.grandTotalValue.value.isNotEmpty  && cartController.isCartEmpty.value == false ? Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Grand Total",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      letterSpacing: 0.40,
                    ),
                  ),
                  Text(
                    "₹${cartController.grandTotalValue.value}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      letterSpacing: 0.40,
                    ),
                  ),
                ],
              ),
            ),
          ) : Row()),
          /**
           * ? button
           */
          Obx(() =>  Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: InkWell(
              onTap: cartController.grandTotalValue.value.isNotEmpty && cartController.isCartEmpty.value == false ? () {
                // SEND TO CHECKOUT
                Get.to(CheckoutScreen(),transition: Transition.rightToLeft)?.then((value) {
                  setState(() {

                  });
                });
              } : null,
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: cartController.grandTotalValue.value.isNotEmpty && cartController.isCartEmpty.value == false ? Color(0xfff5951d) : Colors.grey.shade400,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "CHECKOUT",
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
          ))
        ],
      ),
    );
  }
}
