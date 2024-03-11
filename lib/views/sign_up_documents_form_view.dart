import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:services_provider_application/constants.dart';
import 'package:services_provider_application/views/signup_form_view.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';

class SignUpDocuments extends StatefulWidget {
  const SignUpDocuments({super.key});

  @override
  State<SignUpDocuments> createState() => _SignUpDocumentsState();
}

class _SignUpDocumentsState extends State<SignUpDocuments> {


  @override
  void initState() {
    signupControl.onCategoryPressed(0);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF1FAFF),
              Color(0xFFFFF7EE),
            ],
          )),
          child: Column(
            children: [
              SimpleAppBar(""),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Text(
                                  'Documents',
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26, color: Color(0xFF213C63)),
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Text(
                                  'These are optional fields',
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF213C63)),
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                            //   child: SizedBox(
                            //       height:
                            //       Constants.returnScreenSize(context).height * .3,
                            //       child: SvgPicture.asset('assets/doc2.svg')),
                            // ),
                            // const Text(
                            //   'Documents',
                            //   style: TextStyle(
                            //       fontSize: 30, fontWeight: FontWeight.w600),
                            // ),
                            // const SizedBox(height: 19,),
                            // const Text(
                            //   'Upload the required document to continue.',
                            //   style: TextStyle(
                            //   fontSize: 14,
                            //   fontWeight: FontWeight.w500,
                            //   color: Colors.black38),
                            // ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 35),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                    child: Text(
                                      'Pan Card',
                                      style: TextStyle(color: Colors.black.withOpacity(.5), fontSize: 14, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      File file = await signupControl.selectDocument();
                                      signupControl.panImgPath = file.path;
                                    },
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(6),
                                      dashPattern: const [2, 2],
                                      color: const Color(0xFF808080),
                                      strokeWidth: 2,
                                      padding: EdgeInsets.zero,
                                      child: Container(
                                        decoration: BoxDecoration(color: const Color(0xFFececec), borderRadius: BorderRadius.circular(6)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Icon(
                                                  Icons.cloud_upload,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Text('Upload Documents'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                    child: Text(
                                      'Aadhaar Card',
                                      style: TextStyle(color: Colors.black.withOpacity(.5), fontSize: 14, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      File file = await signupControl.selectDocument();
                                      signupControl.aadharImgPath = file.path;
                                    },
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(6),
                                      dashPattern: const [2, 2],
                                      color: const Color(0xFF808080),
                                      strokeWidth: 2,
                                      padding: EdgeInsets.zero,
                                      child: Container(
                                        decoration: BoxDecoration(color: const Color(0xFFececec), borderRadius: BorderRadius.circular(6)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Icon(
                                                  Icons.cloud_upload,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Text('Upload Documents'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                    child: Text(
                                      'GST Documents',
                                      style: TextStyle(color: Colors.black.withOpacity(.5), fontSize: 14, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      File file = await signupControl.selectDocument();
                                      signupControl.gstImgPath = file.path;
                                    },
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(6),
                                      dashPattern: const [2, 2],
                                      color: const Color(0xFF808080),
                                      strokeWidth: 2,
                                      padding: EdgeInsets.zero,
                                      child: Container(
                                        decoration: BoxDecoration(color: const Color(0xFFececec), borderRadius: BorderRadius.circular(6)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Icon(
                                                  Icons.cloud_upload,
                                                  color: Color(0xFF808080),
                                                ),
                                              ),
                                              Text('Upload Documents'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                    child: Text(
                                      'CIN no Documents',
                                      style: TextStyle(color: Colors.black.withOpacity(.5), fontSize: 14, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      File file = await signupControl.selectDocument();
                                      signupControl.cinImgPath = file.path;
                                    },
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(6),
                                      dashPattern: const [2, 2],
                                      color: const Color(0xFF808080),
                                      strokeWidth: 2,
                                      padding: EdgeInsets.zero,
                                      child: Container(
                                        decoration: BoxDecoration(color: const Color(0xFFececec), borderRadius: BorderRadius.circular(6)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Icon(
                                                  Icons.cloud_upload,
                                                  color: Color(0xFF808080),
                                                ),
                                              ),
                                              Text('Upload Documents'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                    child: Text(
                                      'IEC no Documents',
                                      style: TextStyle(color: Colors.black.withOpacity(.5), fontSize: 14, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      File file = await signupControl.selectDocument();
                                      signupControl.iecImgPath = file.path;
                                    },
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(6),
                                      dashPattern: const [2, 2],
                                      color: const Color(0xFF808080),
                                      strokeWidth: 2,
                                      padding: EdgeInsets.zero,
                                      child: Container(
                                        decoration: BoxDecoration(color: const Color(0xFFececec), borderRadius: BorderRadius.circular(6)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Icon(
                                                  Icons.cloud_upload,
                                                  color: Color(0xFF808080),
                                                ),
                                              ),
                                              Text('Upload Documents'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              "I am here to",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                letterSpacing: 0.14,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              spacing: 10,
                              alignment: WrapAlignment.start,
                              children: [
                                returnSelector(Icons.shopping_cart_outlined, 'Buy', 0),
                                returnSelector(Icons.sell_outlined, 'Sell', 1),
                                returnSelector(Icons.fire_truck_outlined, 'Transport', 2)
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 35.0, horizontal: 30),
                              child: Row(children: [
                                Expanded(
                                    child: Divider(
                                  thickness: 2,
                                  color: Constants.primaryButtonColor,
                                  height: 1,
                                )),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Divider(thickness: 2, height: 1, color: Constants.primaryButtonColor),
                                ),
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                              child: InkWell(
                                onTap: () {
                                  context.loaderOverlay.show();
                                  try {
                                    signupControl.signUp().then((value) {
                                      context.loaderOverlay.hide();
                                      var data = jsonDecode(value.responseBody!);
                                      if (value.serverStatusCode == 201) {
                                        Constants.showSnackBar("Signed up successfully.");
                                        Future.delayed(const Duration(milliseconds: 4000), () {
                                          Get.back();
                                          Get.back();
                                        });

                                      } else if (value.serverStatusCode == 400) {
                                        Constants.showSnackBar(data['message'][data['message'].keys.first][0].toString());
                                      } else {
                                        Constants.showSnackBar("Something went wrong");
                                      }
                                    });
                                  } catch (e) {
                                    context.loaderOverlay.hide();
                                    Constants.showSnackBar("Something went wrong");
                                    // TODO
                                  }

                                  /// SIGN UP API CALLED.
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    color: Constants.primaryButtonColor,
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                                      child: Center(
                                        child: Text(
                                          'SIGN UP',
                                          style: TextStyle(color: Colors.white, fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  returnSelector(IconData icon, String text, int index) {
    return Obx(() => InkWell(
          onTap: (() => signupControl.onCategoryPressed(index)),
          child: Container(
            height: Get.width/4,
            width:  Get.width/4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: signupControl.selectedIndex.value == index ? Constants.primaryButtonColor : Colors.transparent),
                color: signupControl.selectedIndex.value == index ? Constants.primaryButtonColor.withOpacity(.05) : Constants.secondaryButtonColor.withOpacity(.05)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 24,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    letterSpacing: 0.14,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
