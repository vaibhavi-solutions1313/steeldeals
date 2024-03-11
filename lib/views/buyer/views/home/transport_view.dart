import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../apis/buyer/general_apis.dart';
import '../../../../controllers/transport_controller.dart';
import '../../../../main.dart';
import '../sell_all_views/see_all_transports.dart';
import '../widgets/city_selector.dart';

class TransportView extends StatefulWidget {
  const TransportView({Key? key}) : super(key: key);

  @override
  State<TransportView> createState() => _TransportViewState();
}

class _TransportViewState extends State<TransportView> {
  final transportController = Get.put(TransportController());

  @override
  void initState() {
    transportControl.searchText.clear();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF1FAFF),
            Color(0xFFFFF7EE),
          ],
        )),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 25.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
                    child: InkWell(
                      onTap: () {
                        context.loaderOverlay.show();
                        try {
                          GeneralApis().getCities().then((value) {
                            context.loaderOverlay.hide();
                            List jsonData = jsonDecode(value.responseBody!);
                            jsonData.sort((a, b) => a['name'].compareTo(b['name']));
                            showDialog(
                              context: context,
                              builder: (context) {
                                return MyAlertDialog(
                                  data: jsonData,
                                );
                              },
                            );
                          });
                        } catch (e) {
                          context.loaderOverlay.hide();
                          // TODO
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('My Location', style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w600)),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                                child: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                          Obx(() => Text(customerAddControl.userLocalityDetected.value, style: TextStyle(fontSize: 14.sp, color: Colors.black45, fontWeight: FontWeight.w400)))
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(18.0.sp),
                child: TextField(
                  textAlign: TextAlign.start,
                  controller: transportControl.searchText,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Search Products',
                    hintStyle: TextStyle(fontSize: 16.sp, color: Colors.black.withOpacity(0.7)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: EdgeInsets.all(16.sp),
                    suffixIcon: const Icon(
                      Icons.search_outlined,
                      color: Colors.black45,
                    ),
                    // fillColor: colorSearchBg,
                  ),
                  onChanged: (v) {
                    transportController.searchedText();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18.0.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transport List',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(SeeAllTransports(data: transportControl.searchedTransportList), transition: Transition.rightToLeft);
                        },
                        child: Text(
                          'See all',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.orange),
                        )),
                  ],
                ),
              ),
              Obx(() => Expanded(
                    child: transportControl.searchedTransportList.value.length != 0
                        ? ListView.separated(
                            itemCount: transportControl.searchedTransportList.value.length > 5 ? 5 : transportControl.searchedTransportList.value.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 100),
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemBuilder: (context, index) {
                              return ListTile(
                                // minLeadingWidth: 12.sp,
                                leading: ClipRRect(borderRadius: BorderRadius.circular(8.sp), child: Image.network("https://picsum.photos/200")),
                                title: Text(transportControl.searchedTransportList.value[index]['name'].toString().toUpperCase(),
                                    style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.2, fontSize: 14.sp)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      '${transportControl.searchedTransportList.value[index]['phone'].toString()}',
                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Colors.black54, overflow: TextOverflow.ellipsis),
                                      maxLines: 2,
                                    ),
                                    Text(
                                      '${transportControl.searchedTransportList.value[index]['city'].toString()} • ${transportControl.searchedTransportList.value[index]['state'].toString()}',
                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Colors.black54, overflow: TextOverflow.ellipsis),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                                isThreeLine: true,
                                trailing: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor:
                                          transportControl.searchedTransportList.value[index]['phone'] != null ? Colors.orange.withOpacity(0.3) : Colors.grey.shade300),
                                  onPressed: () async {
                                    if (transportControl.searchedTransportList.value[index]['phone'] != null) {
                                      bool? res = await FlutterPhoneDirectCaller.callNumber(transportControl.searchedTransportList.value[index]['phone'].toString());
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Contact Number not provided by the transporter.")));
                                    }
                                  },
                                  child: Text(
                                    "Make a call",
                                    style: TextStyle(
                                        color: transportControl.searchedTransportList.value[index]['phone'] != null ? Colors.black.withOpacity(0.75) : Colors.black54,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp),
                                  ),
                                ),
                              );
                            },
                          )
                        : Text(
                            "Finding transporters...",
                            style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                          ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
