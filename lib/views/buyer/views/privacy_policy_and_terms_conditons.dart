import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';

class PrivacyPolicyAndTermsCondition extends StatefulWidget {
  final String title;
  final String body;
  const PrivacyPolicyAndTermsCondition({Key? key, required this.title, required this.body}) : super(key: key);

  @override
  State<PrivacyPolicyAndTermsCondition> createState() => _PrivacyPolicyAndTermsConditionState();
}

class _PrivacyPolicyAndTermsConditionState extends State<PrivacyPolicyAndTermsCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SimpleAppBar(
            widget.title,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 18.sp),
              child: Text(
                """${widget.body}""",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.6)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
