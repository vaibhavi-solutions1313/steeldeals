import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/views/seller/views/gen_widgets/cus_textfield.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';
import '../../constants.dart';
import '../../main.dart';

class AccountInfoView extends StatefulWidget {
  const AccountInfoView({Key? key}) : super(key: key);

  @override
  State<AccountInfoView> createState() => _AccountInfoViewState();
}

class _AccountInfoViewState extends State<AccountInfoView> {
  @override
  void initState() {
    customerProfileControl.nameControl.text = box.read(Constants.USERDATA)['name'];
    customerProfileControl.tempPic.value = File("");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0.5,
      //   leading: IconButton(
      //     onPressed: () {
      //       Get.back();
      //     },
      //     icon: Icon(
      //       Icons.arrow_back_rounded,
      //       color: Colors.orangeAccent,
      //     ),
      //   ),
      //   title: Text(
      //     'Account Details',
      //     style: TextStyle(color: Colors.black.withOpacity(0.85)),
      //   ),
      // ),
      body: Column(
        children: [
          SimpleAppBar("Account details"),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(18.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.sp),
                          child: SizedBox(
                            width: Get.width / 4,
                            height: Get.width / 4,
                            child: Obx(
                              () => ClipRRect(
                                borderRadius: BorderRadius.circular(100.sp),
                                child: Container(
                                  width: Get.width / 4,
                                  height: Get.width / 4,
                                  child: customerProfileControl.tempPic.value.path.isNotEmpty
                                      ? Image.file(customerProfileControl.tempPic.value)
                                      : customerProfileControl.currentProfilePic.isNotEmpty
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(100.sp),
                                              child:
                                                  Image.network(customerProfileControl.currentProfilePic.value, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
                                                return Image.asset(
                                                  "assets/no_avatar.jpg",
                                                  fit: BoxFit.cover,
                                                );
                                              }),
                                            )
                                          : Image.asset(
                                              "assets/no_avatar.jpg",
                                              fit: BoxFit.cover,
                                            ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              customerProfileControl.selectProfilePic();
                            },
                            child: Container(
                              padding: EdgeInsets.all(4.sp),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.sp),
                                color: Colors.orangeAccent,
                                border: Border.all(color: Colors.white),
                              ),
                              child: Icon(Icons.edit, color: Colors.white, size: 20.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0.sp),
                      child: Text(
                        'Full Name',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    CustomTextField(
                      hintText: 'User name',
                      controller: customerProfileControl.nameControl,
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0.sp),
                      child: Text(
                        'Email Address',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    CustomTextField(hintText: 'Email address', controller: customerProfileControl.emailControl),

                    // const Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 15.0),
                    //   child: Text(
                    //     'Password',
                    //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    //   ),
                    // ),
                    // TextFieldView(
                    //   '', 'Password', textEditingController: controller.usernameController.value, false,suffixIcon: 'assets/eye_close.svg',),

                    // const Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 15.0),
                    //   child: Text(
                    //     'Mobile Number',
                    //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    //   ),
                    // ),
                    // TextFieldView(
                    //   '', 'Phone number',textEditingController:  controller.usernameController.value, false,suffixIcon: 'assets/phone_outline.svg',),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0.sp),
                      child: Text(
                        'Aadhaar Number',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    CustomTextField(
                      hintText: 'Aadhaar number',
                      controller: customerProfileControl.aadharControl,
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0.sp),
                      child: Text(
                        'Gst Number',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    CustomTextField(
                      hintText: 'GST number',
                      controller: customerProfileControl.gstControl,
                    ),

                    SizedBox(
                      height: 10.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0.sp),
                      child: Text(
                        'Cin Number',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    CustomTextField(
                      hintText: 'CIN number',
                      controller: customerProfileControl.cinControl,
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 15.0),
                    //   child: Text(
                    //     'Address',
                    //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    //   ),
                    // ),
                    // TextFieldView(
                    //   '', 'Address',textEditingController:  controller.usernameController.value, false,suffixIcon: 'assets/address.svg',),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0.sp),
                      child: Text(
                        'Country',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    CustomTextField(
                      hintText: "Country",
                      controller: customerProfileControl.countryControl,
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0.sp),
                      child: Text(
                        'State',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    CustomTextField(
                      hintText: 'State',
                      controller: customerProfileControl.stateControl,
                    ),
                    SizedBox(
                      height: 16.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0.sp),
                      child: Text(
                        'Pincode',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    CustomTextField(
                      hintText: 'Pincode',
                      controller: customerProfileControl.pinCodeControl,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0.sp),
                      child: InkWell(
                        onTap: () async {
                          // Get.to(const SignupDocuments());
                          await customerProfileControl.updateProfile(context);
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
