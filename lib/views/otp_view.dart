import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/constants.dart';
import 'package:services_provider_application/main.dart';
import 'package:services_provider_application/views/buyer/views/home_with_nav_view.dart';
import 'package:services_provider_application/views/seller/views/home_view/home_view.dart';
import 'package:services_provider_application/views/signup_form_view.dart';
import '../helpers/helper.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    signupControl.resendOtpInSeconds();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF1FAFF),
            Color(0xFFFFF7EE),
          ],
        )),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text(
                          'Please Verify',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 21.sp, color: Color(0xFF213C63)),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                    //   child: SizedBox(
                    //       height:
                    //           Constants.returnScreenSize(context).height * .3,
                    //       child: SvgPicture.asset('assets/verify.svg')),
                    // ),
                    // const Text(
                    //   "Verification",
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 30,
                    //     letterSpacing: 0.30,
                    //   ),
                    // ),
                    // const SizedBox(height: 19),
                    Text(
                      "Enter OTP received in ${signupControl.emailController.text}",
                      style: TextStyle(
                        color: Color(0xff939393),
                        fontSize: 14.sp,
                        letterSpacing: 0.28,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.sp),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    activeColor: Constants.primaryButtonColor.withOpacity(.1),
                    inactiveColor: Constants.primaryButtonColor.withOpacity(.1),
                    inactiveFillColor: Constants.primaryButtonColor.withOpacity(.1),
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5.sp),
                    fieldHeight: 30.sp,
                    fieldWidth: 25.sp,
                    selectedColor: Constants.primaryButtonColor,
                    selectedFillColor: Constants.primaryButtonColor.withOpacity(.2),
                    activeFillColor: Constants.primaryButtonColor,
                  ),
                  animationDuration: const Duration(milliseconds: 300),

                  cursorColor: Constants.primaryButtonColor,
                  // controller: controller.otpController.value,
                  onCompleted: (v) {
                    signupControl.otpEntered = v;
                    print("Completed");
                  },
                  onChanged: (value) {
                    // controller.otpValueChanged(value);
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Obx(() => signupControl.totalSeconds.value != 0
                    ? Text(
                        "Resend in ${signupControl.totalSeconds.value}s",
                        style: TextStyle(
                          color: Color(0xff939393),
                          fontSize: 14.sp,
                          letterSpacing: 0.28,
                        ),
                      )
                    : TextButton(
                        onPressed: () => signupControl.resetTimerSeconds(),
                        child: Text(
                          'Resend',
                          style: TextStyle(fontSize: 16.sp),
                        ))),
              ),
              SizedBox(
                height: 25.sp,
              ),
              InkWell(
                onTap: () async {
                  if (signupControl.otpEntered!.length == 6) {
                    Helper.logoLoader();
                    try {
                      await signupControl.validateOtp().then((value) async {
                        if(value.serverStatusCode == 200) {
                          var jsonData = jsonDecode(value.responseBody!);
                          box.write(Constants.USERDATA, jsonData['data']);
                          customerProfileControl.getProfileInfoFromLocal(); // BUYER GET USER INFO FROM LOCAL
                          Helper.dismissLoader();

                          void dialogBox() {
                            Get.defaultDialog(
                                barrierDismissible: false,
                                title: '',
                                content: Column(
                                  children: [
                                    Image.asset(
                                      "assets/buyer/images/logo.png",
                                      width: 65.sp,
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 2.0.sp),
                                      child: Text("Welcome to Steel Deals", style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.bold, color: Color(0xFF213C63)),
                                        textAlign: TextAlign.center,),
                                    ),
                                    Text(
                                      "We provide an entire range of steel products so that you can find what you're looking for all in one place.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    IconButton(
                                        style: IconButton.styleFrom(
                                          backgroundColor: Color(0xFFF5951D),
                                        ),
                                        onPressed: () {
                                          if (box.read(Constants.USERTYPE) == 1) {
                                            Get.offAll(const HomeViewNav());
                                          } else if (box.read(Constants.USERTYPE) == 2) {
                                            Get.offAll(const SellerHomeView());
                                          }
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward,
                                          size: 18.sp,
                                        ))
                                  ],
                                ));
                          }

                          void executeRest() async {
                            try {
                              var json = jsonDecode(value.responseBody!);
                              print(json);
                              if (value.serverStatusCode == 200) {
                                myConstants.bearerToken = jsonData['data']['token'];
                                box.write(Constants.BEARERTOKEN, jsonData['data']['token']);
                                context.loaderOverlay.show();

                                // BUYER LOAD DATA
                                if (box.read(Constants.USERTYPE) == 1) {
                                  await splashControl.loadBuyerData().whenComplete(() {
                                    context.loaderOverlay.hide();
                                    dialogBox();
                                  }).onError((error, stackTrace) {
                                    context.loaderOverlay.hide();
                                  });
                                }

                                // SELLER LOAD DATA
                                if (box.read(Constants.USERTYPE) == 2) {
                                  await splashControl.loadSellerData().whenComplete(() {
                                    context.loaderOverlay.hide();
                                    dialogBox();
                                  }).onError((error, stackTrace) {
                                    context.loaderOverlay.hide();
                                  });
                                }
                              } else {
                                Constants.showSnackBar(json['message'].toString());
                              }
                            } catch (e) {
                              Constants.showSnackBar("Something went wrong! try again.");
                              // TODO
                            }
                          }

                          executeRest();

                          /// ROLE WISE LOGIN CONDITION COMMENTED OUT BELOW
                          // if (box.read(Constants.USERTYPE) == 1) {
                          //   if (jsonData['data']['role'] != 4) {
                          //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You are not registered as buyer")));
                          //     Future.delayed(const Duration(milliseconds: 1000), () {
                          //       box.erase();
                          //       Get.offAll(SplashView());
                          //     });
                          //   } else {
                          //     executeRest();
                          //   }
                          // }

                          // if (box.read(Constants.USERTYPE) == 2) {
                          //   if (jsonData['data']['role'] != 3) {
                          //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You are not registered as seller.")));
                          //     Future.delayed(const Duration(milliseconds: 1000), () {
                          //       box.erase();
                          //       Get.offAll(SplashView());
                          //     });
                          //   } else {
                          //     executeRest();
                          //   }
                          // }
                        } else {
                          Helper.dismissLoader();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Incorrect OTP")));
                        }
                      });
                    } catch (e) {
                      Helper.dismissLoader();
                      // TODO
                      Constants.showSnackBar("Something went wrong! try again.");
                    }
                  } else {
                    Constants.showSnackBar('Please fill all 6 digits.');
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 28.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Constants.primaryButtonColor,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
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
