import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../main.dart';
import '../../gen_widgets/cus_textfield.dart';
import '../../gen_widgets/form_heading.dart';

class AddProductAndSizeView extends StatefulWidget {
  const AddProductAndSizeView({Key? key}) : super(key: key);

  @override
  State<AddProductAndSizeView> createState() => _AddProductAndSizeViewState();
}

class _AddProductAndSizeViewState extends State<AddProductAndSizeView> {
  String _dropDownValue = "Select";
  String _dropDownValue1 = "Select Category";
  TextEditingController widthMM = TextEditingController();
  TextEditingController thicknessMM = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController heightMM = TextEditingController();
  TextEditingController diameterMM = TextEditingController();

  Future<void> _launchUrl() async {
    if (!await launchUrl(
        Uri.parse('https://cbic-gst.gov.in/gst-goods-services-rates.html'))) {
      throw Exception('Could not launch url');
    }
  }

  @override
  void initState() {
    sizeController.getPreDefinedSizes();
    sizeController.getCategories();
    sizeController.clearEverything();
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
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Add Product",
                            style: TextStyle(
                                color: Color(0xFF213C63),
                                fontSize: 21,
                                fontWeight: FontWeight.w700))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Basic Information",
                            style: TextStyle(
                                color: Color(0xFF213C63),
                                fontSize: 14,
                                fontWeight: FontWeight.w600))),
                  ),
                ],
              ),
              Expanded(
                child: Form(
                  key: sizeController.formKey,
                  child: ListView(
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 18,
                          ),
                          Column(
                            children: [
                              Obx(
                                () => Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black12),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            elevation: 1,
                                            hint: _dropDownValue1 == null
                                                ? const Text('Select Category')
                                                : Text(
                                                    _dropDownValue1,
                                                    style: const TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 16),
                                                  ),
                                            isExpanded: true,
                                            iconSize: 30.0,
                                            menuMaxHeight: Adaptive.h(50),
                                            style: const TextStyle(
                                                color: Colors.black),
                                            items:
                                                sizeController.categoryList.map(
                                              (val) {
                                                print(val);
                                                return DropdownMenuItem<String>(
                                                  onTap: () {
                                                    // MEASUREMENT TEXT FIELDS ADDING TO LIST.
                                                    sizeController
                                                        .measurementFields
                                                        .clear();
                                                    sizeController
                                                        .selectedSizesList
                                                        .clear();
                                                    for (var a in val[
                                                        'measurement_attributes']) {
                                                      sizeController
                                                          .measurementFields
                                                          .add(
                                                              TextEditingController());
                                                      // sizeController.measurementFields.add({"measurementType": a, "field": TextEditingController()});
                                                    } // ENDS HERE.

                                                    sizeController
                                                        .selectedCategory
                                                        .addAll({
                                                      "name": val['name'],
                                                      "id":
                                                          val['id'].toString(),
                                                      "measurement_attributes":
                                                          val['measurement_attributes']
                                                    });
                                                    setState(() {});
                                                  },
                                                  value: val['name'].toString(),
                                                  child: Text(
                                                    val['name'].toString(),
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 16),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (val) {
                                              setState(
                                                () {
                                                  _dropDownValue1 =
                                                      val as String;
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
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                controller: sizeController.productName,
                                hintText: 'Product Name',
                                onChange: (v) {
                                  sizeController.updateSize();
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    CustomTextField(
                                      controller:
                                          sizeController.productKgPrice,
                                      hintText: 'Product Per Kilogram (kg)',
                                      keyBoardType: TextInputType.number,
                                      onChange: (v) {
                                        sizeController.updateSize();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  children: [
                                    CustomTextField(
                                      controller:
                                      sizeController.productMtPrice,
                                      hintText: 'Product Per Megaton (mt)',
                                      keyBoardType: TextInputType.number,
                                      onChange: (v) {
                                        sizeController.updateSize();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    CustomTextField(
                                      controller: sizeController.gstPercent,
                                      hintText: 'GST Percent',
                                      keyBoardType: TextInputType.number,
                                      onChange: (v) {
                                        sizeController.updateSize();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await _launchUrl();
                                },
                                child: Text("Find Gst Rate"),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    CustomTextField(
                                      controller: sizeController.priceType,
                                      hintText: 'Unit Type',
                                      keyBoardType: TextInputType.text,
                                      onChange: (v) {
                                        sizeController.updateSize();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    CustomTextField(
                                      controller: sizeController.random,
                                      hintText: 'Random (optional)',
                                      keyBoardType: TextInputType.number,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    CustomTextField(
                                      controller: sizeController.clearCut,
                                      hintText: 'Clearcut (optional)',
                                      keyBoardType: TextInputType.number,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: sizeController.productDescription,
                            hintText: 'Product Description',
                            maxLines: 3,
                            onChange: (v) {
                              sizeController.updateSize();
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Obx(
                                  () => TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.orangeAccent,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      sizeController.selectProductImage();
                                    },
                                    child: Text(
                                      sizeController.imagePath.isNotEmpty
                                          ? "Product Image Selected"
                                          : "Select Base Product Image",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() => sizeController.selectedCategory.isNotEmpty
                              ? Form(
                                  key: sizeController.sizeForm,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 20.0, bottom: 10),
                                            child:
                                                FormHeading(title: 'Add Sizes'),
                                          ),
                                          Obx(
                                              () =>
                                                  sizeController
                                                          .selectedSizesList
                                                          .isNotEmpty
                                                      ? Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 20.0,
                                                                  bottom: 10),
                                                          child: TextButton(
                                                              onPressed: () {
                                                                showModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return Container(
                                                                      height:
                                                                          Adaptive.h(
                                                                              50),
                                                                      child: StatefulBuilder(builder:
                                                                          (context,
                                                                              setState) {
                                                                        return Material(
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    FormHeading(title: 'Sizes', fontSize: 22),
                                                                                    InkWell(
                                                                                      onTap: () {
                                                                                        Get.back();
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons.cancel,
                                                                                        color: Colors.orangeAccent,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                child: Obx(() => sizeController.selectedSizesList.isNotEmpty
                                                                                    ? ListView(
                                                                                        padding: EdgeInsets.symmetric(horizontal: 18),
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
                                                                                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          width: 10,
                                                                                                        ),
                                                                                                        Flexible(
                                                                                                          child: Column(
                                                                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                                                            children: [
                                                                                                              if (sizeController.selectedSizesList[index].widthInMm != null) Text("Width : ${sizeController.selectedSizesList[index].widthInMm}mm"),
                                                                                                              if (sizeController.selectedSizesList[index].heightInMm != null) Text("Height : ${sizeController.selectedSizesList[index].heightInMm}mm"),
                                                                                                              if (sizeController.selectedSizesList[index].thicknessInMm != null) Text("Thickness : ${sizeController.selectedSizesList[index].thicknessInMm}mm"),
                                                                                                              if (sizeController.selectedSizesList[index].diameterInMm != null) Text("Diameter : ${sizeController.selectedSizesList[index].diameterInMm}mm"),
                                                                                                              if (sizeController.selectedSizesList[index].lengthInMm != null) Text("Length : ${sizeController.selectedSizesList[index].lengthInMm}mm"),
                                                                                                              if (sizeController.selectedSizesList[index].price != null) Text("Price : ₹${sizeController.selectedSizesList[index].price}"),
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
                                                                                                    child: Text("Remove"),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              index != sizeController.selectedSizesList.length - 1 ? Divider() : Row()
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : Center(child: Text("No Size Selected"))),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      }),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: Text(
                                                                  "(${sizeController.selectedSizesList.length.toString()} Added)")),
                                                        )
                                                      : Row()),
                                        ],
                                      ),

                                      /// FILLED SIZES PREVIEW
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: List.generate(
                                          sizeController
                                              .selectedCategory[
                                                  'measurement_attributes']
                                              .length,
                                          (index) => SizedBox(
                                            width: sizeController
                                                        .selectedCategory[
                                                            'measurement_attributes']
                                                        .length ==
                                                    1
                                                ? Get.width
                                                : Adaptive.w(45),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: CustomTextField(
                                                controller: sizeController
                                                    .measurementFields[index],
                                                hintText: sizeController
                                                    .selectedCategory[
                                                        'measurement_attributes']
                                                        [index]
                                                    .toString()
                                                    .replaceAll("_in_mm", "")
                                                    .capitalize,
                                                keyBoardType:
                                                    TextInputType.number,
                                                onChange: (v) {
                                                  sizeController.updateSize();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            CustomTextField(
                                              controller:
                                                  sizeController.sizePrice,
                                              hintText: 'Size Price',
                                              keyBoardType:
                                                  TextInputType.number,
                                              onChange: (v) {
                                                sizeController.updateSize();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            CustomTextField(
                                              controller: sizeController
                                                  .sizeDescription,
                                              hintText: 'Size Description',
                                              keyBoardType:
                                                  TextInputType.number,
                                              maxLines: 2,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6.0,
                                                      vertical: 10),
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.orangeAccent,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                onPressed: () {
                                                  if (sizeController
                                                      .sizeForm.currentState!
                                                      .validate()) {
                                                    sizeController.addSize();
                                                    setState(() {});
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              'Please fill data.')),
                                                    );
                                                  }
                                                },
                                                child: const Text("ADD SIZE",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : Row()),
                        ],
                      ),
                    ],
                  ),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
              child: Obx(
                () => TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: sizeController
                                  .selectedSizesList.value.isNotEmpty &&
                              sizeController.productName.text.isNotEmpty &&
                              sizeController.productKgPrice.text.isNotEmpty &&
                              sizeController
                                  .productDescription.text.isNotEmpty &&
                              sizeController.selectedCategory.isNotEmpty &&
                              sizeController.imagePath.isNotEmpty
                          ? const Color(0xFFF5951D)
                          : Colors.grey,
                      padding: const EdgeInsets.symmetric(vertical: 15)),
                  onPressed: sizeController
                              .selectedSizesList.value.isNotEmpty &&
                          sizeController.productName.text.isNotEmpty &&
                          sizeController.productKgPrice.text.isNotEmpty &&
                          sizeController.selectedCategory.isNotEmpty &&
                          sizeController.productDescription.text.isNotEmpty &&
                          sizeController.imagePath.isNotEmpty
                      ? () {
                          sizeController.postProduct(
                            context,
                          );
                        }
                      : null,
                  child: const Text("SAVE AND CONTINUE",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
