import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controllers/custom_size_controller.dart';

class CustomSizeListView extends StatefulWidget {
  const CustomSizeListView({Key? key}) : super(key: key);

  @override
  State<CustomSizeListView> createState() => _CustomSizeListViewState();
}

class _CustomSizeListViewState extends State<CustomSizeListView> {
  final control = Get.put(SellerCustomSizeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.orangeAccent,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Custom Size Requests", style: TextStyle(color: Color(0xFF213C63), fontSize: 21, fontWeight: FontWeight.w700))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Respond to the requests",
                      style: TextStyle(color: Color(0xFF213C63), fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => control.customSizeRequestList.isNotEmpty ? ListView.builder(
              itemCount: control.customSizeRequestList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    control.customSizeRequestList[index]['product']['name'],
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("${control.customSizeRequestList[index]['size']['size'].toString()}", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
                      Text("Customer: ${control.customSizeRequestList[index]['user']['name'].toString()}", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  trailing: Wrap(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                          onPressed: () {
                            context.loaderOverlay.show();
                            try {
                              control.updateStatus('-1', control.customSizeRequestList[index]['id'].toString()).then((value) {
                                try {
                                  control.getLists().then((value) {
                                    context.loaderOverlay.hide();
                                  });
                                } catch (e) {
                                  context.loaderOverlay.hide();
                                  // TODO
                                }
                              });
                            } catch (e) {
                              context.loaderOverlay.hide();
                              // TODO
                            }
                          },
                          child: Text(
                            "Decline",
                            style: TextStyle(fontSize: 14.sp),
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF5951D),
                            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                        onPressed: () {
                          context.loaderOverlay.show();
                          try {
                            control.updateStatus('1', control.customSizeRequestList[index]['id'].toString()).then((value) {
                              try {
                                control.getLists().then((value) {
                                  context.loaderOverlay.hide();
                                });
                              } catch (e) {
                                context.loaderOverlay.hide();
                                // TODO
                              }
                            });
                          } catch (e) {
                            context.loaderOverlay.hide();
                            // TODO
                          }
                        },
                        child: Text(
                          "Accept",
                          style: TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ) : Center(child: Text("No Size Requests Found."))),
          )
        ],
      ),
    );
  }
}
