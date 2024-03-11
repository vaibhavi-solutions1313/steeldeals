import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/constants.dart';
import '../../../../main.dart';
import '../gen_widgets/cus_textfield.dart';
import '../gen_widgets/dashed_border.dart';
import '../gen_widgets/form_heading.dart';
import '../home_view/tabs_view/product_listing.dart';


class AddShopView extends StatefulWidget {
  const AddShopView({Key? key}) : super(key: key);

  @override
  State<AddShopView> createState() => _AddShopViewState();
}

class _AddShopViewState extends State<AddShopView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: addShopController.shopForm,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF0FAFF),
                Color(0xFFFFF7EE),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Create Shop", style: TextStyle(color: Color(0xFF213C63), fontSize: 21, fontWeight: FontWeight.w700))),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Basic Information", style: TextStyle(color: Color(0xFF213C63), fontSize: 14, fontWeight: FontWeight.w600))),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 10),
                        child: FormHeading(title: 'Shop Name'),
                      ),
                      CustomTextField(
                        controller: addShopController.shopName,
                        hintText: 'Shop Name',
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 10),
                        child: FormHeading(title: 'Shop Description'),
                      ),
                      CustomTextField(
                        controller: addShopController.shopDescription,
                        hintText: 'Shop Description',
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 10),
                        child: FormHeading(title: 'Shop Number'),
                      ),
                      CustomTextField(
                        controller: addShopController.shopNumber,
                        hintText: 'Shop Number',
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 10),
                        child: FormHeading(title: 'Address'),
                      ),
                      CustomTextField(
                        controller: addShopController.address,
                        hintText: 'Address',
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 10),
                        child: FormHeading(title: 'Phone Number'),
                      ),
                      CustomTextField(
                        controller: addShopController.phoneNumber,
                        hintText: 'Phone Number',
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 15),
                        child: FormHeading(title: 'Shop Image'),
                      ),
                      InkWell(
                        onTap: () async {
                          File? file = await addShopController.selectDocument();
                          if(file != null)
                          addShopController.selectedShopImages.add(file.path);
                        },
                        child: SizedBox(
                          height: 100,
                          child: DashedRect(
                            items: [
                              const Icon(Icons.cloud_upload, color: Colors.black54),
                              Obx(() => Text(
                                  addShopController.selectedShopImages.isEmpty ? "Upload Image" : "${addShopController.selectedShopImages.length} images selected.",
                                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black54))),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 15),
                        child: FormHeading(title: 'Banner Images'),
                      ),
                      InkWell(
                        onTap: () async {
                          // sizeController.addProductImages();
                          File? file = await addShopController.selectDocument();
                          if(file != null)
                          addShopController.selectedBannerImages.add(file.path);
                        },
                        child: SizedBox(
                          height: 100,
                          child: DashedRect(
                            items: [
                              const Icon(Icons.cloud_upload, color: Colors.black54),
                              Obx(() => Text(
                                  addShopController.selectedBannerImages.isEmpty ? "Upload Images" : "${addShopController.selectedBannerImages.length} images selected.",
                                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black54))),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 15),
                        child: FormHeading(title: 'Shop Video'),
                      ),
                      InkWell(
                        onTap: () async {
                          File? file = await addShopController.selectDocument();
                          if(file != null)
                          addShopController.selectedVideos.add(file.path);
                        },
                        child: SizedBox(
                          height: 100,
                          child: DashedRect(
                            items: [
                              const Icon(Icons.cloud_upload, color: Colors.black54),
                              Obx(() => Text(addShopController.selectedVideos.isEmpty ? "Upload Video" : "${addShopController.selectedVideos.length} video selected.",
                                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black54))),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 15),
                        child: FormHeading(title: 'Open Time'),
                      ),
                      TextFormField(
                        readOnly: true,
                        onTap: () async {
                          addShopController.openTimeTEC.text = await addShopController.openTimeSelector(context);
                        },
                        controller: addShopController.openTimeTEC,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select open time';
                          }
                          return null;
                        },
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Select Time',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300, width:1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 15),
                        child: FormHeading(title: 'Close Time'),
                      ),
                      TextFormField(
                        readOnly: true,
                        onTap: () async {
                          addShopController.closeTimeTEC.text = await addShopController.openTimeSelector(context);
                        },
                        controller: addShopController.closeTimeTEC,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select close time';
                          }
                          return null;
                        },
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Select Time',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300, width:1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                        child: TextButton(
                          style: TextButton.styleFrom(backgroundColor: const Color(0xFFF5951D), padding: const EdgeInsets.symmetric(vertical: 15)),
                          onPressed: () {
                            // sizeController.addProduct();

                            // Get.to(const ShopListing());
                            if (addShopController.shopForm.currentState!.validate() && addShopController.selectedShopImages.isNotEmpty && addShopController.selectedBannerImages.isNotEmpty && addShopController.selectedVideos.isNotEmpty) {
                              addShopController.createShop().then((value) {
                                if(value.serverStatusCode == 200) {
                                  Constants.showSnackBar('Shop Created Successfully.');
                                } else {
                                  Constants.showSnackBar(value.serverStatusText!);
                                }
                              });
                              Get.to(const ShopListingTab());
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Please fill all fields'),
                              ));
                            }
                          },
                          child: const Text("CREATE SHOP", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
