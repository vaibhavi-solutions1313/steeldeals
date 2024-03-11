import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/constants.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';
import '../../../main.dart';
import 'order_detail_view.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {
    customerHistoryControl.selectedOrderStatus.value = 0;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SimpleAppBar("Orders"),
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 8.sp),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
                Constants.orderStatusList.length, (index) => returnChip(index, Constants.orderStatusList[index]['name'], Constants.orderStatusList[index]['id'])),
          ),
        ),
        /**
         * ? order list
         */

        Expanded(
          child: Obx(
            () => customerHistoryControl.orderSortedList.isNotEmpty
                ? ListView.builder(
                    itemCount: customerHistoryControl.orderSortedList.length,
                    padding: EdgeInsets.symmetric(horizontal: 18.sp),
                    // separatorBuilder: (context, index) {
                    //   return Divider(color: Colors.grey.shade300,);
                    // },
                    itemBuilder: (ctx, index) {
                      DateTime now = DateTime.parse(customerHistoryControl.orderSortedList[index]['created_at']);
                      String formattedDate = DateFormat('dd, MMMM, yyyy').format(now);
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.sp),
                        child: InkWell(
                          onTap: () {
                            Get.to(OrderDetailView(data: customerHistoryControl.orderSortedList[index]), transition: Transition.rightToLeft);
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Coming Soon")));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12.sp),
                              border: Border.all(width: 2.sp, color: Colors.grey.shade200),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        // TODO: // API CHANGES LEFT
                                        width: Get.width / 4,
                                        height: Get.width / 4,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(12.sp),
                                          border: Border.all(width: 2.sp, color: Colors.grey.shade200),
                                        ),
                                        child: Image.network(
                                          customerHistoryControl.reformatImages(
                                            customerHistoryControl.orderSortedList[index]['items'],
                                          ),
                                          errorBuilder: (context, error, stackTrace) {
                                            return Center(
                                              child: Text(
                                                "No Image",
                                                style: TextStyle(fontSize: 12.sp),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 15.sp),
                                      Flexible(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              customerHistoryControl.reformatName(customerHistoryControl.orderSortedList[index]['items']),
                                              style: TextStyle(
                                                color: Color(0xff3b3b3b),
                                                fontSize: 16.sp,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: 6.sp),
                                            Text(
                                              "₹ ${customerHistoryControl.orderSortedList[index]['grand_total'].toString()}",
                                              style: TextStyle(
                                                color: Color(0xff5f5f5f),
                                                fontSize: 14.sp,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: 4.sp),
                                            Text(
                                              customerHistoryControl.orderSortedList[index]['order_status'] ?? "Not Available",
                                              style: TextStyle(
                                                color: Colors.black.withOpacity(0.75),
                                                fontSize: 14.sp,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 14.sp),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.0.sp, horizontal: 12.sp),
                                  child: Text(
                                    formattedDate,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13.sp,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                    "Nothing found!",
                    style: TextStyle(fontSize: 16.sp),
                  )),
          ),
        )
      ]),
    );
  }

  returnChip(int index, String title, int id) {
    return Padding(
      padding: EdgeInsets.only(right: 10.0.sp),
      child: InkWell(
          onTap: (() => customerHistoryControl.onOrderStatusChanged(index, id)),
          child: Obx(
            () => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                color: customerHistoryControl.selectedOrderStatus.value == index ? Constants.primaryButtonColor : Colors.grey.shade200,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
                child: Text(
                  title,
                  style: TextStyle(
                    color: customerHistoryControl.selectedOrderStatus.value == index ? Colors.white : const Color(0xff4d4d4d),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
