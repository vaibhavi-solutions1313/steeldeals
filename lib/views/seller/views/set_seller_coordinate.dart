import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';

import '../../../main.dart';

class SetSellerCoordinateView extends StatefulWidget {
  const SetSellerCoordinateView({Key? key}) : super(key: key);

  @override
  State<SetSellerCoordinateView> createState() => _SetSellerCoordinateViewState();
}

class _SetSellerCoordinateViewState extends State<SetSellerCoordinateView> {
  @override
  void initState() {
    customerAddControl.getUserLocation().then((value) {
      customerAddControl.userCurrentCoordinates = LatLng(value.latitude, value.longitude);
      customerAddControl.addressDraggedCoordinates.value = LatLng(value.latitude, value.longitude);
      customerAddControl.mapController.move(customerAddControl.userCurrentCoordinates, 14);
      customerAddControl.addressOnDragOrOnFetch();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0xFFF5951D),
      //   iconTheme: IconThemeData(color: Colors.white),
      //   title: Text(
      //     "SET MY LOCATION",
      //     style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
      //   ),
      // ),
      body: Column(
        children: [
          SimpleAppBar('My Location on Map'),
          Expanded(
            child: FlutterMap(
              mapController: customerAddControl.mapController,
              options: MapOptions(
                center: customerAddControl.userCurrentCoordinates,
                zoom: 13.0,
                maxZoom: 19.0,
                onPositionChanged: (position, hasGesture) {
                  customerAddControl.addressDraggedCoordinates.value = LatLng(position.bounds!.center.latitude, position.bounds!.center.longitude);
                },
                onPointerUp: (event, point) async {
                  customerAddControl.addressOnDragOrOnFetch();
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.steeldeal.app',
                ),
                Obx(() => MarkerLayer(
                      markers: [
                        Marker(
                          point: customerAddControl.addressDraggedCoordinates.value,
                          width: 80.sp,
                          height: 80.sp,
                          builder: (context) => Icon(
                            Icons.location_on,
                            color: Colors.orangeAccent,
                            size: 25.sp,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0.sp, vertical: 10.sp),
        child: TextButton(
          style: TextButton.styleFrom(backgroundColor: Color(0xFFF5951D),padding: EdgeInsets.symmetric(vertical: 10.sp)),
          onPressed: () {
            /// COORDINATES UPDATE
            Get.back();
          },
          child: Text("SAVE THIS LOCATION", style: TextStyle(color: Colors.white.withOpacity(0.75), fontWeight: FontWeight.w600, fontSize: 16.sp)),
        ),
      ),
    );
  }
}
