import 'package:flutter/material.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
           const SimpleAppBar('Terms & conditions'),
              Text(
                """It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).""",
                style: TextStyle(
                    fontSize: 16,
                    height: 2.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.6),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
