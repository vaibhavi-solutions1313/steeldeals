import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/main.dart';
import '../../../../../constants.dart';
import '../../order_summary_view/order_summary_view.dart';

class SellerOrdersTab extends StatefulWidget {
  const SellerOrdersTab({Key? key}) : super(key: key);

  @override
  State<SellerOrdersTab> createState() => _SellerOrdersTabState();
}

class _SellerOrdersTabState extends State<SellerOrdersTab> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      homeSellerController.selectedOrderStatus.value = Constants.orderStatusList[0];
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SafeArea(
        child: Column(
          children: [
            // SafeArea(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       IconButton(onPressed: () {}, icon: const Icon(Icons.undo)),
            //       Text("My Orders", style: TextStyle(color: Color(0xFF213C63), fontSize: 21, fontWeight: FontWeight.w700)),
            //       IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 8,
            ),
            Obx(() => SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12.sp,vertical: 8.sp),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      Constants.orderStatusList.length,
                      (index) => GestureDetector(
                        onTap: () {
                          homeSellerController.selectedOrderStatus.value = Constants.orderStatusList[index];
                          setState(() {});
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.0.sp),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.sp),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 8.sp),
                              decoration: BoxDecoration(
                                  color: homeSellerController.selectedOrderStatus.value == Constants.orderStatusList[index] ? Color(0xFFF5951D) : Colors.white),
                              child: Center(
                                child: Text(
                                  Constants.orderStatusList[index]['name'].toString(),
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: homeSellerController.selectedOrderStatus.value == Constants.orderStatusList[index] ? Colors.white : Colors.black87),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
            Expanded(
              child: FutureBuilder<dynamic>(
                future: homeSellerController.getOrdersList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                          child: LinearProgressIndicator(minHeight: 25.sp, color: Color(0xFFF5951D), backgroundColor: Colors.grey.withOpacity(0.2)),
                        );
                      },
                    );
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data.isNotEmpty) {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 18.0.sp, vertical: 10.sp),
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 4.sp),
                            margin: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 5.sp),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), shape: BoxShape.rectangle, boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                              ),
                            ]),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  child: Container(
                                    height: 30.sp,
                                    width: 30.sp,
                                    color: Colors.black38,
                                    child: Image.network(
                                      snapshot.data[index]['product']['instock']['images'] != [] ? snapshot.data[index]['product']['instock']['images'][0].toString() : "",
                                      errorBuilder: (context, error, stackTrace) {
                                        return Center(
                                            child: Text(
                                          "Error on image",
                                          style: TextStyle(fontSize: 16.sp),
                                          textAlign: TextAlign.center,
                                        ));
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15.sp,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        snapshot.data[index]['product']['name'].toString(),
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16.sp),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      // Text(
                                      //   "Order ID: ${snapshot.data[index]['order']['order_number'].toString()}",
                                      //   style: TextStyle(fontSize: 12),
                                      // ),
                                      Text(
                                        "₹ ${snapshot.data[index]['total'].toString()}",
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 18.0),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        borderRadius: BorderRadius.circular(25.sp),
                                        onTap: () {
                                          log(snapshot.data[index].toString());
                                          if (snapshot.data[index]['order'] != null) {
                                            Get.to(OrderSummaryView(data: snapshot.data[index]), transition: Transition.rightToLeft);
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Order")));
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0.sp, vertical: 10.sp),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Details",
                                                  style: TextStyle(fontSize: 16.sp),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Color(0xFFF5951D),
                                                  size: 18.sp,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text("No Orders Found!"));
                    }
                  } else {
                    return Center(child: Text("No Orders Found!"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
