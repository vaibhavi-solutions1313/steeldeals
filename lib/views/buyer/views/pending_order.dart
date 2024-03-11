import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';
import '../../../main.dart';

class PendingOrder extends StatefulWidget {
  PendingOrder({Key? key}) : super(key: key);

  @override
  State<PendingOrder> createState() => _PendingOrderState();
}

class _PendingOrderState extends State<PendingOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SimpleAppBar('Pending Order'),
          Expanded(
            child: Obx(() => ListView.builder(
                itemCount: customerPendingOrderControl.orderPendingHistoryList.length,
                padding: EdgeInsets.symmetric(horizontal: 18),
                itemBuilder: (ctx, index) {
                  DateTime now = DateTime.parse(customerPendingOrderControl.orderPendingHistoryList[index]['created_at']);
                  String formattedDate = DateFormat('dd, MMMM, yyyy').format(now);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Coming Soon")));
                        // Get.to(OrdersDetailView());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(width: 2, color: Colors.grey.shade200),
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
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(width: 2, color: Colors.grey.shade200),
                                    ),
                                    child: Image.network(
                                      customerPendingOrderControl.reformatImages(
                                        customerPendingOrderControl.orderPendingHistoryList[index]['items'],
                                      ),
                                      errorBuilder: (context, error, stackTrace) {
                                        return Center(
                                            child: Text(
                                          "No Image",
                                          style: TextStyle(fontSize: 10),
                                        ));
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        customerPendingOrderControl.reformatName(customerPendingOrderControl.orderPendingHistoryList[index]['items']),
                                        style: TextStyle(
                                          color: Color(0xff3b3b3b),
                                          fontSize: 14,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "₹ ${customerPendingOrderControl.orderPendingHistoryList[index]['grand_total'].toString()}",
                                        style: TextStyle(
                                          color: Color(0xff5f5f5f),
                                          fontSize: 13,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        customerPendingOrderControl.orderPendingHistoryList[index]['order_status'] ?? "Not Available",
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.75),
                                          fontSize: 13,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                              child: Text(
                                formattedDate,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 10,
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
                })),
          ),
        ],
      ),
    );
  }
}
