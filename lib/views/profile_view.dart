import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:services_provider_application/Utils/constants.dart';
import 'package:services_provider_application/modules/Balance_payments/balance_payment_view.dart';
import 'package:services_provider_application/modules/pending_order/pending_order.dart';
import '../modules/account_information/account_info_form_view.dart';
import 'buyer/views/post_enquiry_view.dart';
import 'order_history_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
          child: ListView(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 100, top: 0),
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 15, 20),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ])),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.network('https://picsum.photos/200'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Chukwuebuka',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                  color: Colors.black87.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                'saveek4@gmail.com',
                                style: TextStyle(
                                  fontSize: 14,
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
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.home,
                  color: Constants.primaryButtonColor,
                ),
                title: const Text('Home'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.wallet,
                  color: Constants.primaryButtonColor,
                ),
                title: const Text('My Wallet'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: BalancePaymentView()));
                  // Get.to(const AccountInfoView());
                },
                leading: Icon(
                  Icons.account_box,
                  color: Constants.primaryButtonColor,
                ),
                title: const Text('Balance Payments'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.payment,
                  color: Constants.primaryButtonColor,
                ),
                title: const Text("Payment"),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const OrderHistory()));
                  // Get.to(const OrderHistory());
                },
                leading: Icon(
                  Icons.list_alt,
                  color: Constants.primaryButtonColor,
                ),
                title: const Text("Orders"),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: PendingOrder(),
                    ),
                  );
                  // Get.to(const OrderHistory());
                },
                leading: Icon(
                  Icons.pending,
                  color: Constants.primaryButtonColor,
                ),
                title: const Text("Pending Orders"),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const AccountInfoView(),
                    ),
                  );
                  // Get.to(const AccountInfoView());
                },
                leading: Icon(
                  Icons.account_box,
                  color: Constants.primaryButtonColor,
                ),
                title: const Text('Account Details'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const AccountInfoView()));
                  // Get.to(const AccountInfoView());
                },
                leading: Icon(
                  Icons.calculate,
                  color: Constants.primaryButtonColor,
                ),
                title: const Text('Metal Weight Calculator'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.star_border,
                  color: Constants.primaryButtonColor,
                ),
                title: const Text("Saved Places"),
              ),
              ListTile(
                onTap: () {
                  // Get.back();
                  Get.to(const PostEnquiryView());
                },
                leading: Icon(
                  Icons.question_mark,
                  color: Constants.primaryButtonColor,
                ),
                title: const Text("Post Enquiry"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.contacts,
                  color: Constants.primaryButtonColor,
                ),
                title: const Text("Contact Us"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.privacy_tip,
                  color: Constants.primaryButtonColor,
                ),
                title: const Text("Privacy & Policy"),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: const Text("LogOut"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
