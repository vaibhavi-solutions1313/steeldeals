import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:services_provider_application/modules/account_information/account_info_form_view.dart';
import 'package:services_provider_application/views/buyer/views/privacy_policy_and_terms_conditons.dart';
import 'package:services_provider_application/views/rate_us_view.dart';
import 'package:services_provider_application/views/terms_condition_view.dart';
import '../constants.dart';
import '../main.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
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
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                  Text(
                    'Setting',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ]),
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
                  Get.to(() => const AccountInfoView());
                },
                leading: Icon(
                  Icons.person_outline,
                  color: Constants.primaryButtonColor,
                ),
                title: const Text("Update profile"),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: PrivacyPolicyAndTermsCondition(
                            title: "Privacy Policy",
                            body: splashControl.appInfo['privacy_policy'],
                          )));
                  // Get.to(const PrivacyPolicyView());
                },
                leading: Icon(
                  Icons.privacy_tip_outlined,
                  color: Constants.primaryButtonColor,
                ),
                title: const Text("Privacy Policy"),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const TermsAndCondition(),
                    ),
                  );
                  // Get.to(const TermsAndCondition());
                },
                leading: Icon(
                  Icons.rule_sharp,
                  color: Constants.primaryButtonColor,
                ),
                title: const Text("Terms & Conditions"),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const RateUsView(),
                    ),
                  );
                  // Get.to(const RateUsView());
                },
                leading: Icon(
                  Icons.rate_review,
                  color: Constants.primaryButtonColor,
                ),
                title: const Text('Rate our app'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.logout,
                  color: Constants.primaryButtonColor,
                ),
                title: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
