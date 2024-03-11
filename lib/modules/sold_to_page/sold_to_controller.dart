import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/views/buyer/views/home_with_nav_view.dart';
import 'package:services_provider_application/views/order_tracking.dart';
import 'package:services_provider_application/widgets/TextFieldView.dart';

import '../../constants.dart';

class SoldToController extends GetxController {
  onCheckOutPressed(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Image.asset(
          'assets/images/salary_1.png',
          width: 100,
          height: 100,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                'Please approve the payment 10% of total amount to confirm this order.',
                textAlign: TextAlign.center),
            const SizedBox(
              height: 40,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Grand Total",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.24,
                      ),
                    ),
                    Text(
                      "₹ 7,87500.00",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "10% Payment",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        letterSpacing: 0.24,
                      ),
                    ),
                    Text(
                      "₹ 78750.00",
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
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15),
            child: InkWell(
              onTap: () async {
                showSuccessDialog(context);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Constants.primaryButtonColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 20),
                        child: Text('Continue Payment',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> showSuccessDialog(BuildContext context) async {
    Get.back();
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Image.asset(
                'assets/images/checked 1.png',
                width: 60,
                height: 60,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        "Congratulation, your order has been successfully placed.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff939393),
                          fontSize: 14,
                          letterSpacing: 0.28,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          Get.to(const OrderTrackingView());
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Constants.primaryButtonColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25.0, vertical: 20),
                                  child: Text('Order Tracking',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Store Rating",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Store Review",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.16,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextFieldView(
                        '',
                        'Please write a review.',
                        false,
                        maxLine: 3,
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: InkWell(
                          onTap: (()=>goToHome()),
                          child: Container(
                            width: 136,
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xfff5951d),
                            ),
                            child: const Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.28,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            letterSpacing: 0.28,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  goToHome() {
    Get.off(()=>const HomeViewNav());
  }
}
