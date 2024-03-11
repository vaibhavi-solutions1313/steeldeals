import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../widgets/simple_app_bar.dart';

class OrderDetailView extends StatefulWidget {
  final dynamic data;
  const OrderDetailView({super.key, this.data});

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  @override
  Widget build(BuildContext context) {
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
            SimpleAppBar("Order Details"),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 18),
                children: [
                  Column(
                    children: List.generate(
                      widget.data['items'].length,
                      (index) => Row(
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
                                      child: Text("Store Id: ${widget.data['items'][index]['product']['shop_id'].toString()}"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.data['items'][index]['product']['name'].toString(),
                                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Price : ${widget.data['items'][index]['product']['sizes'][0]['pivot']['price'].toString()}", // TODO: NEED TO SHOW SIZES
                                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Size: " + widget.data['items'][index]['product']['sizes'][0]['size'].toString(),
                                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Quantity: " + widget.data['items'][index]['qty'].toString(),
                                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "Seller Bank Detail",
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
                                      ),
                                      Text(
                                        'Bank : '+widget.data['items'][index]['product']['user_bank_detail_by_shop']['bank_name'],
                                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'Acc No : '+widget.data['items'][index]['product']['user_bank_detail_by_shop']['acc_no'],
                                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'Acc Holder : '+widget.data['items'][index]['product']['user_bank_detail_by_shop']['acc_holder_name'],
                                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'Branch : '+widget.data['items'][index]['product']['user_bank_detail_by_shop']['branch'],
                                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'IFSC : '+widget.data['items'][index]['product']['user_bank_detail_by_shop']['ifsc'],
                                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(vertical: 2.0),
                                //   child: Align(
                                //     alignment: Alignment.centerLeft,
                                //     child: Text(
                                //       widget.data['items'][index]['product']['instock']['description'].toString(),
                                //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                //     ),
                                //   ),
                                // )
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
                                widget.data['items'][index]['product']['images'] != [] ? widget.data['items'][0]['product']['images'][0]['url'].toString() : "",
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
                    ),
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
                      "Payment type \n${widget.data['payment_method']}",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     "Transported by \n${widget.data['transported_by'] ?? "Not Available"}",
                  //     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  //   ),
                  // ),
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
                            "₹${widget.data['grand_total'].toString()}",
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
                            widget.data['gst'] != null ? "₹${widget.data['gst']}" : "0",
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
                            widget.data['delivery_charge'] != null ? "₹,${widget.data['delivery_charge']}" : "0",
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
                            "₹${widget.data['subtotal']}",
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
                          child: Text(
                              "${widget.data['address']['address']['address_line_1'] ?? ""}, ${widget.data['address']['address']['address_line_2'] ?? ""}, ${widget.data['address']['address']['landmark'] ?? ""} ${widget.data['address']['address']['city'] ?? ""}, ${widget.data['address']['address']['state'] ?? ""}, ${widget.data['address']['address']['country'] ?? ""},${widget.data['address']['address']['pin_code'] ?? ""}"),
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
