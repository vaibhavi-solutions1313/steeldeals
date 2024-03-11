import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final bool? readOnly;
  final TextEditingController? controller;
  final int? maxLines;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChange;
  final TextInputType? keyBoardType;
  const CustomTextField({Key? key, this.hintText = '',this.controller, this.maxLines=1, this.readOnly, this.onTap, this.keyBoardType=TextInputType.text, this.onChange,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap ?? null,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill this field';
        }
        return null;
      },
      onChanged: onChange,
      maxLines: maxLines,
      keyboardType: keyBoardType,
      readOnly: readOnly ?? false,
      style: TextStyle(color: Colors.black.withOpacity(0.85),fontSize: 16.sp),
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width:1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
      ),
    );
  }
}
