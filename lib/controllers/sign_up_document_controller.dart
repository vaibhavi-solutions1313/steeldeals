import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/helpers/network_helper.dart' as NN;
import '../apis/signup_api.dart';

class AuthSignupController extends GetxController {
  var switchValue = false.obs;
  var selectedIndex = 0.obs;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController panCardController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController aadharNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController iecController = TextEditingController();
  String? aadharImgPath, cinImgPath, panImgPath, gstImgPath, iecImgPath;
  String? userType = '';
  String? verificationToken = '';
  String? otpEntered = '';
  var totalSeconds = 60.obs;
  Timer? secondsTimer;
  final signupForm = GlobalKey<FormState>();


  Future<File> selectDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    } else {
      return File("");
      // User canceled the picker
    }
  }

  void onSwitchChanged(bool value) {
    switchValue.value = value;
  }

  onCategoryPressed(int index) {
    selectedIndex.value = index;
    if (selectedIndex.value == 0) {
      userType = "buyer";
    } else if (selectedIndex.value == 1) {
      userType = "seller";
    } else if (selectedIndex.value == 2) {
      userType = "transport";
    }
  }

  Future<NN.Response> signUp() async {
    return await AuthApi().signUp(
        fullNameController.text,
        emailController.text,
        mobileNumberController.text,
        addressController.text,
        cityController.text,
        stateController.text,
        countryController.text,
        pinCodeController.text,
        panCardController.text,
        gstNumberController.text,
        userType!,
        cinController.text,
        aadharNumberController.text,
        iecController.text,
        aadharImgPath ?? "",
        panImgPath ?? "",
        cinImgPath ?? "",
        gstImgPath ?? "",
        iecImgPath ?? "");
  }

  Future<NN.Response> signIn() async {
    return await AuthApi().signIn(emailController.text);
  }

  Future<NN.Response> validateOtp() async {
    return await AuthApi().validateOtp(verificationToken!,otpEntered!);
  }

  void resendOtpInSeconds() {
    const oneSec = Duration(seconds:1);
    secondsTimer = Timer.periodic(oneSec, (Timer t) {
      if(totalSeconds!=0) {
        totalSeconds.value = totalSeconds.value - 1;
      } else {
        secondsTimer!.cancel();
      }
    });
  }

  void resetTimerSeconds() {
    totalSeconds.value = 60;
  }
}
