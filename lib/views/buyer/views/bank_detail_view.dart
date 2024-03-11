import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../widgets/simple_app_bar.dart';
import '../../seller/views/gen_widgets/cus_textfield.dart';

class BankDetailView extends StatefulWidget {
  const BankDetailView({super.key});

  @override
  State<BankDetailView> createState() => _BankDetailViewState();
}

class _BankDetailViewState extends State<BankDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SimpleAppBar('Bank Details'),
          Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            children: [
              CustomTextField(hintText: 'Bank Name'),
              SizedBox(
                height: 10.sp,
              ),
              CustomTextField(hintText: 'Account Number'),
              SizedBox(
                height: 10.sp,
              ),
              CustomTextField(hintText: 'IFSC'),
              SizedBox(
                height: 10.sp,
              ),
              CustomTextField(hintText: 'Branch'),
              SizedBox(
                height: 10.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0.sp),
                child: InkWell(
                  onTap: () async {
                    // Get.to(const SignupDocuments());
                    // await customerProfileControl.updateProfile(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.sp),
                    child: Container(
                      color: Colors.orangeAccent,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 15.sp),
                        child: Center(
                          child: Text(
                            'UPDATE',
                            style: TextStyle(color: Colors.white, fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
