import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderSummaryView extends StatefulWidget {
  final dynamic data;
  const OrderSummaryView({Key? key, this.data}) : super(key: key);

  @override
  State<OrderSummaryView> createState() => _OrderSummaryViewState();
}

class _OrderSummaryViewState extends State<OrderSummaryView> {
  @override
  Widget build(BuildContext context) {
    log(widget.data.toString());
    final DateFormat formatter = DateFormat('dd  MMM, yyyy');
    final String formattedOrderTime = formatter.format(DateTime.parse(widget.data['created_at'].toString()));
    return Scaffold(
      body: Container(
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
        child: Column(
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_rounded)),
                  Text("Order Summary", style: TextStyle(color: Color(0xFF213C63), fontSize: 21, fontWeight: FontWeight.w700)),
                  IconButton(onPressed: null, icon: const Icon(Icons.search,color: Colors.transparent,))
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 18),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(color: Color(0xFFF0F0F0), borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Text("Store Id: ${widget.data['product']['shop_id'].toString()}"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.data['product']['name'].toString(),
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Price : ${widget.data['product']['price'].toString()}",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                  ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Size: "+widget.data['size']['size'].toString(),
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                  ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Quantity: "+widget.data['qty'].toString(),
                                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                                  ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(15)),
                          width: 150,
                          height: 150,
                          child: Image.network(
                            widget.data['product']['instock']['images'] != [] ? widget.data['product']['instock']['images'][0].toString() : "",
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                  child: Text(
                                "Error on image",
                                textAlign: TextAlign.center,
                              ));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.2,
                    color: Colors.black12,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Order Details",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          formattedOrderTime,
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Payment type \n${widget.data['order']['payment_method']}",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Buyer Bank Details",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17.sp),
                        ),
                        Text(
                          'Bank : '+widget.data['user_bank_details']['bank_name'],
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Acc No : '+widget.data['user_bank_details']['acc_no'],
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Acc Holder : '+widget.data['user_bank_details']['acc_holder_name'],
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Branch : '+widget.data['user_bank_details']['branch'],
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'IFSC : '+widget.data['user_bank_details']['ifsc'],
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Transported by \n${widget.data['order']['transported_by'] ?? "Not Available"}",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  Divider(
                    thickness: 1.2,
                    color: Colors.black12,
                  ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.vertical,
                  //   child: SingleChildScrollView(
                  //     scrollDirection: Axis.horizontal,
                  //     child: DataTable(
                  //       horizontalMargin: 0,
                  //       columns: const [
                  //         DataColumn(label: Text('STORE-ID')),
                  //         DataColumn(label: Text('PRODUCTS')),
                  //         DataColumn(label: Text('SIZE')),
                  //         DataColumn(label: Text('QUANTITY')),
                  //         DataColumn(label: Text('RATE')),
                  //       ],
                  //       rows: List.generate(
                  //           1,
                  //           (index) => DataRow(cells: [
                  //                 DataCell(Text(widget.data['product']['shop_id'].toString())),
                  //                 DataCell(Text('6m ms rounded')),
                  //                 DataCell(Text("25*5")),
                  //                 DataCell(Text("500")),
                  //                 DataCell(Text("500 ton.")),
                  //               ])),
                  //     ),
                  //   ),
                  // ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Grand Total",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "₹${widget.data['order']['grand_total'].toString()}",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       "IGST",
                      //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      //     ),
                      //     Text(
                      //       "200",
                      //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       "SGST",
                      //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      //     ),
                      //     Text(
                      //       "200",
                      //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      //     ),
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "GST",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            widget.data['order']['gst'] != null ?  "₹${widget.data['order']['gst']}" : "0",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery Charge",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            widget.data['order']['delivery_charge'] != null ?  "₹,${widget.data['order']['delivery_charge']}" : "0",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "TCS",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "0",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Insurance",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "0",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sub Total",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "₹${widget.data['order']['subtotal']}",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       "Other",
                      //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      //     ),
                      //     Text(
                      //       "200",
                      //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  Divider(
                    thickness: 1.2,
                    color: Colors.black12,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Delivery Address",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(color: Color(0xFFF0F0F0), borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text("#${widget.data['buyer']['address']}, ${widget.data['buyer']['city']}, ${widget.data['buyer']['state']}, ${widget.data['buyer']['country']},${widget.data['buyer']['pin_code']}  "),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
