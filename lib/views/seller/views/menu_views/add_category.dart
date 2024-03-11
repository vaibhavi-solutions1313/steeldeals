import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../gen_widgets/cus_textfield.dart';
import '../gen_widgets/dashed_border.dart';
import '../gen_widgets/form_heading.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  @override
  void initState() {
    sellerCatController.clearEverything();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              Column(
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
                        alignment: Alignment.centerLeft, child: Text("Add Category", style: TextStyle(color: Color(0xFF213C63), fontSize: 21, fontWeight: FontWeight.w700))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Provide Category Information", style: TextStyle(color: Color(0xFF213C63), fontSize: 14, fontWeight: FontWeight.w600))),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 0.0, bottom: 12),
                      child: FormHeading(title: 'Name'),
                    ),
                    CustomTextField(
                      controller: sellerCatController.categoryName,
                      hintText: 'Add Category Name',
                      maxLines: 1,
                      onChange: (v) {
                        // catController.updateSize();
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 12),
                      child: FormHeading(title: 'Description'),
                    ),
                    CustomTextField(
                      controller: sellerCatController.description,
                      hintText: 'Category Description',
                      maxLines: 5,
                      onChange: (v) {
                        // catController.updateSize();
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 12),
                      child: FormHeading(title: 'Image'),
                    ),
                    InkWell(
                      onTap: () {
                        sellerCatController.addCateImages();
                      },
                      child: SizedBox(
                        height: 100,
                        child: DashedRect(
                          items: [
                            const Icon(Icons.cloud_upload, color: Colors.black54),
                            Text(
                              sellerCatController.selectedImage != "" ? "Upload Image" : "Image Selected.",
                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 12),
                      child: FormHeading(title: 'Measurements'),
                    ),
                    Wrap(
                      children: sellerCatController.measurementTypes
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                                child: InkWell(
                                  onTap: () {
                                    var found = sellerCatController.selectedAttr.firstWhereOrNull((element) => element['codeName'] == e['codeName']);
                                    if (found != null) {
                                      sellerCatController.selectedAttr.remove(e);
                                    } else {
                                      sellerCatController.selectedAttr.add(e);
                                    }
                                  },
                                  child: Obx(() => Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                                color: sellerCatController.selectedAttr.firstWhereOrNull((element) => element['codeName'] == e['codeName']) != null
                                                    ? Color(0xFFF5951D)
                                                    : Colors.grey.shade400)),
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                        child: Text(e['name'].toString()),
                                      ),),
                                ),
                              ))
                          .toList(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
              child: Obx(
                () {
                  print(sellerCatController.selectedAttr);
                  return TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: sellerCatController.categoryName.text.isNotEmpty &&
                                sellerCatController.description.text.isNotEmpty &&
                                sellerCatController.selectedAttr.isNotEmpty &&
                                sellerCatController.selectedImage != null
                            ? const Color(0xFFF5951D)
                            : Colors.grey,
                        padding: const EdgeInsets.symmetric(vertical: 15)),
                    onPressed: sellerCatController.categoryName.text.isNotEmpty &&
                            sellerCatController.description.text.isNotEmpty &&
                            sellerCatController.selectedAttr.isNotEmpty &&
                            sellerCatController.selectedImage != null
                        ? () {
                            sellerCatController.postCategory(context);
                          }
                        : null,
                    child: const Text("SAVE AND CONTINUE", style: TextStyle(color: Colors.white)),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
