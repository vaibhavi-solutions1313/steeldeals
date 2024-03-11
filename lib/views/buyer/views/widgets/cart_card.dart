import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../main.dart';
import '../../../../widgets/dashed_divider.dart';
import '../../model/cart_reformat_model.dart';
import 'cart_card_product.dart';

class CartCard extends StatefulWidget {
  final CartReformatModel? data;
  final int index;
  const CartCard({Key? key, this.data, required this.index}) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  double gstTotal = 0.0;
  bool isExpanded = false;
  ExpansionTile? expansionTile;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.data!.productList!.forEach((element) {
        if (element.gst != null) {
          gstTotal += double.parse(element.gst.toString());
        }
        setState(() {});
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isExpanded,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15.sp),
          border: Border.all(width: 2, color: Colors.grey.shade200),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
        child: Theme(
          data: ThemeData(
            useMaterial3: true,
            dividerColor: Colors.transparent,
            expansionTileTheme: ExpansionTileThemeData(
                // collapsedBackgroundColor: Colors.orangeAccent.withOpacity(0.2),
                // backgroundColor: Colors.orangeAccent.withOpacity(0.1),
                ),
          ),
          child: ExpansionTile(
            maintainState: true,
            childrenPadding: EdgeInsets.symmetric(horizontal: 12.sp),
            title: Text(
              widget.data!.allName.toString(),
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.8)),
            ),
            subtitle: Text(
              'Sold By : ${widget.data!.sellerName}',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
            ),
            trailing: Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // OutlinedButton(
                //   style: OutlinedButton.styleFrom(
                //     maximumSize: Size(8.h, 3.h),
                //     minimumSize: Size(8.h, 3.h),
                //     padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                //   ),
                //   onPressed: () {
                //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Coming soon")));
                //   },
                //   child: Text(
                //     "Bargain",
                //     style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.75)),
                //   ),
                // ),
                // SizedBox(
                //   width: 8,
                // ),
                Text(
                  cartController.reformattedNumbers(widget.data!.totalPrice!, true),
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.7)),
                ),
                SizedBox(
                  width: 3,
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 18.sp,
                )
              ],
            ),
            // Contents
            children: [
              /// PRODUCTS AND ITS VARIATIONS
              ListView.separated(
                itemCount: widget.data!.productList!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index2) {
                  return CartCardProduct(
                    index: index2,
                    data: widget.data!.productList![index2],
                  );
                },
                separatorBuilder: (context, index) {
                  return MySeparator(
                    color: Colors.black12,
                  );
                },
              ),

              /// VIEW SUMMARY
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Summary",
                      style: TextStyle(fontSize: 16.sp, height: 3, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "GST",
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "₹${gstTotal}",
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "IGST",
                  //       style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                  //     ),
                  //     Text(
                  //       "₹${widget.data!.summary!.igst}",
                  //       style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "SGST",
                  //       style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                  //     ),
                  //     Text(
                  //       "₹${widget.data!.summary!.sgst}",
                  //       style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "CGST",
                  //       style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                  //     ),
                  //     Text(
                  //       "₹${widget.data!.summary!.cgst}",
                  //       style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "LOADING AMOUNT",
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "₹${widget.data!.summary!.loadingAmount}",
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TCS",
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "₹${widget.data!.summary!.tcs}",
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "INSURANCE",
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "₹${widget.data!.summary!.insurance}",
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "OTHERS",
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "₹${widget.data!.summary!.others}",
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TOTAL",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        cartController.reformattedNumbers(widget.data!.summary!.grandTotal!, true),
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),

              /// MINIMISED BUTTON
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.orangeAccent.withOpacity(0.3),
                  maximumSize: Size(double.infinity, 4.h),
                  minimumSize: Size(double.infinity, 4.h),
                ),
                onPressed: () {
                  setState(() {
                    isExpanded = true;
                    Future.delayed(Duration(milliseconds: 30), () {
                      isExpanded = false;
                      setState(() {});
                    });
                  });
                },
                child: Text(
                  "Minimised View",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.85)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
