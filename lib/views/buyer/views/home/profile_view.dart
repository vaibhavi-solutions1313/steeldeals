import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/constants.dart';
import 'package:services_provider_application/views/buyer/views/bank_detail_view.dart';
import 'package:services_provider_application/views/splash_view.dart';
import 'package:services_provider_application/views/buyer/views/privacy_policy_and_terms_conditons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../main.dart';
import '../../../../modules/account_information/account_info_form_view.dart';
import '../../../chat_views/chat_list_view.dart';
import '../../controllers/home_view_controller.dart';
import '../addresses/address_list_view.dart';
import '../customer_bargain_list.dart';
import '../metal_weight_calculator.dart';
import '../post_enquiry_view.dart';
import '../order_history_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
        )),
        child: ListView(
          padding: EdgeInsets.only(left: 18.sp, right: 18.sp, bottom: 45.sp),
          children: [
            // SafeArea(
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(vertical: 8.0.sp),
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           'Options',
            //           style: TextStyle(
            //             fontSize: 21.sp,
            //             fontWeight: FontWeight.w700,
            //             color: Color(0xFF213C63),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0.sp, top: 18.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SizedBox(
                        width: Get.width / 6,
                        height: Get.width / 6,
                        child: Obx(() => customerProfileControl.currentProfilePic.isNotEmpty
                            ? Image.network(
                                customerProfileControl.currentProfilePic.value,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset("assets/no_avatar.jpg");
                                },
                              )
                            : Image.asset("assets/no_avatar.jpg")),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0.sp, vertical: 18.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                box.read(Constants.USERDATA)['name'] ?? "",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                  color: Colors.black87.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                box.read(Constants.USERDATA)['email'],
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.2,
                                  color: Colors.black87.withOpacity(0.7),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.8,
              color: Colors.grey.shade300,
            ),
            ListTile(
              onTap: () {
                customerHomeControl.selectedTab.value = 0;
                customerHomeControl.pageController.jumpToPage(0);
              },
              leading: Icon(
                Icons.home,
                color: Constants.primaryButtonColor,
                size: 18.sp,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Color(0xFF213C63), fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
            ),
            Divider(
              thickness: 0.8,
              color: Colors.grey.shade300,
            ),
            // ListTile(
            //   onTap: () {},
            //   leading: Icon(
            //     Icons.wallet,
            //     color: Constants.primaryButtonColor,
            //   ),
            //   title: const Text('My Wallet'),
            // ),
            // ListTile(
            //   onTap: () {
            //     Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: BalancePaymentView()));
            //     // Get.to(const AccountInfoView());
            //   },
            //   leading: Icon(
            //     Icons.account_box,
            //     color: Constants.primaryButtonColor,
            //   ),
            //   title: const Text('Balance Payments'),
            // ),
            // ListTile(
            //   onTap: () {},
            //   leading: Icon(
            //     Icons.payment,
            //     color: Constants.primaryButtonColor,
            //   ),
            //   title: const Text("Payment"),
            // ),
            ListTile(
              onTap: () {
                Get.to(AccountInfoView(), transition: Transition.rightToLeft)?.then((value) {
                  setState(() {});
                });
                // Get.to(const AccountInfoView());
              },
              leading: Icon(
                Icons.account_box,
                color: Constants.primaryButtonColor,
                size: 18.sp,
              ),
              title: Text(
                'Account Details',
                style: TextStyle(color: Color(0xFF213C63), fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
            ),
            Divider(
              thickness: 0.8,
              color: Colors.grey.shade300,
            ),
            ListTile(
              onTap: () async {
                context.loaderOverlay.show();
                try {
                  await customerHistoryControl.getOrdersList().then((value) async {
                    context.loaderOverlay.hide();
                    if (customerHistoryControl.orderSortedList.isNotEmpty) {
                      Get.to(OrderHistory(), transition: Transition.rightToLeft);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Orders Found!")));
                    }
                  });
                } catch (e) {
                  context.loaderOverlay.hide();
                  // TODO
                }
                // Get.to(const OrderHistory());
              },
              leading: Icon(
                Icons.list_alt,
                color: Constants.primaryButtonColor,
                size: 18.sp,
              ),
              title: Text(
                "My Orders",
                style: TextStyle(color: Color(0xFF213C63), fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
            ),
            Divider(
              thickness: 0.8,
              color: Colors.grey.shade300,
            ),
            ListTile(
              onTap: () async {
                Get.to(BargainListView(), transition: Transition.rightToLeft);
              },
              leading: Icon(
                Icons.balance_rounded,
                color: Constants.primaryButtonColor,
                size: 18.sp,
              ),
              title: Text(
                "Bargain Requests",
                style: TextStyle(color: Color(0xFF213C63), fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
            ),
            Divider(
              thickness: 0.8,
              color: Colors.grey.shade300,
            ),
            ListTile(
              onTap: () {
                Get.to(const BankDetailView(), transition: Transition.rightToLeft);
              },
              leading: Icon(
                Icons.account_balance,
                color: Constants.primaryButtonColor,
                size: 18.sp,
              ),
              title: Text(
                'Bank Details',
                style: TextStyle(color: Color(0xFF213C63), fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
            ),
            Divider(
              thickness: 0.8,
              color: Colors.grey.shade300,
            ),
            ListTile(
              onTap: () {
                Get.to(AddressListView(), transition: Transition.cupertino);
              },
              leading: Icon(
                Icons.add_home,
                color: Constants.primaryButtonColor,
                size: 18.sp,
              ),
              title: Text(
                "Addresses",
                style: TextStyle(color: Color(0xFF213C63), fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
            ),
            Divider(
              thickness: 0.8,
              color: Colors.grey.shade300,
            ),
            ListTile(
              onTap: () {
                Get.to(ChatListView(), transition: Transition.rightToLeft);
              },
              leading: Icon(
                Icons.chat_rounded,
                color: Constants.primaryButtonColor,
                size: 18.sp,
              ),
              title: Text(
                "Chat with Sellers",
                style: TextStyle(color: Color(0xFF213C63), fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
            ),
            Divider(
              thickness: 0.8,
              color: Colors.grey.shade300,
            ),
            ListTile(
              onTap: () {
                Get.to(MetalWeightCalculator(), transition: Transition.rightToLeft);
                // Get.to(const AccountInfoView());
              },
              leading: Icon(
                Icons.calculate,
                color: Constants.primaryButtonColor,
                size: 18.sp,
              ),
              title: Text(
                'Metal Weight Calculator',
                style: TextStyle(color: Color(0xFF213C63), fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
            ),
            Divider(
              thickness: 0.8,
              color: Colors.grey.shade300,
            ),
            ListTile(
              onTap: () {
                // Get.back();
                Get.to(const PostEnquiryView(), transition: Transition.rightToLeft);
              },
              leading: Icon(
                Icons.question_mark,
                color: Constants.primaryButtonColor,
                size: 18.sp,
              ),
              title: Text(
                "Post Enquiry",
                style: TextStyle(color: Color(0xFF213C63), fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
            ),
            Divider(
              thickness: 0.8,
              color: Colors.grey.shade300,
            ),
            ListTile(
              onTap: () {
                customerProfileControl.rateThisApp(context);
              },
              leading: Icon(
                Icons.star,
                color: Constants.primaryButtonColor,
                size: 18.sp,
              ),
              title: Text(
                "Rate this App",
                style: TextStyle(color: Color(0xFF213C63), fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
            ),
            Divider(
              thickness: 0.8,
              color: Colors.grey.shade300,
            ),
            ListTile(
              onTap: () {
                Get.defaultDialog(
                    title: "Contact Us",
                    titleStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.75)),
                    content: Text(
                      "How would you like to contact us?",
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.75)),
                    ),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(backgroundColor: Colors.orangeAccent),
                        onPressed: () async {
                          Get.back();
                          String email = Uri.encodeComponent("${splashControl.appInfo['email']}");
                          String subject = Uri.encodeComponent("Support");
                          String body = Uri.encodeComponent("Hi!");
                          print(subject); //output: Hello%20Flutter
                          Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
                          if (await launchUrl(mail)) {
                            //email app opened
                          } else {
                            //email app is not opened
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something wrong with your default mail app.")));
                          }
                        },
                        child: Text(
                          "EMAIL",
                          style: TextStyle(color: Colors.white70, fontSize: 16.sp),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(backgroundColor: Colors.orangeAccent),
                        onPressed: () async {
                          Get.back();
                          if (splashControl.appInfo['phone'] != null) {
                            bool? res = await FlutterPhoneDirectCaller.callNumber(splashControl.appInfo['phone'].toString());
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something wrong with the dialer or permission.")));
                          }
                        },
                        child: Text(
                          "CALL",
                          style: TextStyle(color: Colors.white70, fontSize: 16.sp),
                        ),
                      ),
                    ]);
              },
              leading: Icon(
                Icons.contacts,
                color: Constants.primaryButtonColor,
                size: 18.sp,
              ),
              title: Text(
                "Contact Us",
                style: TextStyle(color: Color(0xFF213C63), fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
            ),
            Divider(
              thickness: 0.8,
              color: Colors.grey.shade300,
            ),
            ListTile(
              onTap: () {
                Get.to(PrivacyPolicyAndTermsCondition(title: "Privacy Policy", body: splashControl.appInfo['privacy_policy']), transition: Transition.cupertino);
              },
              leading: Icon(
                Icons.privacy_tip,
                color: Constants.primaryButtonColor,
                size: 18.sp,
              ),
              title: Text(
                "Privacy & Policy",
                style: TextStyle(color: Color(0xFF213C63), fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
            ),
            Divider(thickness: 0.8, color: Colors.grey.shade300),
            ListTile(
              onTap: () {
                // Get.back();
                Get.to(PrivacyPolicyAndTermsCondition(title: "Terms & Conditions", body: splashControl.appInfo['terms_and_conditions']), transition: Transition.cupertino);
              },
              leading: Icon(
                Icons.rule,
                color: Constants.primaryButtonColor,
                size: 18.sp,
              ),
              title: Text(
                "Terms & Conditions",
                style: TextStyle(color: Color(0xFF213C63), fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
            ),
            Divider(
              thickness: 0.8,
              color: Colors.grey.shade300,
            ),
            ListTile(
              onTap: () {
                box.erase();
                customerHomeControl = HomeViewController();
                Get.offAll(SplashView());
              },
              leading: Icon(
                Icons.logout,
                color: Colors.red,
                size: 18.sp,
              ),
              title: Text(
                "Log Out",
                style: TextStyle(color: Color(0xFF213C63), fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
