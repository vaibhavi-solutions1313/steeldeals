import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/constants.dart';
import 'package:services_provider_application/modules/shipping_details/shiping_detail_controller.dart';
import 'package:services_provider_application/widgets/TextFieldView.dart';

import '../../widgets/simple_app_bar.dart';

class ShippingDetailView extends StatelessWidget {
  ShippingDetailView({Key? key}) : super(key: key);
  ShippingDetailController controller = Get.put(ShippingDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /**
               * ? app bar
               */
              const SimpleAppBar('Store Details'),

              /**
               * ? sold billed to
               */
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Sold-Billed to",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      letterSpacing: 0.20,
                    ),
                  ),
                  SizedBox(height: 7.33),
                  Text(
                    "Mr. Rajesh Singh",
                    style: TextStyle(
                      color: Color(0x7f000000),
                      fontSize: 12,
                      letterSpacing: 0.12,
                    ),
                  ),
                  SizedBox(height: 7.33),
                  Text(
                    "Mobile No. 9852589651",
                    style: TextStyle(
                      color: Color(0x66000000),
                      fontSize: 12,
                      letterSpacing: 0.24,
                    ),
                  ),
                  SizedBox(height: 7.33),
                  Text(
                    "Email: rajesh005@gmail.com",
                    style: TextStyle(
                      color: Color(0x66000000),
                      fontSize: 12,
                      letterSpacing: 0.24,
                    ),
                  ),
                ],
              ),
              /**
               * ? divider
               */
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Constants.primaryButtonColor.withOpacity(.1),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),

              /**
               * ?shipping address
               */
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Shipping Address",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      letterSpacing: 0.20,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 272,
                    child: Text(
                      "c-86, park avenue street, 44b, NY",
                      style: TextStyle(
                        color: Color(0x66000000),
                        fontSize: 14,
                        letterSpacing: 0.28,
                      ),
                    ),
                  ),
                ],
              ),
              /**
               * ? divider
               */
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Constants.primaryButtonColor.withOpacity(.1),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),

              /**
               * ? check mark
               */
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => SizedBox(
                      height: 30,
                      width: 30,
                      child: Checkbox(
                        value: controller.checked.value,
                        onChanged: (value) {
                          controller.onCheckBoxChange(value);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                    child: Text(
                      "Billing Adress should be same shipping address",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        letterSpacing: 0.28,
                      ),
                    ),
                  ),
                ],
              ),

              /**
               * ? some text fields
               */
              Obx(() => controller.checked.value
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Name",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              letterSpacing: 0.14,
                            ),
                          ),
                          TextFieldView(
                              '',
                              'Enter your name',
                              textEditingController:
                                  controller.houseNoController.value,
                              false),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "House No. / Flat No.",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              letterSpacing: 0.14,
                            ),
                          ),
                          TextFieldView(
                              '',
                              'Enter your house no.',
                              textEditingController:
                                  controller.houseNoController.value,
                              false),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Landmark",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              letterSpacing: 0.14,
                            ),
                          ),
                          TextFieldView(
                              '',
                              'Enter your landmark.',
                              textEditingController:
                                  controller.houseNoController.value,
                              false),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "City",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              letterSpacing: 0.14,
                            ),
                          ),
                          TextFieldView(
                              '',
                              'Enter your city.',
                              textEditingController:
                                  controller.houseNoController.value,
                              false),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "State",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              letterSpacing: 0.14,
                            ),
                          ),
                          TextFieldView(
                              '',
                              'Enter your state.',
                              textEditingController:
                                  controller.houseNoController.value,
                              false),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "GST/PAN Card no",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              letterSpacing: 0.14,
                            ),
                          ),
                          TextFieldView(
                              '',
                              'Enter GST/PAN number',
                              textEditingController:
                                  controller.houseNoController.value,
                              false),
                          const Text(
                            "Verify",
                            style: TextStyle(
                              color: Color(0xfff5951d),
                              fontSize: 14,
                              letterSpacing: 0.14,
                            ),
                          )
                        ],
                      ),
                    )),

              /**
               * ? divider
               */

              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Constants.primaryButtonColor.withOpacity(.1),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),

              /**
               * ?bill to shop
               */

              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Bill to shop",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      letterSpacing: 0.20,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    "Name : icarePro",
                    style: TextStyle(
                      color: Color(0x7f000000),
                      fontSize: 12,
                      letterSpacing: 0.12,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    "Address : time square, NY",
                    style: TextStyle(
                      color: Color(0x66000000),
                      fontSize: 12,
                      letterSpacing: 0.24,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    "Pin Code : 5848520",
                    style: TextStyle(
                      color: Color(0x66000000),
                      fontSize: 12,
                      letterSpacing: 0.24,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    "GST : 48545865855",
                    style: TextStyle(
                      color: Color(0x66000000),
                      fontSize: 12,
                      letterSpacing: 0.24,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Constants.primaryButtonColor.withOpacity(.1),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              /**
               * ? check out button
               */


              InkWell(
                onTap: (() => controller.onCheckOutPressed()),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Constants.primaryButtonColor,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Check Out",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          letterSpacing: 0.14,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
