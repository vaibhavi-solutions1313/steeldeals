import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/main.dart';
import 'package:services_provider_application/views/seller/views/gen_widgets/cus_textfield.dart';

class NewAddressView extends StatefulWidget {
  final int? addressId;
  final int? isDefault;
  final bool isUpdate;
  final dynamic oldData;
  const NewAddressView({Key? key, required this.isUpdate, this.oldData, this.addressId, this.isDefault}) : super(key: key);

  @override
  State<NewAddressView> createState() => _NewAddressViewState();
}

class _NewAddressViewState extends State<NewAddressView> {
  @override
  void initState() {
    if (widget.isUpdate == true) {
      if (widget.isDefault == 1) {
        customerAddControl.toggleDefaultAddSwitch.value = true;
      } else {
        customerAddControl.toggleDefaultAddSwitch.value = false;
      }

      if (widget.oldData["latitude"] != null && widget.oldData["longitude"] != null) {
        customerAddControl.userCurrentCoordinates = LatLng(double.parse(widget.oldData["latitude"]), double.parse(widget.oldData["longitude"]));
        WidgetsBinding.instance.addPostFrameCallback((_) {
          customerAddControl.mapController.move(customerAddControl.userCurrentCoordinates, 14);
        });
      }
      customerAddControl.address1.value = customerAddControl.address1.value.copyWith(
        text: widget.oldData['address_line_1'],
        selection: TextSelection.collapsed(offset: widget.oldData['address_line_1'].length),
      );

      customerAddControl.address2.value = customerAddControl.address2.value.copyWith(
        text: widget.oldData['address_line_2'],
        selection: TextSelection.collapsed(offset: widget.oldData['address_line_2'].length),
      );

      customerAddControl.landmark.value = customerAddControl.landmark.value.copyWith(
        text: widget.oldData['landmark'],
        selection: TextSelection.collapsed(offset: widget.oldData['landmark'].length),
      );
      customerAddControl.city.value = customerAddControl.city.value.copyWith(
        text: widget.oldData['city'],
        selection: TextSelection.collapsed(offset: widget.oldData['city'].length),
      );
      customerAddControl.state.value = customerAddControl.state.value.copyWith(
        text: widget.oldData['state'],
        selection: TextSelection.collapsed(offset: widget.oldData['state'].length),
      );
      customerAddControl.pincode.value = customerAddControl.pincode.value.copyWith(
        text: widget.oldData['pin_code'],
        selection: TextSelection.collapsed(offset: widget.oldData['pin_code'].length),
      );
    } else {
      customerAddControl.getUserLocation().then((value) {
        customerAddControl.userCurrentCoordinates = LatLng(value.latitude, value.longitude);
        customerAddControl.addressDraggedCoordinates.value = LatLng(value.latitude, value.longitude);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          customerAddControl.mapController.move(customerAddControl.userCurrentCoordinates, 14);
          customerAddControl.addressOnDragOrOnFetch();
        });
      });
      customerAddControl.toggleDefaultAddSwitch.value == false;
      customerAddControl.address1.clear();
      customerAddControl.address2.clear();
      customerAddControl.landmark.clear();
      customerAddControl.city.clear();
      customerAddControl.state.clear();
      customerAddControl.pincode.clear();
      // customerAddControl.addressType.value = 0;
      // addressControl.selectedAddressType.clear();
    }
    // customerAddControl.mapController.move(customerAddControl.userCurrentCoordinates, 14);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    customerAddControl.addressDraggedCoordinates.value = LatLng(30.7333, 76.7794);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isUpdate == false ? "NEW ADDRESS" : "UPDATE ADDRESS",
          style: TextStyle(fontSize: 16.sp, color: Color(0xFF213C63), fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 30.sp,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 21.sp,
            color: Colors.orangeAccent,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0.sp, vertical: 15.sp),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.sp),
                child: SizedBox(
                  height: Get.height / 3,
                  child: Stack(
                    children: [
                      FlutterMap(
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
                      Positioned(
                        bottom: 15.sp,
                        right: 15.sp,
                        child: Container(
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(color: Colors.orangeAccent, borderRadius: BorderRadius.circular(50.sp)),
                          child: InkWell(
                              onTap: () {
                                customerAddControl.getUserLocation().then((value) {
                                  customerAddControl.userCurrentCoordinates = LatLng(value.latitude, value.longitude);
                                  customerAddControl.addressDraggedCoordinates.value = LatLng(value.latitude, value.longitude);
                                  customerAddControl.mapController.move(customerAddControl.userCurrentCoordinates, 14);
                                  customerAddControl.addressOnDragOrOnFetch();
                                });
                              },
                              child: Icon(
                                Icons.my_location,
                                color: Colors.white,
                                size: 18.sp,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.sp)),
              ),
              child: CustomTextField(
                hintText: "Address 1",
                controller: customerAddControl.address1,
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.sp)),
              ),
              child: CustomTextField(
                hintText: "Address 2",
                controller: customerAddControl.address2,
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.sp)),
              ),
              child: CustomTextField(
                hintText: "Landmark",
                controller: customerAddControl.landmark,
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.sp)),
              ),
              child: CustomTextField(
                hintText: "City",
                controller: customerAddControl.city,
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.sp)),
              ),
              child: CustomTextField(
                hintText: "State",
                controller: customerAddControl.state,
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.sp)),
              ),
              child: CustomTextField(
                hintText: "Pincode",
                controller: customerAddControl.pincode,
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.sp),
              title: Text(
                "Mark it as Default Address",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
              trailing: Obx(
                () => Switch(
                  onChanged: (value) {
                    customerAddControl.toggleDefaultAddSwitch.value = value;
                  },
                  value: customerAddControl.toggleDefaultAddSwitch.value,
                  activeColor: Colors.orangeAccent,
                  activeTrackColor: Colors.yellow,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0.sp, vertical: 15.sp),
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.sp)),
              padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 15.sp)),
          onPressed: () {
            if (customerAddControl.address1.text.isNotEmpty &&
                customerAddControl.address2.text.isNotEmpty &&
                customerAddControl.landmark.text.isNotEmpty &&
                customerAddControl.city.text.isNotEmpty &&
                customerAddControl.state.text.isNotEmpty &&
                customerAddControl.pincode.text.isNotEmpty) {
              if (widget.isUpdate) {
                // UPDATE ADDRESS
                customerAddControl.updateAddressToServer(
                    context,
                    widget.addressId.toString(),
                    customerAddControl.address1.text,
                    customerAddControl.address2.text,
                    customerAddControl.landmark.text,
                    customerAddControl.city.text,
                    customerAddControl.state.text,
                    customerAddControl.pincode.text,
                    customerAddControl.toggleDefaultAddSwitch.value == true ? "1" : "0",
                    customerAddControl.userCurrentCoordinates);
              } else {
                // NEW ADDRESS SUBMIT
                customerAddControl.addNewAddressToServer(
                    context,
                    widget.addressId.toString(),
                    customerAddControl.address1.text,
                    customerAddControl.address2.text,
                    customerAddControl.landmark.text,
                    customerAddControl.city.text,
                    customerAddControl.state.text,
                    customerAddControl.pincode.text,
                    customerAddControl.toggleDefaultAddSwitch.value == true ? "1" : "0",
                    customerAddControl.userCurrentCoordinates);
              }
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.isUpdate ? "UPDATE ADDRESS" : 'SAVE ADDRESS',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
