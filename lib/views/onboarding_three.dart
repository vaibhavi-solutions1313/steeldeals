import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/constants.dart';

import 'login_signup_selector_view.dart';

class OnBoardingThree extends StatelessWidget {
  const OnBoardingThree({Key? key}) : super(key: key);

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
                const Text(
                  'Verified Suppliers',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF213C63),
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    'We be bridges the gap between the online and offline wold through buyers',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:Color(0xff474B47),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.asset('assets/buyer/images/pn_board_3.png')),
            const SizedBox(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  Get.to(const LoginSignupSelectorView());
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Constants.primaryButtonColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                    child: Text('Get Started',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
