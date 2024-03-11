import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/Utils/constants.dart';
import 'package:services_provider_application/main.dart';
import '../../../../../apis/seller/shop_related.dart';
import '../../gen_widgets/cus_textfield.dart';
import '../../set_seller_coordinate.dart';

class SellerProfileTab extends StatefulWidget {
  const SellerProfileTab({Key? key}) : super(key: key);

  @override
  State<SellerProfileTab> createState() => _SellerProfileTabState();
}

class _SellerProfileTabState extends State<SellerProfileTab> {
  String openTime = "";
  String closeTime = "";

  @override
  void initState() {
    addShopController.shopProfilePicPath = "";
    addShopController.isShopProfilePicSelected = false;
    addShopController.getShopTimings().then((value) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {});
      });
    });
    addShopController.getShopInfo();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          decoration: BoxDecoration(color: Color(0xFF213C63), borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.sp), bottomLeft: Radius.circular(0.sp))),
          padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 15.sp),
          // margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: SafeArea(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    addShopController.selectDocument().then((value) {
                      if (value != null) {
                        context.loaderOverlay.show();
                        ShopRelate().postShopGenInfo(homeSellerController.shopInfo['id'].toString()).then((value) {
                          context.loaderOverlay.hide();
                          if (value.serverStatusCode == 200) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Information Updated"),
                              ),
                            );
                            addShopController.getShopTimings().then((value) => setState(() {}));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Something Went Wrong."),
                              ),
                            );
                          }
                          addShopController.getShopInfo();
                        });
                      }
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.sp),
                    child: Container(
                      width: Get.width / 3.5,
                      height: Get.width / 3.5,
                      color: Colors.orangeAccent.withOpacity(0.3),
                      child: Obx(() => Image.network(
                            Constants.baseUrl+ addShopController.shopPic.value ?? "",
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Text("No Imaaage",style: TextStyle(fontSize: 15.sp),),
                              );
                            },
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                  child: Obx(
                    () => Text(
                      homeSellerController.shopInfo['shop_name'],
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${productController.productsList.length}\nProducts\nAdded",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "0\nOrders\nTill Date", //TODO:// WE NEED TO IMPLEMENT ORDERS LENGTH HERE
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "${homeSellerController.joinedDate()}\nDays\nSince Joined",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 18.0.sp),
          title: Text(
            "Is Store Open?",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.8), fontSize: 16.sp),
          ),
          subtitle: Text(
            "Update your store status.",
            style: TextStyle(fontSize: 16.sp),
          ),
          trailing: Obx(
            () => Transform.scale(
              scale: 4.sp,
              child: Switch(
                // thumb color (round icon)
                activeColor: Color(0xFFF5951D),
                activeTrackColor: Colors.black54,
                inactiveThumbColor: Colors.amber.shade600,
                inactiveTrackColor: Colors.grey.shade400,
                splashRadius: 50.0,
                value: addShopController.isShopOpen.value,
                onChanged: (value) {
                  addShopController.isShopOpen.value = value;
                  try {
                    context.loaderOverlay.show();
                    ShopRelate().updateShopOpenStatus(addShopController.isShopOpen.value ? "1" : "0").then((value) {
                      context.loaderOverlay.hide();
                      if (value.serverStatusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated Successfully.")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong!")));
                      }
                    });
                  } catch (e) {
                    context.loaderOverlay.hide();
                    // TODO
                  }
                },
              ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0.sp, vertical: 10.sp),
          child: Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "General Info",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: 10.sp,
              ),
              InkWell(
                onTap: () {
                  if (addShopController.isGeneralReadModeOn.value == true) {
                    addShopController.isGeneralReadModeOn.value = false;
                  } else {
                    addShopController.isGeneralReadModeOn.value = true;
                    context.loaderOverlay.show();
                    ShopRelate().postShopGenInfo(homeSellerController.shopInfo['id'].toString()).then((value) {
                      context.loaderOverlay.hide();
                      if (value.serverStatusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Information Updated")));
                        addShopController.getShopTimings().then((value) => setState(() {}));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something Went Wrong.")));
                      }
                      addShopController.getShopInfo();
                    });
                  }
                  print(addShopController.isGeneralReadModeOn.value);
                },
                child: Container(
                  decoration: BoxDecoration(color: Color(0xFFF5951D), borderRadius: BorderRadius.circular(18.sp)),
                  padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 8.sp),
                  child: Obx(
                    () => Text(
                      addShopController.isGeneralReadModeOn.value == true ? "Edit" : "Update",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 0.2, fontSize: 16.sp),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
          child: Text(
            "Shop Name",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
          ),
        ),
        SizedBox(
          height: 6.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
          child: Obx(
            () => CustomTextField(
              readOnly: addShopController.isGeneralReadModeOn.value,
              controller: addShopController.shopName,
              hintText: 'Shop Name',
            ),
          ),
        ),
        SizedBox(
          height: 8.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
          child: Text(
            "Shop Description",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
          ),
        ),
        SizedBox(
          height: 6.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
          child: Obx(
            () => CustomTextField(
              readOnly: addShopController.isGeneralReadModeOn.value,
              controller: addShopController.shopDescription,
              hintText: 'Shop Description',
            ),
          ),
        ),
        // SizedBox(
        //   height: 8,
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 18.0),
        //   child: Obx(
        //     () => CustomTextField(
        //       readOnly: addShopController.isGeneralReadModeOn.value,
        //       controller: addShopController.shopNumber,
        //       hintText: 'Shop Number',
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 8.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
          child: Text(
            "Contact Number",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
          ),
        ),
        SizedBox(
          height: 6.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
          child: Obx(
            () => CustomTextField(
              readOnly: addShopController.isGeneralReadModeOn.value,
              controller: addShopController.phoneNumber,
              hintText: 'Shop Mobile Number',
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
          child: Text(
            "Shop Address",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
          child: Obx(
            () => CustomTextField(
              readOnly: addShopController.isGeneralReadModeOn.value,
              controller: addShopController.address,
              hintText: 'Shop Address',
            ),
          ),
        ),
        SizedBox(
          height: 8.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
          child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Color(0xFFF5951D).withOpacity(0.2), padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 15.sp)),
              onPressed: () {
                Get.to(SetSellerCoordinateView(), transition: Transition.cupertino);
              },
              child: Text(
                "SET MY LOCATION ON MAP",
                style: TextStyle(color: Colors.black.withOpacity(0.75), fontWeight: FontWeight.w600, fontSize: 16.sp),
              )),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.sp, vertical: 15.sp),
          child: Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Shop Timings",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: 10.sp,
              ),
              InkWell(
                onTap: () {
                  if (addShopController.isTimingsReadModeOn.value == true) {
                    addShopController.isTimingsReadModeOn.value = false;
                  } else {
                    if (addShopController.storeOpenTime.text.isNotEmpty && addShopController.storeCloseTime.text.isNotEmpty) {
                      context.loaderOverlay.show();
                      ShopRelate().postShopTimings(openTime, closeTime).then((value) {
                        context.loaderOverlay.hide();
                        if (value.serverStatusCode == 200) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Shop Timings Updated")));
                          addShopController.getShopTimings().then((value) => setState(() {}));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something Went Wrong.")));
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Fill Shop Open and Close Timings.")));
                    }
                    addShopController.isTimingsReadModeOn.value = true;
                  }
                },
                child: Container(
                  decoration: BoxDecoration(color: Color(0xFFF5951D), borderRadius: BorderRadius.circular(18.sp)),
                  padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 8.sp),
                  child: Obx(
                    () => Text(
                      addShopController.isTimingsReadModeOn.value == true ? "Edit" : "Update",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 0.2, fontSize: 16.sp),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
          child: CustomTextField(
            readOnly: true,
            onTap: () async {
              if (addShopController.isTimingsReadModeOn.value == false) {
                final TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute));
                openTime = picked!.format(context).replaceAll("AM", "").replaceAll("PM", "");
                addShopController.storeOpenTime.text = picked.format(context);
                setState(() {});
              }
            },
            controller: addShopController.storeOpenTime,
            hintText: 'Store Open Time',
          ),
        ),
        SizedBox(
          height: 15.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
          child: CustomTextField(
            readOnly: true,
            onTap: () async {
              if (addShopController.isTimingsReadModeOn.value == false) {
                final TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute));
                closeTime = picked!.format(context).replaceAll("AM", "").replaceAll("PM", "");
                addShopController.storeCloseTime.text = picked.format(context);
                setState(() {});
              }
            },
            controller: addShopController.storeCloseTime,
            hintText: 'Store Close Time',
          ),
        ),
        SizedBox(
          height: 15.sp,
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
        //         child: TextButton(
        //           style: TextButton.styleFrom(backgroundColor: Color(0xFFF5951D), padding: const EdgeInsets.symmetric(vertical: 15)),
        //           onPressed: () {
        //             if (addShopController.storeOpenTime.text.isNotEmpty && addShopController.storeCloseTime.text.isNotEmpty) {
        //               context.loaderOverlay.show();
        //               ShopRelate().postShopTimings(openTime, closeTime).then((value) {
        //                 context.loaderOverlay.hide();
        //                 if (value.serverStatusCode == 200) {
        //                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Shop Timings Updated")));
        //                   addShopController.getShopTimings().then((value) => setState(() {}));
        //                 } else {
        //                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something Went Wrong.")));
        //                 }
        //               });
        //             } else {
        //               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Fill Shop Open and Close Timings.")));
        //             }
        //           },
        //           child: const Text("UPDATE TIMINGS", style: TextStyle(color: Colors.white)),
        //         ),
        //       ),
        //     ),
        //   ],
        // )
      ],
    );
  }
}
