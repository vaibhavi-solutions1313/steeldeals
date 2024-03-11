import 'package:flutter/material.dart';
import 'package:services_provider_application/main.dart';


class CustomDropDown extends StatefulWidget {
  final List<String>? itemsString;
  const CustomDropDown({Key? key, this.itemsString}) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  String _dropDownValue = "Select";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButton(
            elevation: 1,
            hint: _dropDownValue == null
                ? const Text('Select Type')
                : Text(
              _dropDownValue,
              style: const TextStyle(color: Colors.black54),
            ),
            isExpanded: true,
            iconSize: 30.0,
            style: const TextStyle(color: Colors.black54),
            items: widget.itemsString!.map(
                  (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val,style: const TextStyle(color: Colors.black54),),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                    () {
                  _dropDownValue = val as String;
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// class DropDownMap extends StatefulWidget {
//   final List<Size>? items;
//   const DropDownMap({Key? key, this.items}) : super(key: key);
//
//   @override
//   State<DropDownMap> createState() => _DropDownMapState();
// }
//
// class _DropDownMapState extends State<DropDownMap> {
//   @override
//   String _dropDownValue = "Select";
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: DropdownButton(
//             elevation: 1,
//             hint: _dropDownValue == null
//                 ? const Text('Select Type')
//                 : Text(
//               _dropDownValue,
//               style: const TextStyle(color: Colors.black),
//             ),
//             isExpanded: true,
//             iconSize: 30.0,
//             style: const TextStyle(color: Colors.black),
//             items: widget.items?.map(
//                   (val) {
//                 return DropdownMenuItem<String>(
//                   value: val.size,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(val.size!,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14)),
//                       Text("Rs."+val.price!,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14)),
//                     ],
//                   ),
//                 );
//               },
//             ).toList(),
//             onChanged: (val) {
//               setState(
//                     () {
//                   _dropDownValue = val as String;
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
//
// class DropDownRandom extends StatefulWidget {
//   final List<Size>? items;
//   const DropDownRandom({Key? key, this.items}) : super(key: key);
//
//   @override
//   State<DropDownRandom> createState() => _DropDownRandomMapState();
// }
//
// class _DropDownRandomMapState extends State<DropDownRandom> {
//   @override
//   String _dropDownValue = "Select";
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: DropdownButton(
//             elevation: 1,
//             hint: _dropDownValue == null
//                 ? const Text('Select Type')
//                 : Text(
//               _dropDownValue,
//               style: const TextStyle(color: Colors.black),
//             ),
//             isExpanded: true,
//             iconSize: 30.0,
//             style: const TextStyle(color: Colors.black),
//             items: widget.items?.map(
//                   (val) {
//                 return DropdownMenuItem<String>(
//                   value: val.size,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(val.size!,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14)),
//                       Text("Rs."+val.price!,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14)),
//                     ],
//                   ),
//                 );
//               },
//             ).toList(),
//             onChanged: (val) {
//               setState(
//                     () {
//                   _dropDownValue = val as String;
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }


class SizeListDD extends StatefulWidget {
  final List<dynamic>? itemsString;
  const SizeListDD({Key? key, this.itemsString}) : super(key: key);

  @override
  State<SizeListDD> createState() => _SizeListDDStateState();
}

class _SizeListDDStateState extends State<SizeListDD> {
  @override
  String _dropDownValue = "Select";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4,vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                elevation: 1,
                hint: _dropDownValue == null
                    ? const Text('Select Size')
                    : Text(
                  _dropDownValue,
                  style: const TextStyle(color: Colors.black),
                ),
                isExpanded: true,
                iconSize: 30.0,
                style: const TextStyle(color: Colors.black),
                items: widget.itemsString!.map(
                      (val) {
                    return DropdownMenuItem<String>(
                      onTap: () {
                        // sizeController.size.text = val['size'];
                        sizeController.sizeId.value = val['id'].toString();
                      },
                      value: val['size'].toString(),
                      child: Text(val['size'].toString()),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                        () {
                      _dropDownValue = val as String;
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
