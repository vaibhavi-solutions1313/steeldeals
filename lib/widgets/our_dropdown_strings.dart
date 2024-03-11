import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OurListStringDropDown extends StatefulWidget {
  final String hintText;
  final List<dynamic> dropdownItems;
  final dynamic selectedDropdownItem;
  final ValueChanged<dynamic> onDropdownChanged;
  const OurListStringDropDown({super.key, required this.dropdownItems, this.selectedDropdownItem, required this.onDropdownChanged, this.hintText = "Select"});

  @override
  State<OurListStringDropDown> createState() => _OurListStringDropDownState();
}

class _OurListStringDropDownState extends State<OurListStringDropDown> {
  dynamic _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedDropdownItem;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.8,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      // decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(10.sp)),
      // padding: EdgeInsets.symmetric(horizontal: 18.sp,vertical: 5.sp),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<dynamic>(
              hint: Text(
                widget.hintText,
                style: TextStyle(fontSize: 16.sp, color: Colors.black54,fontWeight: FontWeight.w500),
              ),
              value: _selectedItem,
              onChanged: (dynamic newValue) {
                setState(() {
                  _selectedItem = newValue;
                });
                widget.onDropdownChanged(newValue); // Notify parent about the change
              },
              underline: SizedBox(),
              isExpanded: false,
              dropdownColor: Colors.grey.shade100,
              style: TextStyle(fontSize: 16.sp, color: Colors.black54,fontWeight: FontWeight.w600),
              items: widget.dropdownItems.map((dynamic item) {
                return DropdownMenuItem<dynamic>(
                  value: item,
                  child: Text(item.toString(),style: TextStyle(fontSize: 16.sp, color: Colors.black54),),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
