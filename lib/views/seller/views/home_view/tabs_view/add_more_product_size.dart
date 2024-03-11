import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../apis/seller/product_related.dart';
import '../../../../../main.dart';
import '../../gen_widgets/cus_textfield.dart';
import '../../gen_widgets/form_heading.dart';

class AddMoreProductSize extends StatefulWidget {
  const AddMoreProductSize({Key? key}) : super(key: key);

  @override
  State<AddMoreProductSize> createState() => _AddMoreProductSizeState();
}

class _AddMoreProductSizeState extends State<AddMoreProductSize> {
  Map selectedProduct = {};
  List<TextEditingController> measureControl = [];
  String _dropDownValue = "Select";

  @override
  void initState() {
    productController.getProducts();
    sizeController.getPreDefinedSizes();
    sizeController.selectedSizesList.clear();
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
          top: true,
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
                          size: 18.sp,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Add Size to Product", style: TextStyle(color: Color(0xFF213C63), fontSize: 18.sp, fontWeight: FontWeight.w700))),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Provide required details",
                        style: TextStyle(color: Color(0xFF213C63), fontSize: 14.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 18.sp),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15.0.sp, bottom: 5.sp),
                      child: FormHeading(title: 'Product'),
                    ),
                    Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 8.sp),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  elevation: 1,
                                  hint: _dropDownValue == null
                                      ? Text(
                                          'Select Product',
                                          style: TextStyle(fontSize: 15.sp),
                                        )
                                      : Text(
                                          _dropDownValue,
                                          style: TextStyle(color: Colors.black54, fontSize: 16.sp),
                                        ),
                                  isExpanded: true,
                                  iconSize: 18.0.sp,
                                  style: const TextStyle(color: Colors.black),
                                  items: productController.productsList.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        onTap: () {
                                          selectedProduct = val;
                                          selectedProduct['category']['measurement_attributes'].forEach((element) {
                                            measureControl.add(TextEditingController());
                                          });

                                          sizeController.selectedProductInStock.value = val;
                                          sizeController.selectedProduct.addAll({"id": val['id'].toString(), "name": val['name'].toString()});
                                          setState(() {});
                                        },
                                        value: val['name'].toString(),
                                        child: Text(
                                          val['name'].toString(),
                                          style: TextStyle(color: Colors.black54, fontSize: 16.sp),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        _dropDownValue = val as String;
                                        // sizeController.updateSize();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    selectedProduct.isNotEmpty
                        ? Form(
                            key: sizeController.sizeForm,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0.sp, bottom: 10.sp),
                                      child: FormHeading(title: 'Add Sizes'),
                                    ),
                                    Obx(() => sizeController.selectedSizesList.isNotEmpty
                                        ? Padding(
                                            padding: EdgeInsets.only(top: 20.0.sp, bottom: 10.sp),
                                            child: TextButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return Container(
                                                        height: Adaptive.h(50),
                                                        child: StatefulBuilder(builder: (context, setState) {
                                                          return Material(
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.symmetric(horizontal: 18.0.sp, vertical: 8.sp),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      FormHeading(title: 'Sizes', fontSize: 18.sp),
                                                                      InkWell(
                                                                        onTap: () {
                                                                          Get.back();
                                                                        },
                                                                        child: Icon(
                                                                          Icons.cancel,
                                                                          color: Colors.orangeAccent,
                                                                          size: 18.sp,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Obx(() => sizeController.selectedSizesList.isNotEmpty
                                                                      ? ListView(
                                                                          padding: EdgeInsets.symmetric(horizontal: 18.sp),
                                                                          children: List.generate(
                                                                            sizeController.selectedSizesList.length,
                                                                            (index) => Column(
                                                                              children: [
                                                                                Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text(
                                                                                            "${index + 1}.",
                                                                                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 10,
                                                                                          ),
                                                                                          Flexible(
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                                              children: [
                                                                                                if (sizeController.selectedSizesList[index].widthInMm != null)
                                                                                                  Text("Width : ${sizeController.selectedSizesList[index].widthInMm}mm"),
                                                                                                if (sizeController.selectedSizesList[index].heightInMm != null)
                                                                                                  Text("Height : ${sizeController.selectedSizesList[index].heightInMm}mm"),
                                                                                                if (sizeController.selectedSizesList[index].thicknessInMm != null)
                                                                                                  Text(
                                                                                                      "Thickness : ${sizeController.selectedSizesList[index].thicknessInMm}mm"),
                                                                                                if (sizeController.selectedSizesList[index].diameterInMm != null)
                                                                                                  Text("Diameter : ${sizeController.selectedSizesList[index].diameterInMm}mm"),
                                                                                                if (sizeController.selectedSizesList[index].price != null)
                                                                                                  Text("Price : ₹${sizeController.selectedSizesList[index].price}"),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        sizeController.selectedSizesList.removeAt(index);
                                                                                      },
                                                                                      child: Text(
                                                                                        "Remove",
                                                                                        style: TextStyle(fontSize: 16.sp),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                index != sizeController.selectedSizesList.length - 1 ? Divider() : Row()
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Center(
                                                                          child: Text(
                                                                          "No Size Selected",
                                                                          style: TextStyle(fontSize: 16.sp),
                                                                        ))),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Text("(${sizeController.selectedSizesList.length.toString()} Added)")),
                                          )
                                        : Row()),
                                  ],
                                ),

                                /// FILLED SIZES PRE VIEW
                                selectedProduct.isNotEmpty
                                    ? Wrap(
                                        direction: Axis.horizontal,
                                        children: List.generate(
                                          selectedProduct['category']['measurement_attributes'].length,
                                          (index) => SizedBox(
                                            width: selectedProduct['category']['measurement_attributes'].length == 1 ? Get.width : Adaptive.w(45),
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 6.0, top: 6.0, bottom: 6.0),
                                              child: CustomTextField(
                                                controller: measureControl[index],
                                                hintText: selectedProduct['category']['measurement_attributes'][index].toString().replaceAll("_in_mm", "").capitalize,
                                                keyBoardType: TextInputType.number,
                                                onChange: (v) {
                                                  sizeController.updateSize();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Row(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      CustomTextField(
                                        controller: sizeController.sizePrice,
                                        hintText: 'Size Price',
                                        keyBoardType: TextInputType.number,
                                        onChange: (v) {
                                          sizeController.updateSize();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor: Colors.orangeAccent,
                                              padding: EdgeInsets.symmetric(vertical: 15),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                          onPressed: () {
                                            if (sizeController.sizeForm.currentState!.validate()) {
                                              sizeController.addProductMoreSize(
                                                  selectedProduct['category']['measurement_attributes'], sizeController.sizePrice.text, measureControl);
                                              measureControl.forEach((element) {
                                                element.clear();
                                              });
                                              setState(() {});
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('Please fill data.')),
                                              );
                                            }
                                          },
                                          child: const Text("ADD SIZE", style: TextStyle(color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        : Row(),
                    selectedProduct.isNotEmpty
                        ? Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                                  child: Obx(() => TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: sizeController.selectedSizesList.isNotEmpty ? Colors.orangeAccent : Colors.grey,
                                            padding: EdgeInsets.symmetric(vertical: 15),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                        onPressed: sizeController.selectedSizesList.isNotEmpty
                                            ? () {
                                                context.loaderOverlay.show();
                                                try {
                                                  ProductsRelate().addMoreProductSizes(selectedProduct['id'].toString(), sizeController.selectedSizesList).then((value) {
                                                    context.loaderOverlay.hide();
                                                    if (value.serverStatusCode == 200) {
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        const SnackBar(content: Text('Size Added Successfully.')),
                                                      );
                                                    }
                                                  });
                                                } catch (e) {
                                                  context.loaderOverlay.hide();
                                                  // TODO
                                                }
                                              }
                                            : null,
                                        child: const Text("UPDATE", style: TextStyle(color: Colors.white)),
                                      )),
                                ),
                              ),
                            ],
                          )
                        : Row()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
