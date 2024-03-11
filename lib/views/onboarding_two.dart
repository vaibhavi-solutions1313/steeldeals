import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/constants.dart';
import 'package:services_provider_application/views/onboarding_three.dart';

import 'login_signup_selector_view.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({Key? key}) : super(key: key);

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
          children: [
            const SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/buyer/images/logo.png",width: 200,),
                Text(
                  'Hassle Free Delivery',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF213C63),
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    'Delivering a certified products at your doorstep without fail.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff474B47),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.asset('assets/buyer/images/on_board_2.png')),
            const SizedBox(),
            SizedBox(
              height: 50,
              child: Row(
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
                            color: Constants.primaryButtonColor, fontSize: 14),
                      ),
                    ),
                  ),
                  Row(
                    children: [
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
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const OnBoardingThree(),transition: Transition.rightToLeft);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Text(
                        'Next',
                        style: TextStyle(
                            color: Constants.primaryButtonColor, fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
