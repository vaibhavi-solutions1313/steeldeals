import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/constants.dart';

import '../../../../apis/buyer/cart_apis.dart';
import '../../../../main.dart';
import '../../model/cart_reformat_model.dart';

class CartCardProduct extends StatefulWidget {
  final int index;
  final ProductList? data;
  const CartCardProduct({
    super.key,
    required this.index,
    this.data,
  });

  @override
  State<CartCardProduct> createState() => _CartCardProductState();
}

class _CartCardProductState extends State<CartCardProduct> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // visualDensity: VisualDensity(vertical: 3), // to expand
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.sp),
        child: Container(
          color: Colors.grey.shade400,
          width: Get.width / 6,
          height: Get.width / 6,
          child: Image.network((Constants.baseUrl + widget.data!.productImage!) ?? "", fit: BoxFit.cover),
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              widget.data!.productName!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.8)),
            ),
          ),
          Row(
            children: [
              // InkWell(
              //   onTap: () {
              //     // TODO: EDIT ITEM FROM CART IMPLEMENTATION
              //   },
              //   child: Tooltip(
              //     message: "Edit Item",
              //     child: Container(
              //       decoration: BoxDecoration(color: Colors.orangeAccent.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
              //       padding: EdgeInsets.all(6),
              //       child: Icon(
              //         Icons.edit,
              //         color: Colors.black,
              //         size: 18.sp,
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   width: 4,
              // ),
              InkWell(
                onTap: () {
                  // TODO: REMOVE ITEM FROM CART IMPLEMENTATION
                  context.loaderOverlay.show();
                  try {
                    CartApis().removeItem(widget.data!.productId!).then((value) {
                      context.loaderOverlay.hide();
                      if (value.serverStatusCode == 200) {
                        cartController.refreshCart.value = true;
                        cartController.refreshCart.value = false;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong!")));
                      }
                    });
                  } catch (e) {
                    context.loaderOverlay.hide();
                    // TODO
                  }
                },
                child: Tooltip(
                  message: "Remove Item",
                  child: Container(
                    decoration: BoxDecoration(color: Colors.orangeAccent.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.all(6.sp),
                    child: Icon(
                      Icons.remove,
                      color: Colors.black,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      subtitle: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.sp),
          child: Column(
            children: [
              /// VARIATION INFO
              Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 2.sp, horizontal: 2.sp),
                      decoration: BoxDecoration(color: Color(0xFFF5951D), borderRadius: BorderRadius.circular(4.sp)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Size',
                              style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                            Divider(height: 2.sp,),
                            Text(
                              '${widget.data!.size}',
                              style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 2.sp, horizontal: 2.sp),
                      decoration: BoxDecoration(color: Colors.grey[500], borderRadius: BorderRadius.circular(4.sp)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0.sp),
                        child: Column(
                          children: [
                            Text(
                              'Quantity',
                              style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                            Divider(height: 2.sp,),
                            Text(
                              widget.data!.quantity!,
                              style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 2.sp, horizontal: 2.sp),
                      decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Rate',
                              style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                            Divider(height: 2.sp,),
                            Text(
                              cartController.reformattedNumbers(widget.data!.amount!,false),
                              style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      isThreeLine: true,
    );
  }
}
