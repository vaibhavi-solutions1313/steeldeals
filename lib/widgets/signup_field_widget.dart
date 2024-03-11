import 'package:flutter/material.dart';

class CustomFields extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController textController;

  const CustomFields({Key? key, required this.title, required this.hintText, required this.textController}) : super(key: key);

  @override
  State<CustomFields> createState() => _CustomFieldsState();
}

class _CustomFieldsState extends State<CustomFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(15)),
          child: TextField(
            controller: widget.textController,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(fontSize: 16),
              border: const OutlineInputBorder(
                // borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }
}
