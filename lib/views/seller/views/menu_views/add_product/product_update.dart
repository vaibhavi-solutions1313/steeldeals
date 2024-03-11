import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../apis/seller/product_related.dart';
import '../../../../../main.dart';
import '../../gen_widgets/cus_textfield.dart';
import '../../gen_widgets/dashed_border.dart';
import '../../gen_widgets/form_heading.dart';
import '../../product/widgets/update_stock.dart';

class ProductUpdateView extends StatefulWidget {
  final String? id;
  final String stockId;
  final String? name;
  final List sizes;
  final String? categoryId;
  final String? price;
  final String? random;
  final String? clearCut;
  final String? description;
  final dynamic categoryInfo;
  final dynamic data;
  const ProductUpdateView(
      {Key? key, this.id, this.name, required this.sizes, this.categoryId, this.price, this.random, this.clearCut, this.description, this.categoryInfo, required this.stockId, this.data})
      : super(key: key);

  @override
  State<ProductUpdateView> createState() => _ProductUpdateViewState();
}

class _ProductUpdateViewState extends State<ProductUpdateView> {
  String _dropDownValue = "Select";
  String _dropDownValue1 = "Select";

  // STOCK
  String _dropDownValue2 = "Select";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sizeController.getCategories().whenComplete(() {
        if (widget.categoryId != null) {
          var catFound = sizeController.categoryList.firstWhereOrNull((p0) => p0['id'] == int.parse(widget.categoryId!.toString()));
          if (catFound != null) {
            Map a = catFound as Map;
            _dropDownValue = a['name'].toString();
            sizeController.selectedCategory.addAll({"name": catFound['name'], "id": catFound['id'].toString()});
          }
        }
      });
      sizeController.getPreDefinedSizes().whenComplete(() {
        // var sizeFound = sizeController.preDefinedSizesList.firstWhereOrNull((p0) => p0['id'] == int.parse(widget.sizeId!));
        // _dropDownValue1 = sizeFound['size'];
        // sizeController.size.text = sizeFound['size'];
      });
      sizeController.productName.text = widget.name!;
      // sizeController.sizeId.value = widget.sizeId!;
      sizeController.price.text = widget.price!;
      sizeController.random.text = widget.random!;
      sizeController.clearCut.text = widget.clearCut!;
      sizeController.productDescription.text = widget.description!;
      sizeController.selectedImages.clear();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    sizeController.productName.clear();
    sizeController.sizeId.value = '';
    sizeController.price.clear();
    sizeController.random.clear();
    sizeController.clearCut.clear();
    sizeController.selectedSizesList.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.orangeAccent,
          title: Text(
            "Update Product & Stock",
            style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(fontWeight: FontWeight.w600),
            tabs: [
              Tab(
                text: "Update Product",
              ),
              Tab(text: "Update Stock"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Form(
              key: sizeController.formKey,
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
                            // const Align(
                            //     alignment: Alignment.centerLeft,
                            //     child: Text("Update Product", style: TextStyle(color: Color(0xFF213C63), fontSize: 21, fontWeight: FontWeight.w700))),
                            // const Align(
                            //     alignment: Alignment.centerLeft,
                            //     child: Text("Update Information", style: TextStyle(color: Color(0xFF213C63), fontSize: 14, fontWeight: FontWeight.w600))),
                            const Padding(
                              padding: EdgeInsets.only(top: 2.0, bottom: 10),
                              child: FormHeading(title: 'Product Name'),
                            ),
                            Form(
                              key: sizeController.productNameForm,
                              child: CustomTextField(
                                controller: sizeController.productName,
                                hintText: 'Product Name',
                              ),
                            ),
                            Form(
                              key: sizeController.sizeForm,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  // Column(
                                  //   children: [
                                  //     const Padding(
                                  //       padding: EdgeInsets.only(top: 20.0, bottom: 10),
                                  //       child: FormHeading(title: 'Category'),
                                  //     ),
                                  //     Obx(
                                  //       () => Row(
                                  //         children: [
                                  //           Expanded(
                                  //             child: Container(
                                  //               padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                                  //               decoration: BoxDecoration(
                                  //                 border: Border.all(color: Colors.black12),
                                  //               ),
                                  //               child: DropdownButtonHideUnderline(
                                  //                 child: DropdownButton(
                                  //                   elevation: 1,
                                  //                   hint: _dropDownValue == null
                                  //                       ? const Text('Select Category')
                                  //                       : Text(
                                  //                           _dropDownValue,
                                  //                           style: const TextStyle(color: Colors.black54, fontSize: 16),
                                  //                         ),
                                  //                   isExpanded: true,
                                  //                   iconSize: 30.0,
                                  //                   style: const TextStyle(color: Colors.black),
                                  //                   items: sizeController.categoryList.map(
                                  //                     (val) {
                                  //                       print(val);
                                  //                       return DropdownMenuItem<String>(
                                  //                         onTap: () {
                                  //                           sizeController.selectedCategory
                                  //                               .addAll({"name": val['name'], "id": val['id'].toString(), "measurement_attributes": val['measurement_attributes']});
                                  //                         },
                                  //                         value: val['name'].toString(),
                                  //                         child: Text(
                                  //                           val['name'].toString(),
                                  //                           style: TextStyle(color: Colors.black54, fontSize: 16),
                                  //                         ),
                                  //                       );
                                  //                     },
                                  //                   ).toList(),
                                  //                   onChanged: (val) {
                                  //                     setState(
                                  //                       () {
                                  //                         _dropDownValue = val as String;
                                  //                       },
                                  //                     );
                                  //                   },
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(color: Colors.orangeAccent.withOpacity(0.3), borderRadius: BorderRadius.circular(4)),
                                        child: Text(
                                          "Note : Category can not be updated.",
                                          style: TextStyle(color: Colors.black.withOpacity(0.75)),
                                        )),
                                  ),
                                  //TODO: PRODUCT MEASUREMENT UPDATE NEEDS TO BE ADDED HERE, CURRENTLY NOT SUPPORTED.
                                  // Obx(() => sizeController.selectedCategory.isNotEmpty && sizeController.selectedCategory['measurement_attributes'] != null
                                  //     ? Row(
                                  //         mainAxisSize: MainAxisSize.max,
                                  //         children: [
                                  //           sizeController.selectedCategory['measurement_attributes'].contains("height_in_mm")
                                  //               ? Expanded(
                                  //                   child: Column(
                                  //                     crossAxisAlignment: CrossAxisAlignment.stretch,
                                  //                     children: [
                                  //                       const Padding(
                                  //                         padding: EdgeInsets.only(top: 20.0, bottom: 10),
                                  //                         child: FormHeading(title: 'Height (in mm)'),
                                  //                       ),
                                  //                       CustomTextField(
                                  //                         controller: sizeController.heightMM,
                                  //                         hintText: 'Height (in mm)',
                                  //                         keyBoardType: TextInputType.number,
                                  //                         onChange: (v) {
                                  //                           sizeController.updateSize();
                                  //                         },
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 )
                                  //               : Row(),
                                  //           if (sizeController.selectedCategory['measurement_attributes'].contains("height_in_mm"))
                                  //             const SizedBox(
                                  //               width: 10,
                                  //             ),
                                  //           sizeController.selectedCategory['measurement_attributes'].contains("diameter_in_mm")
                                  //               ? Expanded(
                                  //                   child: Column(
                                  //                     crossAxisAlignment: CrossAxisAlignment.stretch,
                                  //                     children: [
                                  //                       const Padding(
                                  //                         padding: EdgeInsets.only(top: 20.0, bottom: 10),
                                  //                         child: FormHeading(title: 'Diameter (in mm)'),
                                  //                       ),
                                  //                       CustomTextField(
                                  //                         controller: sizeController.diameterMM,
                                  //                         hintText: 'Diameter (in mm)',
                                  //                         keyBoardType: TextInputType.number,
                                  //                         onChange: (v) {
                                  //                           sizeController.updateSize();
                                  //                         },
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 )
                                  //               : Row(),
                                  //         ],
                                  //       )
                                  //     : Row()),
                                  // const SizedBox(
                                  //   height: 15,
                                  // ),
                                  // Column(
                                  //   children: [
                                  //     Row(
                                  //       mainAxisSize: MainAxisSize.max,
                                  //       children: [
                                  //         Expanded(
                                  //           child: Column(
                                  //             crossAxisAlignment: CrossAxisAlignment.stretch,
                                  //             children: [
                                  //               const Padding(
                                  //                 padding: EdgeInsets.only(top: 4.0, bottom: 4),
                                  //                 child: Align(
                                  //                     alignment: Alignment.centerLeft,
                                  //                     child: Text("Size", style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w500))),
                                  //               ),
                                  //               // CustomTextField(
                                  //               //   controller: sizeController.size,
                                  //               //   hintText: 'Ex- 25x5',
                                  //               // ),
                                  //
                                  //               Obx(
                                  //                 () => Wrap(
                                  //                   children: List.generate(sizeController.preDefinedSizesList.length, (index) {
                                  //                     return MyUpdateSizedBoxes(
                                  //                       index: index,
                                  //                       data: widget.sizes,
                                  //                     );
                                  //                   }),
                                  //                 ),
                                  //               ),
                                  //               // Obx(
                                  //               //       () => Row(
                                  //               //     children: [
                                  //               //       Expanded(
                                  //               //         child: Container(
                                  //               //           padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                                  //               //           decoration: BoxDecoration(
                                  //               //             border: Border.all(color: Colors.black12),
                                  //               //           ),
                                  //               //           child: DropdownButtonHideUnderline(
                                  //               //             child: DropdownButton(
                                  //               //               elevation: 1,
                                  //               //               hint: _dropDownValue1 == null
                                  //               //                   ? const Text('Select Size')
                                  //               //                   : Text(
                                  //               //                 _dropDownValue1,
                                  //               //                 style: const TextStyle(color: Colors.black54, fontSize: 16),
                                  //               //               ),
                                  //               //               isExpanded: true,
                                  //               //               iconSize: 30.0,
                                  //               //               style: const TextStyle(color: Colors.black),
                                  //               //               items: sizeController.preDefinedSizesList.map(
                                  //               //                     (val) {
                                  //               //                   return DropdownMenuItem<String>(
                                  //               //                     onTap: () {
                                  //               //                       sizeController.size.text = val['size'];
                                  //               //                       sizeController.sizeId.value = val['id'].toString();
                                  //               //                     },
                                  //               //                     value: val['size'].toString(),
                                  //               //                     child: Text(
                                  //               //                       val['size'].toString(),
                                  //               //                       style: TextStyle(color: Colors.black54, fontSize: 16),
                                  //               //                     ),
                                  //               //                   );
                                  //               //                 },
                                  //               //               ).toList(),
                                  //               //               onChanged: (val) {
                                  //               //                 setState(
                                  //               //                       () {
                                  //               //                     _dropDownValue = val as String;
                                  //               //                     sizeController.updateSize();
                                  //               //                   },
                                  //               //                 );
                                  //               //               },
                                  //               //             ),
                                  //               //           ),
                                  //               //         ),
                                  //               //       ),
                                  //               //     ],
                                  //               //   ),
                                  //               // ),
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                  // const SizedBox(
                                  //   height: 15,
                                  // ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 4.0, bottom: 4),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Price (in rupees)", style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w500))),
                                      ),
                                      CustomTextField(
                                        controller: sizeController.price,
                                        hintText: 'Ex - 200',
                                      ),
                                    ],
                                  ),
                                  // const Padding(
                                  //   padding: EdgeInsets.only(top: 20.0, bottom: 10),
                                  //   child: FormHeading(title: 'Length'),
                                  // ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(top: 4.0, bottom: 4),
                                              child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text("Random", style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w500))),
                                            ),
                                            CustomTextField(
                                              controller: sizeController.random,
                                              hintText: 'Rs - 0',
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(top: 4.0, bottom: 4),
                                              child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text("Clearcut", style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w500))),
                                            ),
                                            CustomTextField(
                                              controller: sizeController.clearCut,
                                              hintText: 'Rs - 500',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextField(
                                    controller: sizeController.productDescription,
                                    hintText: 'Product Description',
                                    maxLines: 5,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      sizeController.selectProductImage();
                                    },
                                    child: SizedBox(
                                      height: 100,
                                      child: DashedRect(
                                        items: [
                                          const Icon(Icons.cloud_upload, color: Colors.black54),
                                          Obx(
                                            () => Text(
                                              sizeController.selectedImages.isEmpty ? "Upload Image" : "Image selected.",
                                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// SIZE UPDATE
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "Would you like to update size as well?",
                                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Obx(
                                        () => Switch(
                                          activeColor: Colors.orangeAccent,
                                          inactiveTrackColor: Colors.grey.shade400,
                                          value: sizeController.isSizeTurnOn.value,
                                          onChanged: (value) {
                                            if (value == false) {
                                              sizeController.selectedSizeForUpdateIndex.value = 0;
                                            }
                                            sizeController.isSizeTurnOn.value = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible: sizeController.isSizeTurnOn.value == true,
                                child: Column(
                                  children: [
                                    Align(alignment: Alignment.centerLeft, child: Text("Select Size")),
                                    Row(
                                      children: List.generate(
                                        widget.sizes.length,
                                        (index) => Padding(
                                          padding: const EdgeInsets.only(right: 8.0, top: 4, bottom: 4),
                                          child: InkWell(
                                            onTap: () {
                                              sizeController.selectedSizeForUpdateIndex.value = index;
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: sizeController.selectedSizeForUpdateIndex.value == index ? Color(0xFFF5951D) : Colors.black12),
                                                  borderRadius: BorderRadius.circular(8)),
                                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                              child: Text(widget.sizes[index]['size']),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        CustomTextField(
                                          controller: sizeController.sizePrice,
                                          hintText: 'Fill New Price',
                                          keyBoardType: TextInputType.number,
                                          onChange: (v) {},
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                              decoration: BoxDecoration(color: Colors.orangeAccent.withOpacity(0.3), borderRadius: BorderRadius.circular(4)),
                                              child: Text(
                                                "Note : You can't update measurements.",
                                                style: TextStyle(color: Colors.black.withOpacity(0.75)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor: Colors.orangeAccent,
                                                  padding: EdgeInsets.symmetric(vertical: 10),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                              onPressed: () {
                                                if (sizeController.sizePrice.text.isNotEmpty) {
                                                  try {
                                                    context.loaderOverlay.show();
                                                    ProductsRelate()
                                                        .updateProductSizePrice(widget.id!, sizeController.sizePrice.text,
                                                            widget.sizes[int.parse(sizeController.selectedSizeForUpdateIndex.value.toString())]['id'].toString())
                                                        .then((value) {
                                                      context.loaderOverlay.hide();
                                                      if (value.serverStatusCode == 200) {
                                                        sizeController.sizePrice.clear();
                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated Successfully.")));
                                                      }
                                                    });
                                                  } catch (e) {
                                                    context.loaderOverlay.hide();
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong!")));
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(content: Text('Please fill data.')),
                                                  );
                                                }
                                              },
                                              child: const Text("UPDATE SIZE PRICE", style: TextStyle(color: Colors.white)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                              child: TextButton(
                                style: TextButton.styleFrom(backgroundColor: Color(0xFFF5951D), padding: const EdgeInsets.symmetric(vertical: 15)),
                                onPressed: () {
                                  if (sizeController.sizeForm.currentState!.validate() && sizeController.productNameForm.currentState!.validate()) {
                                    /// CHECKING IF SIZE ALREADY ADDED TO DB, AVOIDING DUPLICATE ENTRY TO DB.
                                    // widget.sizes.forEach((element) {
                                    //   if (sizeController.selectedSizesList.contains(element['id'].toString())) {
                                    //     sizeController.selectedSizesList.remove(element['id'].toString());
                                    //   }
                                    // });

                                    sizeController.postUpdateProduct(
                                        context,
                                        widget.id!,
                                        sizeController.productName.text.toString(),
                                        sizeController.price.text.toString(),
                                        sizeController.random.text.toString(),
                                        sizeController.clearCut.text.toString(),
                                        sizeController.productDescription.text.toString(),
                                        sizeController.selectedImages.isNotEmpty ? sizeController.imagePath.value : "");
                                  }
                                  // sizeController.addProduct();
                                  // Get.to(const SetAvailabilityView());
                                },
                                child: const Text("UPDATE PRODUCT", style: TextStyle(color: Colors.white)),
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
            UpdateStockTab(stockId: widget.stockId,stockData: widget.data['instock'],productId: widget.id!),
          ],
        ),
      ),
    );
  }
}

class MyUpdateSizedBoxes extends StatefulWidget {
  final int? index;
  final dynamic data;
  const MyUpdateSizedBoxes({
    super.key,
    this.index,
    this.data,
  });

  @override
  State<MyUpdateSizedBoxes> createState() => _MyUpdateSizedBoxesState();
}

class _MyUpdateSizedBoxesState extends State<MyUpdateSizedBoxes> {
  bool isSelected = false;

  @override
  void initState() {
    widget.data.forEach((element) {
      if (sizeController.preDefinedSizesList[widget.index!]['id'].toString() == element['id'].toString()) {
        // sizeController.selectedSizesList.add(element['id'].toString());
        isSelected = true;
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (isSelected) {
            isSelected = false;
            sizeController.selectedSizesList.remove(sizeController.preDefinedSizesList[widget.index!]['id'].toString());
          } else {
            isSelected = true;
            // sizeController.selectedSizesList.add(sizeController.preDefinedSizesList[widget.index!]['id'].toString());
          }
          setState(() {
            print(sizeController.selectedSizesList);
          });
        },
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: isSelected ? Color(0xFFF5951D) : Colors.black12), borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(sizeController.preDefinedSizesList[widget.index!]['size']),
        ),
      ),
    );
  }
}
