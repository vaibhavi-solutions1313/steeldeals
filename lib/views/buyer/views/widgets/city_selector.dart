import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../main.dart';

class MyAlertDialog extends StatefulWidget {
  final dynamic data;

  const MyAlertDialog({super.key, this.data});
  @override
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  String? selectedOption;

  @override
  void initState() {
    selectedOption = widget.data[0]['name'] + ', ' + widget.data[0]['state'];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select your City'),
      content: Container(
        constraints: BoxConstraints(maxWidth: 300),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            DropdownButton<dynamic>(
              // Step 3.
              value: selectedOption,
              isExpanded: true,
              // Step 4.
              items: widget.data.map<DropdownMenuItem<dynamic>>((dynamic value1) {
                return DropdownMenuItem<dynamic>(
                  value: value1['name'] +', ' +value1['state'],
                  child: Text(
                    value1['name'] + ", " + value1['state'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15.sp),
                  ),
                );
              }).toList(),
              // Step 5.
              onChanged: (dynamic newValue) {
                setState(() {
                  selectedOption = newValue!;
                });
              },
            ),
            ElevatedButton(onPressed: () {
              customerHomeControl.getUserLocation();
              Get.back();
            }, child: Text("Use my Current Location"))
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF5951D)),
          child: Text(
            'Save',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            // Do something with the selected option
            print('Selected option: $selectedOption');
            customerAddControl.userLocalityDetected.value = selectedOption!;
            await Geocoder.local.findAddressesFromQuery(selectedOption!);
            List<Location> locations = await locationFromAddress(selectedOption!);
            customerAddControl.userCurrentCoordinates = LatLng(locations[0].latitude, locations[0].longitude);
            customerAddControl.isCurrentLocationFound.value = true;
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
