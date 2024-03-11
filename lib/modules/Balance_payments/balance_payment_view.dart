import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/modules/Balance_payments/ballance_payment_controller.dart';

import '../../constants.dart';
import '../../widgets/simple_app_bar.dart';

class BalancePaymentView extends StatelessWidget {
  BalancePaymentView({Key? key}) : super(key: key);
  BalancePaymentController controller = Get.put(BalancePaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () => Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: controller.selectedIndex.length > 0
                    ? Constants.primaryButtonColor
                    : Color(0xffb3b3b3),
              ),
              child: Center(
                child: Text(
                  "Pay now",
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
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: SimpleAppBar('Balance Payments'),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 5,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                          onTap: (() => controller.onSelected(index)),
                          child: Obx(
                            () => Container(
                              color: controller.selectedIndex.contains(index)
                                  ? Constants.primaryButtonColor.withOpacity(.1)
                                  : Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                      color: Constants.primaryButtonColor
                                          .withOpacity(.1),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                                        BorderRadius.circular(
                                                            2),
                                                    color: !controller
                                                            .selectedIndex
                                                            .contains(index)
                                                        ? Color(0xffeaeaea)
                                                        : Color(0xffFBD3A2),
                                                  ),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
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
                                                        BorderRadius.circular(
                                                            2),
                                                    color: !controller
                                                            .selectedIndex
                                                            .contains(index)
                                                        ? Color(0xffeaeaea)
                                                        : Color(0xffFBD3A2),
                                                  ),
                                                  child: const Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 5, 10, 5),
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
                                      width: double.infinity,
                                      height: 1,
                                      color: Constants.primaryButtonColor
                                          .withOpacity(.1),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                  ],
                                ),
                              ),
                            ),
                          )),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
