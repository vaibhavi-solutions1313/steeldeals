import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/constants.dart';

class TextFieldView extends StatelessWidget {
  final String asset;
  final String hint;
  final bool focused;
  final TextEditingController? textEditingController;
  final int? maxLine;
  final TextInputType? inputType;
  final Color? iconColor;
  final String? suffixIcon;
  final bool? needValidate;

  const TextFieldView(
    this.asset,
    this.hint,
    this.focused, {
    Key? key,
    this.maxLine,
    this.iconColor,
    this.inputType,
    this.suffixIcon,
    this.textEditingController,
    this.needValidate = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Container(
        // height: maxLine == null ? 60.sp : 100.sp,
        // decoration: BoxDecoration(
        //     color: Color(0xFFFFFFFF),
        //     border: Border.all(color: const Color(0xffd7d7d7)),
        //     borderRadius: BorderRadius.circular(6)),
        child: Center(
          child: Theme(
            data: ThemeData(
              primaryColor: Colors.grey,
              primaryColorDark: Colors.grey,
            ),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty && needValidate == true) {
                  return 'Please fill this field';
                }
                return null;
              },
              keyboardType: inputType,
              maxLines: maxLine ?? 1,
              minLines: maxLine ?? 1,
              controller: textEditingController,
              style: TextStyle(color: focused ? Constants.primaryButtonColor : Colors.black.withOpacity(0.75), fontSize: 16, fontWeight: FontWeight.w500),
              cursorColor: Constants.primaryButtonColor,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  contentPadding: suffixIcon != null
                      ? const EdgeInsets.fromLTRB(10, 15, 0, 0)
                      : asset == ''
                          ? const EdgeInsets.fromLTRB(10, 0, 0, 0)
                          : null,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.orange, width: 2.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  hintText: hint,
                  // border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black.withOpacity(.5),fontSize: 14.sp),
                  prefixIcon: asset != ''
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: SvgPicture.asset(
                            asset,
                            color: focused ? Constants.primaryButtonColor : Colors.black.withOpacity(.5),
                            width: 2,
                          ),
                        )
                      : null,
                  suffixIcon: suffixIcon != null
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: SvgPicture.asset(
                            suffixIcon!,
                          ),
                        )
                      : null),
            ),
          ),
        ),
      ),
    );
  }
}
