import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';


class OrdersDetailView extends StatefulWidget {
  final dynamic data;

  const OrdersDetailView({Key? key, this.data}) : super(key: key);

  @override
  State<OrdersDetailView> createState() => _OrdersDetailViewState();
}

class _OrdersDetailViewState extends State<OrdersDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SimpleAppBar('Order details'),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 18.sp),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ram Steem works Pvt.Ltd.',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), border: Border.all(color: Colors.grey)),
                          child: const Padding(
                            padding: EdgeInsets.all(3),
                            child: Icon(Icons.phone, size: 18),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), border: Border.all(color: Colors.grey)),
                          child: const Padding(
                            padding: EdgeInsets.all(3),
                            child: Icon(Icons.message, size: 18),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.black54,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'simply dummy text industry. simply dummy text industry. '
                          'simply dummy text industry.',
                          style: TextStyle(fontSize: 12, color: Colors.black54, overflow: TextOverflow.ellipsis),
                          maxLines: 2,
                        ),
                      ),
                      Expanded(flex: 1, child: SizedBox()),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Get.to(const StoreDetailsView());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network('https://picsum.photos/200'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('6 mm rs rounded',
                                      style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis)),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 6.0),
                                    child: Text(
                                      'Price 2,75,000',
                                      style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
                                      maxLines: 2,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      DropdownButton<String>(
                                        items: <String>['500', '600', '700', '1000'].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                            ),
                                          );
                                        }).toList(),
                                        value: '500',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        onChanged: (_) {},
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        margin: const EdgeInsets.symmetric(horizontal: 8),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), border: Border.all(color: Colors.grey)),
                                        child: const Icon(Icons.phone, size: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: const [
                      Text(
                        'Delivery Address',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.black54,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Wrap(
                          children: const [
                            Text(
                              'simply dummy text industry. simply dummy text industry. '
                              'simply dummy text industry.',
                              style: TextStyle(fontSize: 12, color: Colors.black54, overflow: TextOverflow.ellipsis),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: TextButton(onPressed: () {}, child: Text('Change')),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: const [
                      Text(
                        'Payment Method',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'VISA',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          // Text('Visa Classics'),
                          Text(
                            '**** **** **** 4582',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black45),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: const [
                      Text(
                        'Order Info',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Sub Total', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54)),
                    Text('₹ 2,7500', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54))
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Shipping Cost', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54)),
                    Text('₹ 250', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54))
                  ],
                ),
                const Divider(thickness: 1.2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Grand Total', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    Text('₹ 27,750', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15),
      //   child: InkWell(
      //     onTap: () async {
      //       await showDialog(
      //         context: context,
      //         builder: (context) => AlertDialog(
      //           title: Image.asset(
      //             'assets/images/checked 1.png',
      //             width: 60,
      //             height: 60,
      //           ),
      //           content: const Text('simply dummy text of the printing and typesetting industry.', textAlign: TextAlign.center),
      //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      //           actions: <Widget>[
      //             Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15),
      //               child: InkWell(
      //                 onTap: () async {
      //                   Get.to(const OrderTrackingView());
      //                 },
      //                 child: ClipRRect(
      //                   borderRadius: BorderRadius.circular(20),
      //                   child: Container(
      //                     color: Constants.primaryButtonColor,
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: const [
      //                         Padding(
      //                           padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
      //                           child: Text('Order Tracking', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             )
      //           ],
      //         ),
      //       );
      //     },
      //     child: ClipRRect(
      //       borderRadius: BorderRadius.circular(20),
      //       child: Container(
      //           color: Constants.primaryButtonColor,
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: const [
      //               Padding(
      //                 padding: EdgeInsets.all(25.0),
      //                 child: Text('Checkout', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600)),
      //               ),
      //             ],
      //           )),
      //     ),
      //   ),
      // ),
    );
  }
}
