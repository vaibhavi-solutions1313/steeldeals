import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/controllers/order_tracking_controller.dart';
import 'package:timelines/timelines.dart';

import '../widgets/simple_app_bar.dart';

class OrderTrackingView extends StatefulWidget {
  const OrderTrackingView({Key? key}) : super(key: key);

  @override
  State<OrderTrackingView> createState() => _OrderTrackingViewState();
}

class _OrderTrackingViewState extends State<OrderTrackingView> {
  final orderTrackingControl = Get.put(OrderTrackingController());

  List sampleTrackingData = [
    {"title": "Delivery Time", "detail": "Distance from you", "time": DateTime.now()},
    {"title": "Delivery Address", "detail": "A-32 Anand Nagar , Moti Vihar", "time": DateTime.now()},
  ];

  @override
  Widget build(BuildContext context) {
    bool isEdgeIndex(int index) {
      return index == 0 || index == 5 + 1;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SimpleAppBar('Order tracking'),
            Expanded(
              child: Container(
                // height: MediaQuery.of(context).size.height / 2 + 280,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: const Color(0xFFF2F2F2),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.network('https://picsum.photos/200/300/?blur', fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Elon Musk', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.7))),
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.yellow,
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.yellow,
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.yellow,
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.yellow,
                                          ),
                                          Icon(
                                            Icons.star_half,
                                            size: 16,
                                            color: Colors.yellow,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.phone,
                                      color: Color(0xFF6C9674),
                                    ),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.message,
                                      color: Color(0xFF6C9674),
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                      child: FixedTimeline.tileBuilder(
                        theme: TimelineTheme.of(context).copyWith(
                          nodePosition: 0,
                          connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
                                thickness: 1.0,
                              ),
                          indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
                                size: 30.0,
                                position: 0.5,
                              ),
                        ),
                        builder: TimelineTileBuilder(
                          indicatorBuilder: (_, index) => !isEdgeIndex(index)
                              ? Indicator.outlined(
                                  borderWidth: 1.0,
                                  color: Colors.grey,
                                )
                              : null,
                          startConnectorBuilder: (_, index) => Connector.dashedLine(
                            dash: 5,
                            gap: 2,
                            color: Colors.grey,
                          ),
                          endConnectorBuilder: (_, index) => Connector.dashedLine(
                            dash: 5,
                            gap: 2,
                            color: Colors.grey,
                          ),
                          contentsBuilder: (_, index) {
                            if (isEdgeIndex(index)) {
                              return null;
                            }

                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Wrap(
                                direction: Axis.vertical,
                                children: [
                                  Text(
                                    sampleTrackingData[index - 1]['title'].toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                  Text(
                                    sampleTrackingData[index - 1]['detail'].toString(),
                                    style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.black54),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemExtentBuilder: (_, index) => isEdgeIndex(index) ? 30.0 : 100.0,
                          nodeItemOverlapBuilder: (_, index) => isEdgeIndex(index) ? true : null,
                          itemCount: sampleTrackingData.length + 1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: const Color(0xFFF2F2F2),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset('assets/images/rating 1.png', fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Don’t Forget the rate', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                                      const Text('simply dummy text of the printing.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Obx(
                                          () => Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  orderTrackingControl.selectedRatingIndex.value = 1;
                                                },
                                                child: Icon(
                                                  Icons.star,
                                                  size: 20,
                                                  color: orderTrackingControl.selectedRatingIndex.value >= 1 ? Colors.yellow : Colors.grey,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  orderTrackingControl.selectedRatingIndex.value = 2;
                                                },
                                                child: Icon(
                                                  Icons.star,
                                                  size: 20,
                                                  color: orderTrackingControl.selectedRatingIndex.value >= 2 ? Colors.yellow : Colors.grey,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  orderTrackingControl.selectedRatingIndex.value = 3;
                                                },
                                                child: Icon(
                                                  Icons.star,
                                                  size: 20,
                                                  color: orderTrackingControl.selectedRatingIndex.value >= 3 ? Colors.yellow : Colors.grey,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  orderTrackingControl.selectedRatingIndex.value = 4;
                                                },
                                                child: Icon(
                                                  Icons.star,
                                                  size: 20,
                                                  color: orderTrackingControl.selectedRatingIndex.value >= 4 ? Colors.yellow : Colors.grey,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  orderTrackingControl.selectedRatingIndex.value = 5;
                                                },
                                                child: Icon(
                                                  Icons.star,
                                                  size: 20,
                                                  color: orderTrackingControl.selectedRatingIndex.value >= 5 ? Colors.yellow : Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
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
      ),
    );
  }
}
