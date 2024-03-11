import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/views/buyer/views/addresses/address_list_view.dart';
import 'package:services_provider_application/views/payment_method_view.dart';

import '../../../main.dart';
import '../../../widgets/simple_app_bar.dart';
import '../../seller/views/gen_widgets/cus_textfield.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    checkoutController.clearEverything();
    // TODO: implement dispose
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SimpleAppBar('Checkout'),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0.sp, vertical: 10.sp),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Delivery Address",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
                        )),
                    SizedBox(
                      height: 15.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0.sp),
                      child: Obx(() => ListTile(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey.shade300, width: 1),
                              borderRadius: BorderRadius.circular(5.sp),
                            ),
                            onTap: () {
                              if (checkoutController.isThreeLineAddress.value == true) {
                                checkoutController.isThreeLineAddress.value = false;
                              } else {
                                checkoutController.isThreeLineAddress.value = true;
                              }
                            },
                            isThreeLine: checkoutController.isThreeLineAddress.value,
                            title: Text(
                              "Home",
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            subtitle: Text(
                              customerAddControl.defaultAddressMap()['address']['address_line_1'] +
                                  ', ' +
                                  customerAddControl.defaultAddressMap()['address']['address_line_2'] +
                                  ', ' +
                                  customerAddControl.defaultAddressMap()['address']['city'] +
                                  ', ' +
                                  customerAddControl.defaultAddressMap()['address']['state'] +
                                  ', ' +
                                  customerAddControl.defaultAddressMap()['address']['pin_code'].toString().toString(),
                              maxLines: checkoutController.isThreeLineAddress.value == false ? 1 : 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            trailing: TextButton(
                              onPressed: () {
                                Get.to(AddressListView(), transition: Transition.rightToLeft);
                              },
                              child: Text(
                                "Change",
                                style: TextStyle(color: Color(0xFFF5951D), fontSize: 15.sp),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 25,
                    ),

                    /// PAYMENT MODE LAYOUT
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Bank Details",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
                        )),
                    SizedBox(
                      height: 15.sp,
                    ),
                    CustomTextField(
                      controller: paymentMethodControl.bankName,
                      hintText: "Bank Name",
                      keyBoardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    CustomTextField(
                      controller: paymentMethodControl.branch,
                      hintText: "Branch",
                      keyBoardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    CustomTextField(
                      controller: paymentMethodControl.ifsc,
                      hintText: "IFSC",
                      keyBoardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    CustomTextField(
                      controller: paymentMethodControl.accountHolderName,
                      hintText: "Account Holder Name",
                      keyBoardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    CustomTextField(
                      controller: paymentMethodControl.accountNumber,
                      hintText: "Account Number",
                      keyBoardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    Container(color: Colors.grey.shade200,child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Note: Order will be proceeded once we confirm your payment."),
                    ))
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 4.0.sp),
                    //   child: Column(
                    //     children: [
                    //       Obx(
                    //         () => ListTile(
                    //           shape: RoundedRectangleBorder(
                    //             side: BorderSide(color: checkoutController.payModeSelected.value == "cod" ? Color(0xFFF5951D) : Colors.grey.shade400, width: 1),
                    //             borderRadius: BorderRadius.circular(5.sp),
                    //           ),
                    //           onTap: () {
                    //             checkoutController.payModeSelected.value = "cod";
                    //           },
                    //           title: Text(
                    //             "Cash on Delivery",
                    //             style: TextStyle(fontSize: 15.sp),
                    //           ),
                    //           subtitle: Text(
                    //             "Pay on delivery to our delivery agent.",
                    //             style: TextStyle(fontSize: 15.sp),
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 15.sp,
                    //       ),
                    //       Obx(
                    //         () => ListTile(
                    //           shape: RoundedRectangleBorder(
                    //             side: BorderSide(color: checkoutController.payModeSelected.value == "online" ? Color(0xFFF5951D) : Colors.grey.shade400, width: 1),
                    //             borderRadius: BorderRadius.circular(5.sp),
                    //           ),
                    //           onTap: () {
                    //             checkoutController.payModeSelected.value = "online";
                    //           },
                    //           title: Text("Pay Online with Razorpay",style: TextStyle(fontSize: 15.sp),),
                    //           subtitle: Text("Pay online with our online gateway partner.",style: TextStyle(fontSize: 15.sp),),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 15.sp,
                    //       ),
                    //       Align(
                    //         alignment: Alignment.centerLeft,
                    //         child: Text(
                    //           "Note: Once you pay 10% of your total payment, you will be able to see the seller information.",
                    //           style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Colors.black54),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 18.sp),
        child: InkWell(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              checkoutController.makePayment(context);
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return Center(
              //       child: Padding(
              //         padding: EdgeInsets.all(18.0.sp),
              //         child: Wrap(
              //           children: [
              //             Material(
              //               borderRadius: BorderRadius.circular(8),
              //               child: Padding(
              //                 padding: const EdgeInsets.all(18.0),
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   crossAxisAlignment: CrossAxisAlignment.stretch,
              //                   children: [
              //                     Image.asset(
              //                       "assets/buyer/images/money_hand.jpg",
              //                       width: Get.width / 3,
              //                       height: Get.width / 3,
              //                     ),
              //                     SizedBox(
              //                       height: 10.sp,
              //                     ),
              //                     Text(
              //                       "Would you like to pay full payment or 10% of total?",
              //                       style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              //                       textAlign: TextAlign.center,
              //                     ),
              //                     SizedBox(
              //                       height: 25.sp,
              //                     ),
              //                     Row(
              //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Text(
              //                           "10% Payment",
              //                           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
              //                         ),
              //                         Text(
              //                           "₹ ${checkoutController.tenPercentPayAmount()}",
              //                           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
              //                         ),
              //                       ],
              //                     ),
              //                     Divider(),
              //                     Row(
              //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Text(
              //                           "Grand Total",
              //                           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
              //                         ),
              //                         Text(
              //                           "₹ ${cartController.grandTotalValue.value}",
              //                           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
              //                         ),
              //                       ],
              //                     ),
              //                     Row(
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       children: [
              //                         Expanded(
              //                           child: TextButton(
              //                               style: TextButton.styleFrom(backgroundColor: Colors.grey.shade200, padding: EdgeInsets.symmetric(vertical: 12.sp)),
              //                               onPressed: () {
              //                                 //TODO: 10% OF PAYMENT IMPLEMENT HERE.
              //                               },
              //                               child: Text("PAY 10%", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16.sp))),
              //                         ),
              //                         SizedBox(
              //                           width: 8,
              //                         ),
              //                         Expanded(
              //                           child: TextButton(
              //                             style: TextButton.styleFrom(backgroundColor: Color(0xFFF5951D), padding: EdgeInsets.symmetric(vertical: 12.sp)),
              //                             onPressed: () {
              //                               /// MAKE FULL PAYMENT
              //                               checkoutController.makePayment(context);
              //                             },
              //                             child: Text(
              //                               "MAKE FULL PAYMENT",
              //                               style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.sp),
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // );
            }
          },
          child: Container(
            width: double.infinity,
            // height: 25.sp,
            padding: EdgeInsets.symmetric(vertical: 14.sp, horizontal: 18.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xfff5951d),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Place Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
