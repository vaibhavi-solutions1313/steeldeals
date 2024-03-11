import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/constants.dart';
import 'package:services_provider_application/views/login_signup_selector_view.dart';
import 'package:services_provider_application/views/onboard/onboarding_two.dart';

class OnBoardingOne extends StatelessWidget {
  const OnBoardingOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Image.asset("assets/buyer/images/logo.png",width: 65.sp,),
                Text(
                  'Certified Products',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF213C63),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  'Provides Quality and Reliable Products',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff474B47),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 40.sp,
                ),
                Image.asset('assets/buyer/images/on_board_1.png'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(const LoginSignupSelectorView());
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          color: Constants.primaryButtonColor, fontSize: 16.sp),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          color: Constants.primaryButtonColor,
                          borderRadius: BorderRadius.circular(2)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2)),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.to(const OnboardingTwo(),transition: Transition.rightToLeft);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      'Next',
                      style: TextStyle(
                          color: Constants.primaryButtonColor, fontSize: 16.sp),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
