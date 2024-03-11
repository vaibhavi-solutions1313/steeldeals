import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../main.dart';
import '../../gen_widgets/cus_textfield.dart';
import '../../gen_widgets/dashed_border.dart';
import '../../gen_widgets/form_heading.dart';

class UpdateStockTab extends StatefulWidget {
  final String stockId;
  final String productId;
  final dynamic stockData;
  const UpdateStockTab({Key? key, required this.stockId, this.stockData, required this.productId}) : super(key: key);

  @override
  State<UpdateStockTab> createState() => _UpdateStockTabState();
}

class _UpdateStockTabState extends State<UpdateStockTab> {
  String _dropDownValue = "Select";
  String _dropDownValue1 = "Select";
  String _dropDownValue2 = "Select";

  @override
  void initState() {
    sizeController.productKgPrice.clear();
    sizeController.length.clear();
    sizeController.loadingAmountStock.clear();
    sizeController.quantity.clear();

    // SELECTED TYPE
    _dropDownValue2 = widget.stockData['brand_type'].toString();
    sizeController.selectedBrandType = widget.stockData['brand_type'];

    // SELECTED PRODUCT
    sizeController.selectedProduct.addAll({"id": widget.productId, "name": ""});

    // ASSIGN LOADING AMOUNT
    sizeController.loadingAmountStock.value = sizeController.loadingAmountStock.value.copyWith(
      text: widget.stockData['loading_amount'].toString(),
      selection: TextSelection.collapsed(offset: widget.stockData['loading_amount'].toString().length),
    );

    // ASSIGN QUANTITY
    sizeController.quantity.value = sizeController.quantity.value.copyWith(
      text: widget.stockData['quantity'].toString(),
      selection: TextSelection.collapsed(offset: widget.stockData['quantity'].toString().length),
    );

    // ASSIGN LENGTH
    sizeController.length.value = sizeController.length.value.copyWith(
      text: widget.stockData['length'].toString(),
      selection: TextSelection.collapsed(offset: widget.stockData['length'].toString().length),
    );

    // ASSIGN BASIC PRICE
    sizeController.productKgPrice.value = sizeController.productKgPrice.value.copyWith(
      text: widget.stockData['basic_price'].toString(),
      selection: TextSelection.collapsed(offset: widget.stockData['basic_price'].toString().length),
    );

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
      children: [
        // const Padding(
        //   padding: EdgeInsets.only(top: 20.0, bottom: 10),
        //   child: FormHeading(title: 'Product'),
        // ),
        // Obx(
        //   () => Row(
        //     children: [
        //       Expanded(
        //         child: Container(
        //           padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
        //           decoration: BoxDecoration(
        //             border: Border.all(color: Colors.black12),
        //           ),
        //           child: DropdownButtonHideUnderline(
        //             child: DropdownButton(
        //               elevation: 1,
        //               hint: _dropDownValue1 == null
        //                   ? const Text('Select Product')
        //                   : Text(
        //                       _dropDownValue1,
        //                       style: const TextStyle(color: Colors.black54, fontSize: 16),
        //                     ),
        //               isExpanded: true,
        //               iconSize: 30.0,
        //               style: const TextStyle(color: Colors.black),
        //               items: productController.productsList.map(
        //                 (val) {
        //                   return DropdownMenuItem<String>(
        //                     onTap: () {
        //                       sizeController.selectedProductInStock.value = val;
        //                       sizeController.selectedProduct.addAll({"id": val['id'].toString(), "name": val['name'].toString()});
        //                     },
        //                     value: val['name'].toString(),
        //                     child: Text(
        //                       val['name'].toString(),
        //                       style: TextStyle(color: Colors.black54, fontSize: 16),
        //                     ),
        //                   );
        //                 },
        //               ).toList(),
        //               onChanged: (val) {
        //                 setState(
        //                   () {
        //                     _dropDownValue1 = val as String;
        //                     sizeController.updateSize();
        //                   },
        //                 );
        //               },
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
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
          child: FormHeading(title: 'Base Price'),
        ),
        CustomTextField(
          controller: sizeController.productKgPrice,
          hintText: 'Add Price',
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
              setState(() {});
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
                  () {
                    print(sizeController.sizeId.value);
                    return TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: sizeController.selectedProduct['id'] != "" &&
                                  sizeController.productKgPrice.text.isNotEmpty &&
                                  sizeController.selectedBrandType.isNotEmpty &&
                                  sizeController.sizeId.value.isNotEmpty &&
                                  sizeController.length.text.isNotEmpty &&
                                  sizeController.loadingAmountStock.text.isNotEmpty &&
                                  sizeController.quantity.text.isNotEmpty
                              ? const Color(0xFFF5951D)
                              : Colors.grey,
                          padding: const EdgeInsets.symmetric(vertical: 15)),
                      onPressed: sizeController.selectedProduct['id'] != "" &&
                              sizeController.productKgPrice.text.isNotEmpty &&
                              sizeController.selectedBrandType.isNotEmpty &&
                              sizeController.sizeId.value.isNotEmpty &&
                              sizeController.length.text.isNotEmpty &&
                              sizeController.loadingAmountStock.text.isNotEmpty &&
                              sizeController.quantity.text.isNotEmpty
                          ? () {
                              sizeController.updateStock(
                                context,
                                false,
                                widget.stockId,
                                sizeController.selectedProduct['id'].toString(),
                                sizeController.productKgPrice.text.toString(),
                                sizeController.selectedBrandType,
                                sizeController.sizeId.value.toString(),
                                sizeController.length.text.toString(),
                                sizeController.loadingAmountStock.text.toString(),
                                sizeController.quantity.text.toString(),
                              );
                            }
                          : null,
                      child: Text("UPDATE STOCK", style: TextStyle(color: Colors.white)),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
