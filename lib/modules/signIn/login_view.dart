import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/constants.dart';
import 'package:services_provider_application/modules/signIn/sign_in_controller.dart';
import 'package:services_provider_application/views/signup_form_view.dart';
import 'package:services_provider_application/views/verification_page.dart';

import '../../main.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  SignInController controller = Get.put(SignInController());

  @override
  void initState() {
    controller.selectedObject.addAll({"type": "buyer"});
    box.write(Constants.USERTYPE, 1);
    signupControl.emailController.clear();
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
          child: SizedBox(
            height: Constants.returnScreenSize(context).height,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(18.0.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Login to Steel Deals',
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 21.sp, color: Color(0xFF213C63)),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                          //   child: SizedBox(
                          //       height:
                          //           Constants.returnScreenSize(context).height * .3,
                          //       child: SvgPicture.asset('assets/signin1.svg')),
                          // ),
                          // const Text(
                          //   'Log in',
                          //   style: TextStyle(
                          //       fontSize: 30, fontWeight: FontWeight.w400),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(0, 10, 40, 20),
                          //   child: Row(
                          //     children: const [
                          //       Expanded(
                          //           child: Text(
                          //         'Enter your mobile number or email address to continue',
                          //         style: TextStyle(
                          //             fontSize: 14,
                          //             fontWeight: FontWeight.w400,
                          //             color: Colors.black38),
                          //       ))
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 18.0.sp, right: 18.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Email / Mobile Number',
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Container(
                            decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(15)),
                            child: TextField(
                              controller: signupControl.emailController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Email / Mobile Number ',
                                hintStyle: TextStyle(fontSize: 16.sp),
                                border: OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                contentPadding: EdgeInsets.all(10.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 18.sp),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Login as",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                letterSpacing: 0.14,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.sp),
                              child: Obx(() => Wrap(
                                    spacing: 10.sp,
                                    alignment: WrapAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.selectedObject.addAll({"type": "buyer"});
                                          box.write(Constants.USERTYPE, 1);
                                        },
                                        child: Container(
                                          height: 32.sp,
                                          width: 32.sp,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15.sp),
                                              border: Border.all(color: controller.selectedObject['type'] == "buyer" ? Constants.primaryButtonColor : Colors.transparent),
                                              color: controller.selectedObject['type'] == "buyer"
                                                  ? Constants.primaryButtonColor.withOpacity(.05)
                                                  : Constants.secondaryButtonColor.withOpacity(.05)),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.shopping_cart_outlined,
                                                size: 18.sp,
                                              ),
                                              SizedBox(
                                                height: 10.sp,
                                              ),
                                              Text(
                                                "Buyer",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  letterSpacing: 0.14,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.selectedObject.addAll({"type": "seller"});
                                          box.write(Constants.USERTYPE, 2);
                                        },
                                        child: Container(
                                          height: 32.sp,
                                          width: 32.sp,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              border: Border.all(color: controller.selectedObject['type'] == "seller" ? Constants.primaryButtonColor : Colors.transparent),
                                              color: controller.selectedObject['type'] == "seller"
                                                  ? Constants.primaryButtonColor.withOpacity(.05)
                                                  : Constants.secondaryButtonColor.withOpacity(.05)),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.sell_outlined,
                                                size: 18.sp,
                                              ),
                                              SizedBox(
                                                height: 10.sp,
                                              ),
                                              Text(
                                                "Seller",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  letterSpacing: 0.14,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Coming soon")));
                                          // controller.selectedObject.addAll({"type": "transport"});
                                          // box.write(Constants.USERTYPE, 3);
                                        },
                                        child: Container(
                                          height: 32.sp,
                                          width: 32.sp,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15.sp),
                                              border: Border.all(color: controller.selectedObject['type'] == "transport" ? Constants.primaryButtonColor : Colors.transparent),
                                              color: controller.selectedObject['type'] == "transport"
                                                  ? Constants.primaryButtonColor.withOpacity(.05)
                                                  : Constants.secondaryButtonColor.withOpacity(.05)),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.fire_truck_outlined,
                                                size: 18.sp,
                                              ),
                                              SizedBox(
                                                height: 10.sp,
                                              ),
                                              Text(
                                                "Transport",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  letterSpacing: 0.14,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0.sp, horizontal: 20.sp),
                          child: InkWell(
                            onTap: () {
                              if (signupControl.emailController.text.isNotEmpty) {
                                EasyLoading.show(
                                    indicator: const CircularProgressIndicator(
                                  color: Colors.orange,
                                ));
                                signupControl.signIn().then((value) {
                                  EasyLoading.dismiss();
                                  var json = jsonDecode(value.responseBody!);
                                  if (value.serverStatusCode == 200) {
                                    signupControl.verificationToken = json['data'];

                                    /// VALIDATE TOKEN STORED.
                                    Constants.showSnackBar(json['message'].toString().replaceAll('  ', ' '));
                                    Get.to(const VerificationPage());
                                  } else if (value.serverStatusCode == 400) {
                                    Constants.showSnackBar(json['message'].toString());
                                  }
                                });
                              } else {
                                Constants.showSnackBar('Please fill email/mobile number');
                              }
                              // });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.sp),
                              child: Container(
                                color: Constants.primaryButtonColor,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 15.sp),
                                  child: Center(
                                    child: Text(
                                      'SIGN IN',
                                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(const SignUpFormView());
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4.0.sp),
                                  child: Text(
                                    'Signup',
                                    style: TextStyle(color: Constants.primaryButtonColor, fontSize: 14.sp),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0.sp, horizontal: 20.sp),
                          child: Text(
                            "By continuing you agree to terms & condition and privacy policy.",
                            style: TextStyle(fontSize: 14.sp),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
