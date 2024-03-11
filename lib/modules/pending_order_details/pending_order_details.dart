import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/modules/pending_order_details/pending_order_details_controller.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';

import '../../constants.dart';

class PendingOrderDetails extends StatelessWidget {
  PendingOrderDetails({Key? key}) : super(key: key);
  PendingOrderDetailsController controller =
      Get.put(PendingOrderDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /**
               * ? app bar
               */
              const SimpleAppBar('Pending Order'),
              /**
               * ? order overview
               */
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Recent",
                    style: TextStyle(
                      color: Color(0x66000000),
                      fontSize: 12,
                      letterSpacing: 0.24,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 54,
                        height: 52,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image:
                                    NetworkImage('https://picsum.photos/200'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.yellow.withOpacity(.2)),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Angle TMT",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.20,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "₹,782,000.00",
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
                ],
              ),

              /**
               * ? order info
               */
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    color: Constants.primaryButtonColor.withOpacity(.1),
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: const Color(0xffeaeaea)),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: FittedBox(
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
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: const Color(0xffeaeaea)),
                                child: const Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: FittedBox(
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
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: FittedBox(
                                  child: Text(
                                    "₹ 500.00",
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
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: FittedBox(
                                  child: Text(
                                    "₹ 500.00",
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
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Constants.primaryButtonColor.withOpacity(.1),
                  ),
                ],
              ),
              /**
               * ?order recipt
               */
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                      const SizedBox(height: 14),
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
                      const SizedBox(height: 14),
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
                      const SizedBox(height: 14),
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
                      const SizedBox(height: 14),
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
                      const SizedBox(height: 14),
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
                      const SizedBox(height: 14),
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
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Constants.primaryButtonColor.withOpacity(.1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
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
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Constants.primaryButtonColor.withOpacity(.1),
                  ),
                ],
              ),
              /**
               * ? action buttom
               */

              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: (() => controller.onButtonPressed()),
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xfff5951d),
                      ),
                      child: Center(
                          child: Obx(
                        () => Text(
                          controller.buttonSwtich.value
                              ? "Waiting"
                              : 'Declined',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Gilroy",
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.14,
                          ),
                        ),
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
