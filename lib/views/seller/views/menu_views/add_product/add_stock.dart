import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../main.dart';
import '../../gen_widgets/cus_textfield.dart';
import '../../gen_widgets/dashed_border.dart';
import '../../gen_widgets/form_heading.dart';

class SetAvailabilityView extends StatefulWidget {
  final bool? isFromAddProduct;
  const SetAvailabilityView({Key? key, this.isFromAddProduct}) : super(key: key);

  @override
  State<SetAvailabilityView> createState() => _SetAvailabilityViewState();
}

class _SetAvailabilityViewState extends State<SetAvailabilityView> {
  String _dropDownValue = "Select";
  String _dropDownValue1 = "Select";
  String _dropDownValue2 = "Select";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      sizeController.getPreDefinedSizes();
      productController.getProducts();
      sizeController.length.clear();
      sizeController.loadingAmountStock.clear();
      sizeController.quantity.clear();
      sizeController.productDescription.clear();
      sizeController.selectedImages.clear();
      sizeController.productKgPrice.clear();
      sizeController.selectedImages.clear();
    });

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
                        icon: Icon(Icons.arrow_back_rounded,color: Colors.orangeAccent,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: const Align(
                        alignment: Alignment.centerLeft, child: Text("Add Stock", style: TextStyle(color: Color(0xFF213C63), fontSize: 21, fontWeight: FontWeight.w700))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Provide Stock Information", style: TextStyle(color: Color(0xFF213C63), fontSize: 14, fontWeight: FontWeight.w600))),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2.0, bottom: 10),
                      child: FormHeading(title: 'Product'),
                    ),
                    Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  elevation: 1,
                                  hint: _dropDownValue1 == null
                                      ? const Text('Select Product')
                                      : Text(
                                          _dropDownValue1,
                                          style: const TextStyle(color: Colors.black54, fontSize: 16),
                                        ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  style: const TextStyle(color: Colors.black),
                                  items: productController.productsList.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        onTap: () {
                                          sizeController.selectedProductInStock.value = val;
                                          sizeController.selectedProduct.addAll({"id": val['id'].toString(), "name": val['name'].toString()});
                                        },
                                        value: val['name'].toString(),
                                        child: Text(
                                          val['name'].toString(),
                                          style: TextStyle(color: Colors.black54, fontSize: 16),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        _dropDownValue1 = val as String;
                                        sizeController.updateSize();
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
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 10),
                      child: FormHeading(title: 'ISI/NON-ISI'),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                elevation: 1,
                                hint: _dropDownValue2 == null
                                    ? const Text('Select Brand Type')
                                    : Text(
                                        _dropDownValue2,
                                        style: const TextStyle(color: Colors.black54, fontSize: 16),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: const TextStyle(color: Colors.black),
                                items: ['ISI', 'NON-ISI'].map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      onTap: () {
                                        sizeController.selectedBrandType = val;
                                      },
                                      value: val.toString(),
                                      child: Text(
                                        val.toString(),
                                        style: TextStyle(color: Colors.black54, fontSize: 16),
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      _dropDownValue2 = val as String;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 10),
                      child: FormHeading(title: 'Product Size'),
                    ),
                    Obx(
                      () => sizeController.selectedProductInStock.isNotEmpty
                          ? Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        elevation: 1,
                                        hint: _dropDownValue == null
                                            ? const Text('Select Size')
                                            : Text(
                                                _dropDownValue,
                                                style: const TextStyle(color: Colors.black54, fontSize: 16),
                                              ),
                                        isExpanded: true,
                                        iconSize: 30.0,
                                        style: const TextStyle(color: Colors.black),
                                        items: sizeController.selectedProductInStock['sizes'].map<DropdownMenuItem<String>>(
                                          (val) {
                                            return DropdownMenuItem<String>(
                                              onTap: () {
                                                // sizeController.size.text = val['size'];
                                                sizeController.sizeId.value = val['id'].toString();
                                              },
                                              value: val['size'].toString(),
                                              child: Text(
                                                val['size'].toString(),
                                                style: TextStyle(color: Colors.black54, fontSize: 16),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (val) {
                                          setState(
                                            () {
                                              _dropDownValue = val as String;
                                              sizeController.updateSize();
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(),
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.only(top: 20.0, bottom: 10),
                    //   child: FormHeading(title: 'Length'),
                    // ),
                    // Obx(() => Row(
                    //   children: [
                    //     Expanded(
                    //       child: InkWell(
                    //         onTap: () {
                    //           sizeController.lengthSelected.addAll({"lengthType": "Random", "price": sizeController.productSizesList.value});
                    //         },
                    //         child: Container(
                    //           color: sizeController.lengthSelected['lengthType'] == 'Random' ? const Color(0xFFF5951D) : Colors.grey.shade200,
                    //           height: 40,
                    //           child: Center(
                    //             child: Text(
                    //               "Random (Rs.${sizeController.productSizesList.value})",
                    //               style: TextStyle(
                    //                 color: sizeController.lengthSelected['lengthType'] == 'Random' ? Colors.white : Colors.black,
                    //                 fontWeight: FontWeight.w500,
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    //     Expanded(
                    //       child: InkWell(
                    //         onTap: () {
                    //           sizeController.lengthSelected.addAll({"lengthType": "Clearcut", "price": sizeController.productSizesList.value});
                    //         },
                    //         child: Container(
                    //           color: sizeController.lengthSelected['lengthType'] == 'Clearcut' ? const Color(0xFFF5951D) : Colors.grey.shade200,
                    //           height: 40,
                    //           child: Center(
                    //             child: Text(
                    //               "Clearcut (Rs.${sizeController.productSizesList.value})",
                    //               style: TextStyle(color: sizeController.lengthSelected['lengthType'] == 'Clearcut' ? Colors.white : Colors.black, fontWeight: FontWeight.w500),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // )),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 10),
                      child: FormHeading(title: 'Loading Amount'),
                    ),
                    CustomTextField(
                      controller: sizeController.loadingAmountStock,
                      hintText: 'Add Loading Amount',
                      maxLines: 1,
                      onChange: (v) {
                        sizeController.updateSize();
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 10),
                      child: FormHeading(title: 'Quantity'),
                    ),
                    CustomTextField(
                      controller: sizeController.quantity,
                      hintText: 'Add Quantity',
                      maxLines: 1,
                      keyBoardType: TextInputType.number,
                      onChange: (v) {
                        sizeController.updateSize();
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 10),
                      child: FormHeading(title: 'Length'),
                    ),
                    CustomTextField(
                      controller: sizeController.length,
                      hintText: 'Add Length',
                      maxLines: 1,
                      keyBoardType: TextInputType.number,
                      onChange: (v) {
                        sizeController.updateSize();
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 10),
                      child: FormHeading(title: 'Price IN KG'),
                    ),
                    CustomTextField(
                      controller: sizeController.productKgPrice,
                      hintText: 'Add Price For KG',
                      maxLines: 1,
                      keyBoardType: TextInputType.number,
                      onChange: (v) {
                        sizeController.updateSize();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10),
                      child: FormHeading(title: 'Price In MT'),
                    ),
                    CustomTextField(
                      controller: sizeController.productMtPrice,
                      hintText: 'Add Price For MT',
                      maxLines: 1,
                      keyBoardType: TextInputType.number,
                      onChange: (v) {
                        sizeController.updateSize();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        sizeController.addProductImages().then((value) {
                          setState(() {

                          });
                        });
                      },
                      child: SizedBox(
                        height: 100,
                        child: DashedRect(
                          items: [
                            const Icon(Icons.cloud_upload, color: Colors.black54),
                            Obx(
                              () => Text(
                                sizeController.selectedImages.isEmpty ? "Upload Images" : "${sizeController.selectedImages.length} images selected.",
                                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 25),
                            child: Obx(
                              () => TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: sizeController.selectedProduct['id'] != "" &&
                                            sizeController.productKgPrice.text.isNotEmpty &&
                                            sizeController.selectedBrandType.isNotEmpty &&
                                            sizeController.sizeId.value.isNotEmpty &&
                                            sizeController.length.text.isNotEmpty &&
                                            sizeController.loadingAmountStock.text.isNotEmpty &&
                                            sizeController.quantity.text.isNotEmpty &&
                                            sizeController.selectedImages.isNotEmpty
                                        ? const Color(0xFFF5951D)
                                        : Colors.grey,
                                    padding: const EdgeInsets.symmetric(vertical: 15)),
                                onPressed: sizeController.selectedProduct['id'] != "" &&
                                        sizeController.productKgPrice.text.isNotEmpty &&
                                        sizeController.selectedBrandType.isNotEmpty &&
                                        sizeController.sizeId.value.isNotEmpty &&
                                        sizeController.length.text.isNotEmpty &&
                                        sizeController.loadingAmountStock.text.isNotEmpty &&
                                        sizeController.quantity.text.isNotEmpty &&
                                        sizeController.selectedImages.isNotEmpty
                                    ? () {
                                        sizeController.addStock(
                                          context,
                                          widget.isFromAddProduct ?? false,
                                          sizeController.selectedProduct['id'].toString(),
                                          sizeController.productKgPrice.text.toString(),
                                          sizeController.selectedBrandType,
                                          sizeController.sizeId.value.toString(),
                                          sizeController.length.text.toString(),
                                          sizeController.loadingAmountStock.text.toString(),
                                          sizeController.quantity.text.toString(),
                                          sizeController.productDescription.text.toString(),
                                        );
                                      }
                                    : null,
                                child: Text(sizeController.sizeId.value.isNotEmpty ? "ADD STOCK" : "ADD STOCK", style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
