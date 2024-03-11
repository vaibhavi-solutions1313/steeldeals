import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/Utils/constants.dart';
import 'package:services_provider_application/controllers/order_history_controller.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final controller = Get.put(OrderHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            /**
             * ? app bar
             */

            const SimpleAppBar('Orders'),
            /**
             * ? choose type of order
             */
            Row(
              children: [
                returnChip(0, 'All order'),
                const SizedBox(
                  width: 10,
                ),
                returnChip(1, 'Pending'),
                const SizedBox(
                  width: 10,
                ),
                returnChip(2, 'Processing'),
                const SizedBox(
                  width: 10,
                ),
                returnChip(3, 'Delivered'),
              ],
            ),
            /**
             * ? order list
             */

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: (() => controller.goToTrackOrder()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    width: 65,
                                    height: 65,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(image: NetworkImage('https://picsum.photos/200'), fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "6 mm rs rounded",
                                        style: TextStyle(
                                          color: Color(0xff3b3b3b),
                                          fontSize: 14,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "₹ 200.000,75",
                                        style: TextStyle(
                                          color: Color(0xff5f5f5f),
                                          fontSize: 13,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Processing",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "5 June, 2022",
                              style: TextStyle(
                                color: Color(0xff575757),
                                fontSize: 10,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ]),
        ),
      ),
    );
  }

  returnChip(int index, String title) {
    return InkWell(
        onTap: (() => controller.onOrderStatusChanged(index,7)),
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: controller.selectedOrderStatus.value == index ? Constants.primaryButtonColor : const Color(0xffdfdfdf),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                title,
                style: TextStyle(
                  color: controller.selectedOrderStatus.value == index ? Colors.white : const Color(0xff4d4d4d),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ));
  }
}
