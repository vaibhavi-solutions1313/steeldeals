import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FormHeading extends StatelessWidget {
  final String? title;
  final double? fontSize;
  const FormHeading({Key? key, this.title, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.centerLeft, child: Text(title!, style: TextStyle(color: Color(0xFF213C63), fontSize: fontSize ?? 16.sp, fontWeight: FontWeight.w500)));
  }
}
