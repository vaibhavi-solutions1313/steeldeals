import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SimpleAppBar extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SimpleAppBar(this.title, {Key? key, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.2,
      toolbarHeight: 30.sp,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(fontSize: 16.sp, color: Color(0xFF213C63), fontWeight: FontWeight.w700),
          ),
          if (subtitle != null)
            Padding(
              padding: EdgeInsets.only(top: 3.sp),
              child: Text(
                subtitle!,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16.sp,fontWeight: FontWeight.w600,
                  letterSpacing: 0.36,
                ),
              ),
            ),
        ],
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded,color: Colors.orangeAccent,size: 18.sp,),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}
