import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/views/seller/views/gen_widgets/cus_textfield.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';
import '../../../constants.dart';
import '../../../apis/buyer/general_apis.dart';

class PostEnquiryView extends StatefulWidget {
  const PostEnquiryView({Key? key}) : super(key: key);

  @override
  State<PostEnquiryView> createState() => _PostEnquiryViewState();
}

class _PostEnquiryViewState extends State<PostEnquiryView> {
  TextEditingController name = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController length = TextEditingController();
  TextEditingController width = TextEditingController();
  TextEditingController thickness = TextEditingController();
  TextEditingController specification = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
            ),
          ),
          child: Column(
            children: [
              SimpleAppBar("Post Enquiry"),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 18.sp),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                        child: Text(
                          'Product Name',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      CustomTextField(hintText: 'Product Name', controller: name),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                        child: Text(
                          'Quantity',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      CustomTextField(hintText: 'Product Quantity', controller: quantity),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                        child: Text(
                          'Length',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      CustomTextField(hintText: 'Product Length', controller: length),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                        child: Text(
                          'Width',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      CustomTextField(
                        hintText: 'Product Width',
                        controller: width,
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                        child: Text(
                          'Thickness',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      CustomTextField(
                        hintText: 'Product Thickness',
                        controller: thickness,
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                        child: Text(
                          'Specification',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      CustomTextField(hintText: 'Product Specification', controller: specification),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              try {
                                context.loaderOverlay.show();
                                GeneralApis().postEnquiry(name.text, quantity.text, length.text, width.text, thickness.text, specification.text).then((value) {
                                  context.loaderOverlay.hide();
                                  if (value.serverStatusCode == 200) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Submitted Successfully.\nYou will receive response via email.")));
                                    Get.back();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong, try again.")));
                                  }
                                });
                              } catch (e) {
                                context.loaderOverlay.hide();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong, try again.")));
                              }
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.sp),
                            child: Container(
                              color: Constants.primaryButtonColor,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 15.sp),
                                child: Center(
                                  child: Text(
                                    'SUBMIT',
                                    style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Get.to(() => const LoginView());
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(vertical: 8.0),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         const Text("Already have an account?"),
                      //         Padding(
                      //           padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      //           child: Text(
                      //             'Log in',
                      //             style:
                      //             TextStyle(color: Constants.primaryButtonColor),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
