import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/views/signup_form_view.dart';

import '../constants.dart';
import 'login_view.dart';

class LoginSignupSelectorView extends StatefulWidget {
  const LoginSignupSelectorView({Key? key}) : super(key: key);

  @override
  State<LoginSignupSelectorView> createState() => _LoginSignupSelectorViewState();
}

class _LoginSignupSelectorViewState extends State<LoginSignupSelectorView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        // height: Constants.returnScreenSize(context).height,
        // decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: [
        //         Color(0xFFF1FAFF),
        //         Color(0xFFFFF7EE),
        //       ],
        //     )
        // ),
        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 25.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/app_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      'Welcome to Steel Deals',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 24.sp,
                        color: Color(0xFF213C63),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                //   child: Row(
                //     children: const [
                //       Expanded(
                //         child: Text(
                //           "Continue by creating a new account or login to existing one..",
                //           style: TextStyle(
                //               fontWeight: FontWeight.w400,
                //               fontSize: 14,
                //               color: Colors.black38),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.sp),
                    child: InkWell(
                      onTap: () {
                        Get.to(const SignUpFormView());
                      },
                      child: Container(
                        color: Constants.primaryButtonColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 15.sp),
                          child: Center(
                            child: Text(
                              'CREATE ACCOUNT',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: InkWell(
                    onTap: () {
                      Get.to(const LoginView());
                    },
                    child: Container(
                      decoration: BoxDecoration(color: Constants.secondaryButtonColor, borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xFFF5951D))),
                      padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 15.sp),
                      child: Center(
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(
                            color: Color(0xFFF5951D),
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
