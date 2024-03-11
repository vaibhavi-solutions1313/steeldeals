import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/constants.dart';
import 'package:services_provider_application/modules/sold_to_page/sold_to_controller.dart';

import '../../widgets/simple_app_bar.dart';

class SoldToPageView extends StatelessWidget {
  SoldToPageView({Key? key}) : super(key: key);
  final SoldToController controller = Get.put(SoldToController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /**
               * ? app bar
               */
              const SimpleAppBar('Sold by'),

              /**
               * ? delivery info ie: billed and shipped to
               */

              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Billed to",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            letterSpacing: 0.20,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          "Mr. Rajesh Singh",
                          style: TextStyle(
                            color: Color(0x7f000000),
                            fontSize: 12,
                            letterSpacing: 0.12,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          "Mobile No. 9852589651",
                          style: TextStyle(
                            color: Color(0x66000000),
                            fontSize: 12,
                            letterSpacing: 0.24,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          "Email: rajesh005@gmail.com",
                          style: TextStyle(
                            color: Color(0x66000000),
                            fontSize: 12,
                            letterSpacing: 0.24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          "Shipped to",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            letterSpacing: 0.20,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          "Name : icarePro",
                          style: TextStyle(
                            color: Color(0x7f000000),
                            fontSize: 12,
                            letterSpacing: 0.12,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          "Address : time square, NY",
                          style: TextStyle(
                            color: Color(0x66000000),
                            fontSize: 12,
                            letterSpacing: 0.24,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          "Pin Code : 5848520",
                          style: TextStyle(
                            color: Color(0x66000000),
                            fontSize: 12,
                            letterSpacing: 0.24,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          "GST : 48545865855",
                          style: TextStyle(
                            color: Color(0x66000000),
                            fontSize: 12,
                            letterSpacing: 0.24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              /**
               * ? divider
               */
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Constants.primaryButtonColor.withOpacity(.1),
                ),
              ),

              /**
               * ? bill details
               */
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [



                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Expanded(
                          child: Center(
                            child: Text(
                              "Store ID",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                letterSpacing: 0.28,
                              ),
                            ),
                          ),
                        ),


                        Expanded(
                          child: Center(
                            child: Text(
                              "Products",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                letterSpacing: 0.28,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Size",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                letterSpacing: 0.28,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Quantity",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                letterSpacing: 0.28,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Rate",
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
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color:
                    Constants.primaryButtonColor.withOpacity(.1),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text(
                            "967242",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              letterSpacing: 0.24,
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            "6 m ms \nrounded",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              letterSpacing: 0.24,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: const [
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(
                                    10, 5, 10, 5),
                                child: Text(
                                  "25*5",
                                  style: TextStyle(
                                    color: Color(0xff7b7b7b),
                                    fontSize: 12,
                                    letterSpacing: 0.24,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(
                                    10, 5, 10, 5),
                                child: Text(
                                  "35*5",
                                  style: TextStyle(
                                    color: Color(0xff7b7b7b),
                                    fontSize: 12,
                                    letterSpacing: 0.24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(2),
                                  color: const Color(0xffeaeaea),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      10, 5, 10, 5),
                                  child: Text(
                                    "500 ton.",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      letterSpacing: 0.24,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(2),
                                  color: const Color(0xffeaeaea),
                                ),
                                child: const Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(
                                      10, 5, 10, 5),
                                  child: Text(
                                    "500 ton.",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      letterSpacing: 0.24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    10, 5, 10, 5),
                                child: Text(
                                  "₹ 500.00",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    letterSpacing: 0.24,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    10, 5, 10, 5),
                                child: Text(
                                  "₹ 500.00",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    letterSpacing: 0.24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Total",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          letterSpacing: 0.24,
                        ),
                      ),
                      Text(
                        "₹,782,500.00",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          letterSpacing: 0.24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "IGST",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          letterSpacing: 0.24,
                        ),
                      ),
                      Text(
                        "₹200.00",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          letterSpacing: 0.24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "SGST",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          letterSpacing: 0.24,
                        ),
                      ),
                      Text(
                        "₹200.00",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          letterSpacing: 0.24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "CGST",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          letterSpacing: 0.24,
                        ),
                      ),
                      Text(
                        "₹200.00",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          letterSpacing: 0.24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Loading Amount",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          letterSpacing: 0.24,
                        ),
                      ),
                      Text(
                        "₹200.00",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          letterSpacing: 0.24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Tcs",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          letterSpacing: 0.24,
                        ),
                      ),
                      Text(
                        "₹200.00",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          letterSpacing: 0.24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Others",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          letterSpacing: 0.24,
                        ),
                      ),
                      Text(
                        "₹200.00",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          letterSpacing: 0.24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Grand Total",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          letterSpacing: 0.28,
                        ),
                      ),
                      Text(
                        "₹,782,500.00",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          letterSpacing: 0.28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              /**
               * ? divider
               */
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Constants.primaryButtonColor.withOpacity(.1),
                ),
              ),

              /**
               * ? sellers confirmation
               */
              Column(
                children: [
                  const Text(
                    "Awaiting seller approval message to bin",
                    style: TextStyle(
                      color: Color(0x66000000),
                      fontSize: 14,
                      letterSpacing: 0.28,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xff2e2e2e),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                "Approval",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  letterSpacing: 0.14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: Container(
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
                                "Decline",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  letterSpacing: 0.14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              /**
               * ? Check out button
               */
              InkWell(
                onTap: (() => controller.onCheckOutPressed(context)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 20),
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
                          "Check Out",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            letterSpacing: 0.14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
