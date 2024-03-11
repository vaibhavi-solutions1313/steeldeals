import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../apis/buyer/product_apis.dart';
import '../main.dart';

SfRangeValues _values = const SfRangeValues(0.3, 0.7);
int selectedCertifyIndex = -1;
String quantityFilter = "";
String minimumPrice = "";
String maxPrice = "";

filterSheet(BuildContext context) {
  selectedCertifyIndex = -1;
  quantityFilter = "";
  minimumPrice = "";
  maxPrice = "";
  return showModalBottomSheet(
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(20),
      child: StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'Filter',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1.2,
                ),
                Row(
                  children: const [
                    Text(
                      'Price',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ],
                ),
                PriceRangeSlider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: const [
                      Text(
                        'Standard Certify',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CertifyStandard(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: const [
                      Text(
                        'Quantity',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                TextField(
                  textAlign: TextAlign.start,
                  // controller: searchCtrl,
                  keyboardType: TextInputType.text,
                  onChanged: (v) {
                    quantityFilter = v;
                  },
                  decoration: InputDecoration(
                    hintText: 'Ex.500Kg',
                    hintStyle: const TextStyle(fontSize: 16, color: Color(0xFF000000)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.all(16),
                    // fillColor: colorSearchBg,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 2),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFF000000)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Center(
                                  child: Text(
                                'Close',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: GestureDetector(
                            onTap: () {
                              context.loaderOverlay.show();
                              try {
                                BuyerProductApis().getFilteredProducts(minimumPrice, maxPrice, selectedCertifyIndex == 1 ? "ISI" : selectedCertifyIndex == 2 ?"NON-ISI" :"", quantityFilter).then((value) {
                                  context.loaderOverlay.hide();
                                  if (value.serverStatusCode == 200) {
                                    var json = jsonDecode(value.responseBody!);
                                    customerProductDetailControl.buyerProductList.value = json['data'];
                                    Get.back();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unable to fetch.")));
                                  }
                                });
                              } catch (e) {
                                context.loaderOverlay.hide();
                                // TODO
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(border: Border.all(color: const Color(0xFFF5951D)), color: const Color(0xFFF5951D)),
                              child: const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Center(
                                  child: Text(
                                    'Apply',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    ),
  );
}

class CertifyStandard extends StatefulWidget {
  const CertifyStandard({
    super.key,
  });

  @override
  State<CertifyStandard> createState() => _CertifyStandardState();
}

class _CertifyStandardState extends State<CertifyStandard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            selectedCertifyIndex = 1;
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedCertifyIndex == 1 ? Color(0xFFF5951D) : Colors.grey.shade300,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text("ISI"),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {
            selectedCertifyIndex = 2;
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedCertifyIndex == 2 ? Color(0xFFF5951D) : Colors.grey.shade300,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text("NON-ISI"),
          ),
        ),
      ],
    );
  }
}

class PriceRangeSlider extends StatefulWidget {
  @override
  _PriceRangeSliderState createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  RangeValues _currentRangeValues = const RangeValues(0, 100000);

  @override
  void initState() {
    minimumPrice = _currentRangeValues.start.toStringAsFixed(0);
    maxPrice = _currentRangeValues.end.toStringAsFixed(0);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      activeColor: Color(0xFFF5951D),
      values: _currentRangeValues,
      min: 0,
      max: 100000,
      onChanged: (RangeValues values) {
        minimumPrice = _currentRangeValues.start.toStringAsFixed(0);
        maxPrice = _currentRangeValues.end.toStringAsFixed(0);
        setState(() {
          _currentRangeValues = values;
        });
      },
      labels: RangeLabels(
        '₹${_currentRangeValues.start.toStringAsFixed(0)}',
        '₹${_currentRangeValues.end.toStringAsFixed(0)}',
      ),
      divisions: 10,
      onChangeStart: (RangeValues values) {
        final startTooltip = values.start.toStringAsFixed(0);
        final overlayState = Overlay.of(context);
        OverlayEntry overlayEntry;

        overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            top: 0,
            left: 0,
            child: Tooltip(
              message: '₹$startTooltip',
              child: Container(),
            ),
          ),
        );

        overlayState.insert(overlayEntry);
      },
      onChangeEnd: (RangeValues values) {
        final endTooltip = values.end.toStringAsFixed(0);
        final overlayState = Overlay.of(context);
        OverlayEntry overlayEntry;

        overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            top: 0,
            right: 0,
            child: Tooltip(
              message: '₹$endTooltip',
              child: Container(),
            ),
          ),
        );

        overlayState.insert(overlayEntry);
      },
    );
  }
}
