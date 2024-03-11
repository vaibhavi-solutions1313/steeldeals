import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Helper {
  static logoLoader() {
    EasyLoading.show(
        indicator: Container(
          height: 300,
          decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(90)),
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(200)),
                  child: Image.asset(
                    'assets/buyer/images/logo.png',
                    width: 250,
                  ),
                ),
              ),
              LoadingAnimationWidget.prograssiveDots(
                color: Colors.grey,
                size: 50,
              )
            ],
          ),
        ),
        dismissOnTap: false);
  }

  static dismissLoader() {
    EasyLoading.dismiss();
  }
}
