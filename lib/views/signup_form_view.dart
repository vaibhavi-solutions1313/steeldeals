import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/views/login_view.dart';
import 'package:services_provider_application/views/sign_up_documents_form_view.dart';
import 'package:services_provider_application/widgets/TextFieldView.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';
import '../constants.dart';
import '../controllers/sign_up_document_controller.dart';

final signupControl = Get.put(AuthSignupController());

class SignUpFormView extends StatefulWidget {
  const SignUpFormView({Key? key}) : super(key: key);

  @override
  State<SignUpFormView> createState() => _SignUpFormViewState();
}

class _SignUpFormViewState extends State<SignUpFormView> {
  @override
  void initState() {
    signupControl.fullNameController.clear();
    signupControl.emailController.clear();
    signupControl.mobileNumberController.clear();
    signupControl.addressController.clear();
    signupControl.cityController.clear();
    signupControl.countryController.clear();
    signupControl.stateController.clear();
    signupControl.pinCodeController.clear();
    signupControl.panCardController.clear();
    signupControl.gstNumberController.clear();
    signupControl.cinController.clear();
    signupControl.aadharNumberController.clear();
    signupControl.iecController.clear();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          child: Column(
            children: [
              SimpleAppBar("CREATE ACCOUNT"),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  children: [
                    Form(
                      key: signupControl.signupForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              'Full Name',
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                          TextFieldView('', 'Full Name', false, textEditingController: signupControl.fullNameController),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              'Email Address',
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                          TextFieldView('', 'Email Address', false, textEditingController: signupControl.emailController),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              'Phone No',
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                          TextFieldView('', 'Phone no.', false, textEditingController: signupControl.mobileNumberController, inputType: TextInputType.number),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 5.0),
                          //   child: Text(
                          //     'Address',
                          //     style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          // TextFieldView('', 'Address', false, textEditingController: signupControl.addressController),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 5.0),
                          //   child: Text(
                          //     'City',
                          //     style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          // TextFieldView('', 'City', false, textEditingController: signupControl.cityController),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 5.0),
                          //   child: Text(
                          //     'State',
                          //     style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          // TextFieldView(
                          //   '',
                          //   'State',
                          //   false,
                          //   textEditingController: signupControl.stateController,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 5.0),
                          //   child: Text(
                          //     'Country',
                          //     style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          // TextFieldView(
                          //   '',
                          //   'Country',
                          //   false,
                          //   textEditingController: signupControl.countryController,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 5.0),
                          //   child: Text(
                          //     'Pin code',
                          //     style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          // TextFieldView('', 'Pincode', false, textEditingController: signupControl.pinCodeController, inputType: TextInputType.number),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 5.0),
                          //   child: Text(
                          //     'Pan card no.',
                          //     style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          // TextFieldView('', 'Pan card', false, textEditingController: signupControl.panCardController),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 5.0),
                          //   child: Text(
                          //     'GST No.',
                          //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          // TextFieldView('', 'Gst no.', false, textEditingController: signupControl.gstNumberController),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 5.0),
                          //   child: Text(
                          //     'CIN No. (optional)',
                          //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          // TextFieldView('', 'CIN No.', false, textEditingController: signupControl.cinController, needValidate: false),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 5.0),
                          //   child: Text(
                          //     'Aadhaar Card No.',
                          //     style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          // TextFieldView('', 'Aadhaar Card', false, textEditingController: signupControl.aadharNumberController, inputType: TextInputType.number),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 5.0),
                          //   child: Text(
                          //     'IEC Number (optional)',
                          //     style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          // TextFieldView('', 'Iec Number', false, needValidate: false, textEditingController: signupControl.iecController),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 35.0, horizontal: 30),
                            child: Row(children: [
                              Expanded(
                                  child: Divider(
                                thickness: 2,
                                color: Constants.primaryButtonColor,
                                height: 1,
                              )),
                              SizedBox(
                                width: 15.sp,
                              ),
                              const Expanded(
                                  child: Divider(
                                thickness: 2,
                                height: 1,
                              )),
                            ]),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0.sp),
                            child: InkWell(
                              onTap: () {
                                if (signupControl.signupForm.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  Get.to(const SignUpDocuments(), transition: Transition.rightToLeft);
                                }
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: Constants.primaryButtonColor,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 15.sp),
                                    child: Center(
                                      child: Text(
                                        'NEXT',
                                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => const LoginView());
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0.sp),
                                    child: Text(
                                      'Log in',
                                      style: TextStyle(color: Constants.primaryButtonColor, fontSize: 16.sp),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // const Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 18.0),
                          //   child: Text(
                          //     "By continuing you agree to terms & condition and privacy policy.",
                          //     style: TextStyle(fontSize: 15),
                          //     textAlign: TextAlign.center,
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
