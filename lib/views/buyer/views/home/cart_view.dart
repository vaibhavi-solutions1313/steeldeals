import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../main.dart';
import '../../model/cart_reformat_model.dart';
import '../checkout_view.dart';
import '../widgets/cart_card.dart';

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
      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       Color(0xFFF1FAFF),
        //       Color(0xFFFFF7EE),
        //     ],
        //   ),
        // ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(18.0.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        "CART (${cartController.cartItemsList.length})",
                        style: TextStyle(fontSize: 16.sp, color: Color(0xFF213C63), fontWeight: FontWeight.w700),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor:
                              cartController.cartItemsList.isNotEmpty && cartController.isCartEmpty.value == false ? Colors.orange.withOpacity(0.3) : Colors.grey.shade200),
                      onPressed: cartController.cartItemsList.isNotEmpty && cartController.isCartEmpty.value == false
                          ? () {
                              Get.defaultDialog(
                                  title: "Cart",
                                  titleStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.75)),
                                  content: Text(
                                    "Do you want to clear your cart?",
                                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.75)),
                                  ),
                                  actions: [
                                    TextButton(
                                      style: TextButton.styleFrom(backgroundColor: Colors.orangeAccent),
                                      onPressed: () async {
                                        Get.back();
                                      },
                                      child: Text(
                                        "NO",
                                        style: TextStyle(color: Colors.white70, fontSize: 16.sp),
                                      ),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(backgroundColor: Colors.orangeAccent),
                                      onPressed: () async {
                                        Get.back();
                                        cartController.emptyCart(context).then((value) {
                                          setState(() {});
                                        });
                                      },
                                      child: Text(
                                        "YES",
                                        style: TextStyle(color: Colors.white70, fontSize: 16.sp),
                                      ),
                                    ),
                                  ]);
                            }
                          : null,
                      child: Text(
                        ""
                            "Clear Cart",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: cartController.cartItemsList.isNotEmpty
                              ? Colors.black.withOpacity(
                                  0.75,
                                )
                              : Colors.grey.shade400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Obx(() => FutureBuilder<List<CartReformatModel>>(
                    future: cartController.refreshCart.value == false ? cartController.getCartItems() : null,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.orangeAccent,
                            ),
                          ),
                        );
                      }
                      if (snapshot.hasData) {
                        if (snapshot.data!.isNotEmpty) {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            cartController.isCartEmpty.value = false;
                          });

                          return Expanded(
                            child: ListView.builder(
                              cacheExtent: 999999999999999,
                              padding: EdgeInsets.symmetric(horizontal: 18.sp),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.0.sp),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.sp),
                                    child: CartCard(
                                      data: snapshot.data![index],
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            cartController.isCartEmpty.value = true;
                          });
                          return Expanded(
                            child: Center(
                              child: Image.asset(
                                "assets/empty_cart.gif",
                                width: Adaptive.w(35),
                              ),
                            ),
                          );
                        }
                      } else {
                        return Expanded(
                          child: Center(
                            child: Image.asset(
                              "assets/empty_cart.gif",
                              width: Adaptive.w(35),
                            ),
                          ),
                        );
                      }
                    },
                  )),

              /**
               * ? total
               */
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() => cartController.grandTotalValue.value.isNotEmpty && cartController.isCartEmpty.value == false
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
                          child: Divider(
                            color: Colors.orangeAccent,
                            thickness: 0.4,
                          ),
                        )
                      : Row()),
                  Obx(() => cartController.grandTotalValue.value.isNotEmpty && cartController.isCartEmpty.value == false
                      ? Container(
                          width: double.infinity,
                          // decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Taxes",
                                      style: TextStyle(
                                        color: Color(0xFF213C63),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.40,
                                      ),
                                    ),
                                    Text(
                                      "${cartController.reformattedNumbers(cartController.gst.value, true)}",
                                      style: TextStyle(
                                        color: Color(0xFF213C63),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.40,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Grand Total",
                                      style: TextStyle(
                                        color: Color(0xFF213C63),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.40,
                                      ),
                                    ),
                                    Text(
                                      "${cartController.reformattedNumbers(cartController.total.value, true)}",
                                      style: TextStyle(
                                        color: Color(0xFF213C63),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.40,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : Row()),
                  /**
                  * ? button
                  */
                  Obx(() => Visibility(
                        visible: cartController.cartItemsList.isNotEmpty,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 20.sp),
                          child: InkWell(
                            onTap: cartController.grandTotalValue.value.isNotEmpty && cartController.isCartEmpty.value == false
                                ? () {
                                    // SEND TO CHECKOUT
                                    Get.to(CheckoutScreen(), transition: Transition.rightToLeft)?.then((value) {
                                      setState(() {});
                                    });
                                  }
                                : null,
                            child: Container(
                              width: double.infinity,
                              height: 28.sp,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp),
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
                      )),
                  SizedBox(
                    height: Adaptive.h(10),
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
