import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/Utils/constants.dart';
import 'package:services_provider_application/modules/pending_order/pending_order_controller.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';

class PendingOrder extends StatelessWidget {
   PendingOrder({Key? key}) : super(key: key);
  PendingOrderController controller = Get.put(PendingOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SimpleAppBar('Pending Order'),

              /**
               * ?recent pending order
               */
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Recent",
                    style: TextStyle(
                      color: Color(0x66000000),
                      fontSize: 12,
                      letterSpacing: 0.24,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  returnItem(2),
                ],
              ),
              /**
               * ? order on other dates
               */
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "29 sep 2022",
                    style: TextStyle(
                      color: Color(0x66000000),
                      fontSize: 12,
                      letterSpacing: 0.24,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  returnItem(2),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "28 sep 2022",
                    style: TextStyle(
                      color: Color(0x66000000),
                      fontSize: 12,
                      letterSpacing: 0.24,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  returnItem(1),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  returnItem(int items) {
    return ListView.builder(
        itemCount: items,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) => Column(
              children: [
                InkWell(
                  onTap: (() => controller.onOrderPressed(index)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image:
                                      NetworkImage('https://picsum.photos/200'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.yellow.withOpacity(.2)),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Angle TMT",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: "Gilroy",
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.20,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: const Color(0xfff0f0f0),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 2),
                                      child: Text(
                                        "Store Id : 25448",
                                        style: TextStyle(
                                          color: Color(0xff8c8c8c),
                                          fontSize: 12,
                                          letterSpacing: 0.12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "simply dummy text of the print typesetting industry.",
                                style: TextStyle(
                                  color: Color(0x66000000),
                                  fontSize: 14,
                                  letterSpacing: 0.28,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Price : 777,000.00",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  letterSpacing: 0.14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Constants.primaryButtonColor.withOpacity(.1),
                )
              ],
            ));
  }
}
