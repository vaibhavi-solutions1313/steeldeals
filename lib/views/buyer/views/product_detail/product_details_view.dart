import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/main.dart';
import 'package:services_provider_application/views/seller/views/gen_widgets/cus_textfield.dart';
import '../../../../apis/buyer/bargain_related.dart';
import '../../../../apis/buyer/custom_size_requests.dart';
import '../../../../constants.dart';
import '../../../../widgets/simple_app_bar.dart';
import 'package:services_provider_application/views/seller/models/product_size_model.dart'
    as MySize;

import '../../controllers/product_details_controller.dart';

class ProductDetailView extends StatefulWidget {
  final dynamic data;

  const ProductDetailView({Key? key, this.data}) : super(key: key);

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  late final Future myFuture;
  final CustomerProductDetailsController customerProductDetailsController =
      Get.put(CustomerProductDetailsController());

  @override
  void initState() {
    myFuture = customerProductDetailControl
        .getProductsByProductId(widget.data["id"].toString());
    myFuture.then((value) {
      if (value != null) {
        customerProductDetailControl.type.value = "basic";
        customerProductDetailControl.typeTextController.clear();
        customerProductDetailControl.productData = value; // keep data
        customerProductDetailControl.totalPrice
            .value = (double.parse(value['instock']['basic_price'].toString()) +
                double.parse(value['sizes'][0]['pivot']['price'].toString()))
            .toString();
        customerProductDetailControl.baseTotal =
            double.parse(value['instock']['basic_price'].toString());
        customerProductDetailControl.variationPrice =
            double.parse(value['sizes'][0]['pivot']['price'].toString());
        customerProductDetailControl.variationIndex.value = 0;
        customerProductDetailControl.onCategoryPressed(value['sizes'][0], 0);
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    customerProductDetailControl.quantity.value = 1;
    customerProductDetailControl.totalPrice.value = "0";
    customerProductDetailControl.baseTotal = 0;
    customerProductDetailControl.typeContainerIndex.value = 0;
    customerProductDetailControl.type.value = "basic";
    customerProductDetailControl.typeTextController.clear();
    customerProductDetailControl.quantityTextField.value.text = '1';
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerProductDetailsController>(
      builder: (sizeController) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              const SimpleAppBar('Product details'),
              FutureBuilder<dynamic>(
                future: myFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 250,
                          ),
                          Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFFF5951D),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    //TODO: NEED TO FIX THIS ONCE SIZE UPDATE TIME AVAILABLE
                    final DateTime? now = DateTime.tryParse(
                        snapshot.data['instock']['updated_at']);
                    final DateFormat formatter = DateFormat('EEE, dd-MM-yy');
                    var stockAddedTime = formatter.format(now!);
                    return Expanded(
                      child: ListView(
                        controller: customerProductDetailControl.productScrollController,
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 25),
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              color: Colors.grey.shade100,
                              child: FadeInImage(
                                  placeholder: AssetImage("assets/ph.jpg"),
                                  image: NetworkImage(Constants.baseUrl+ snapshot.data['images'][0]['url'] ?? ""),
                                  height: Get.height / 3,
                                  fit: BoxFit.cover
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  snapshot.data['name']
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                    color: Color(0xFF213C63),
                                    fontSize: 20.sp,
                                    letterSpacing: 0.20,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    border: Border.all(
                                        color: Colors.orangeAccent,
                                        width: 0.2)),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.sp),
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(8.sp),
                                        onTap: () {
                                          customerProductDetailControl.onMinus(
                                              customerProductDetailControl
                                                  .variationPrice
                                                  .toString(),
                                              snapshot.data['instock']
                                                      ['basic_price']
                                                  .toString());
                                        },
                                        child: Container(
                                          color: Colors.orangeAccent,
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0.sp),
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                                size: 21.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 30.sp,
                                      child: Padding(
                                        padding: EdgeInsets.all(6.0.sp),
                                        child: Obx(() => TextField(
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.sp),
                                              controller:
                                                  customerProductDetailControl
                                                      .quantityTextField.value,
                                              onSubmitted: (value) {
                                                if (customerProductDetailControl
                                                        .quantityTextField
                                                        .value
                                                        .text
                                                        .isEmpty ||
                                                    double.parse(
                                                            customerProductDetailControl
                                                                .quantityTextField
                                                                .value
                                                                .text
                                                                .toString())
                                                        .isLowerThan(1)) {
                                                  customerProductDetailControl
                                                      .quantityTextField
                                                      .value
                                                      .text = "1";
                                                }
                                                customerProductDetailControl
                                                    .onEditQuantity(
                                                        customerProductDetailControl
                                                            .variationPrice
                                                            .toString(),
                                                        snapshot.data['instock']
                                                                ['basic_price']
                                                            .toString());
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration:
                                                  InputDecoration.collapsed(
                                                      hintText: "Qty"),
                                            )),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.sp),
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(8.sp),
                                        onTap: () {
                                          customerProductDetailControl
                                              .onAddition(
                                                  customerProductDetailControl
                                                      .variationPrice
                                                      .toString(),
                                                  snapshot.data['instock']
                                                          ['basic_price']
                                                      .toString());
                                        },
                                        child: Container(
                                          color: Colors.orangeAccent,
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0.sp),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 21.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          /*Obx(() => Text(
                          "Base Price : ₹${customerProductDetailsController.productsPrice(widget.data["id"].toString())}",
                          style: TextStyle(
                            color: Color(0x7f000000),
                            fontSize: 16.sp,
                            letterSpacing: 0.14,
                          ),
                        ),),*/
                          Obx(() {
                            final controller =
                                Get.find<CustomerProductDetailsController>();
                            final price = controller.quantity.value >= 1
                                ? snapshot.data['price_per_mt'] ?? '0.0'
                                : snapshot.data['price_per_kg'] ?? '0.0';
                            return Text(
                              "Base Price: ₹$price",
                              style: TextStyle(
                                color: Color(0x7f000000),
                                fontSize: 16.sp,
                                letterSpacing: 0.14,
                              ),
                            );
                          }),
                          // "Unit Type : ${widget.data['price_type'].isNotEmpty ? widget.data['price_type'] : "NA"}"
                          Obx(
                            () => Text(
                              //try
                              "Unit Type : ${Get.put(CustomerProductDetailsController()).quantity.value >= 1 ? 'Megaton' : 'KG'}",
                              style: TextStyle(
                                color: Color(0x7f000000),
                                fontSize: 16.sp,
                                letterSpacing: 0.14,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.sp),
                                  border: Border.all(
                                      color: Colors.black26, width: 1)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.sp, vertical: 4.sp),
                              child: Text(
                                "Shop ID: ${snapshot.data['shop_id'].toString()}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.sp),
                          Text(
                            snapshot.data['description'] ??
                                "Description Not Provided.",
                            maxLines: 8,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Available Sizes",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    letterSpacing: 0.20,
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp, vertical: 8.sp)),
                                  onPressed: () {
                                    final _formKey = GlobalKey<FormState>();
                                    MySize.Size filledSize = MySize.Size();
                                    List<String> measurementsName = [];

                                    // FIND MEASUREMENTS AVAILABLE
                                    var decoded = jsonDecode(snapshot
                                        .data['sizes'][0]['measurements']
                                        .toString());
                                    for (var keyName in decoded.keys) {
                                      measurementsName.add(keyName);
                                    }

                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SingleChildScrollView(
                                          child: Padding(
                                            padding: MediaQuery.of(context)
                                                .viewInsets,
                                            child: Container(
                                              // height: Get.height / 1.5,
                                              color: Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Please provide your required size',
                                                            style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          )),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Column(
                                                        children: List.generate(
                                                          measurementsName
                                                              .length,
                                                          (index) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        4.0),
                                                            child:
                                                                CustomTextField(
                                                              // controller: counterPrice,
                                                              hintText: measurementsName[
                                                                      index]
                                                                  .toString()
                                                                  .replaceAll(
                                                                      "_in_mm",
                                                                      "")
                                                                  .capitalize,
                                                              keyBoardType:
                                                                  TextInputType
                                                                      .number,
                                                              onChange: (v) {
                                                                if (measurementsName[
                                                                        index] ==
                                                                    "width_in_mm") {
                                                                  filledSize
                                                                      .widthInMm = v;
                                                                }
                                                                if (measurementsName[
                                                                        index] ==
                                                                    "height_in_mm") {
                                                                  filledSize
                                                                      .heightInMm = v;
                                                                }
                                                                if (measurementsName[
                                                                        index] ==
                                                                    "thickness_in_mm") {
                                                                  filledSize
                                                                      .thicknessInMm = v;
                                                                }
                                                                if (measurementsName[
                                                                        index] ==
                                                                    "diameter_in_mm") {
                                                                  filledSize
                                                                      .diameterInMm = v;
                                                                }
                                                                if (measurementsName[
                                                                        index] ==
                                                                    "length_in_mm") {
                                                                  filledSize
                                                                      .lengthInMm = v;
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 18.0),
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 10),
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .orangeAccent
                                                                  .withOpacity(
                                                                      0.25),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .info_outlined,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.7),
                                                              ),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                  "Once seller approves your request, You will receive a notification.",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.7),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          15.sp),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        12.sp,
                                                                    vertical:
                                                                        10.sp)),
                                                            child: Text(
                                                              'CANCEL',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.sp),
                                                            ),
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                          ),
                                                          SizedBox(
                                                            width: 15.sp,
                                                          ),
                                                          ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFFF5951D),
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        12.sp,
                                                                    vertical:
                                                                        10.sp)),
                                                            child: Text(
                                                              'REQUEST TO SELLER',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      16.sp),
                                                            ),
                                                            onPressed: () {
                                                              // COUNTER
                                                              if (_formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                context
                                                                    .loaderOverlay
                                                                    .show();
                                                                try {
                                                                  CustomSizeRequestsApis()
                                                                      .requestCustomSize(
                                                                          widget
                                                                              .data["id"]
                                                                              .toString(),
                                                                          filledSize)
                                                                      .then((value) {
                                                                    context
                                                                        .loaderOverlay
                                                                        .hide();
                                                                    print(value
                                                                        .responseBody);
                                                                    if (value
                                                                            .serverStatusCode ==
                                                                        200) {
                                                                      Get.back();
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          dismissDirection:
                                                                              DismissDirection.startToEnd,
                                                                          content:
                                                                              Text("Your request sent successfully."),
                                                                        ),
                                                                      );
                                                                    }
                                                                  });
                                                                } catch (e) {
                                                                  // TODO
                                                                  context
                                                                      .loaderOverlay
                                                                      .hide();
                                                                }
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    "Request Custom Size",
                                    style: TextStyle(
                                        color: Colors.orangeAccent,
                                        fontSize: 16.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: List.generate(
                                  snapshot.data['sizes'].length, (index) {
                                var measurement = jsonDecode(snapshot
                                    .data['sizes'][index]['measurements']
                                    .toString());
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Obx(
                                    () => InkWell(
                                      onTap: () {
                                        customerProductDetailControl
                                                .variationPrice =
                                            double.parse(snapshot.data['sizes']
                                                    [index]['pivot']['price']
                                                .toString());
                                        customerProductDetailControl
                                            .variationIndex.value = index;
                                        customerProductDetailControl
                                            .onCategoryPressed(
                                                snapshot.data['sizes'][index],
                                                index);
                                        customerProductDetailControl
                                                .totalPrice.value =
                                            (((customerProductDetailControl
                                                            .baseTotal +
                                                        double.parse(snapshot
                                                            .data['sizes']
                                                                [index]['pivot']
                                                                ['price']
                                                            .toString())) *
                                                    customerProductDetailControl
                                                        .quantity.value))
                                                .toString();

                                        /// RESET TYPE AND FIELD
                                        customerProductDetailControl
                                            .typeContainerIndex.value = 0;
                                        customerProductDetailControl
                                            .type.value = "basic";
                                        customerProductDetailControl
                                            .typeTextController
                                            .clear();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.sp, vertical: 10.sp),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.sp),
                                            border: Border.all(
                                                color:
                                                    customerProductDetailControl
                                                                .variationIndex
                                                                .value ==
                                                            index
                                                        ? Constants
                                                            .primaryButtonColor
                                                        : Colors.grey.shade200),
                                            color: Constants.primaryButtonColor
                                                .withOpacity(.05)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Size : ${snapshot.data['sizes'][index]['size'].toString()}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15.sp,
                                                    // letterSpacing:1,
                                                  ),
                                                ),
                                                Text(
                                                  "Updated: $stockAddedTime",
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              ],
                                            ),
                                            // Visibility(
                                            //   visible: measurement['width_in_mm'] != null,
                                            //   child: Text(
                                            //     "Width : ${measurement['width_in_mm']}mm",
                                            //     style: TextStyle(
                                            //       color: Colors.black,
                                            //       // fontSize: 14,
                                            //       // letterSpacing:1,
                                            //     ),
                                            //   ),
                                            // ),
                                            // Visibility(
                                            //   visible: measurement['length_in_mm'] != null,
                                            //   child: Text(
                                            //     "Length : ${measurement['length_in_mm']}mm",
                                            //     style: TextStyle(
                                            //       color: Colors.black,
                                            //       // fontSize: 14,
                                            //       // letterSpacing:1,
                                            //     ),
                                            //   ),
                                            // ),
                                            // Visibility(
                                            //   visible: measurement['thickness_in_mm'] != null,
                                            //   child: Text(
                                            //     "Thickness : ${measurement['thickness_in_mm']}mm",
                                            //     style: TextStyle(
                                            //       color: Colors.black,
                                            //       // fontSize: 14,
                                            //       // letterSpacing:1,
                                            //     ),
                                            //   ),
                                            // ),
                                            // Visibility(
                                            //   visible: measurement['height_in_mm'] != null,
                                            //   child: Text(
                                            //     "Height : ${measurement['height_in_mm']}mm",
                                            //     style: TextStyle(
                                            //       color: Colors.black,
                                            //       // fontSize: 14,
                                            //       // letterSpacing:1,
                                            //     ),
                                            //   ),
                                            // ),
                                            // Visibility(
                                            //   visible: measurement['diameter_in_mm'] != null,
                                            //   child: Text(
                                            //     "Diameter : ${measurement['diameter_in_mm']}mm",
                                            //     style: TextStyle(
                                            //       color: Colors.black,
                                            //       // fontSize: 14,
                                            //       // letterSpacing:1,
                                            //     ),
                                            //   ),
                                            // ),
                                            Visibility(
                                              visible: snapshot.data['sizes']
                                                          [index]['pivot']
                                                      ['price'] !=
                                                  null,
                                              child: Text(
                                                "Price : ₹${snapshot.data['sizes'][index]['pivot']['price']}",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.sp,
                                                  // letterSpacing:1,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "${snapshot.data['sizes'][index]['pivot']['description'] ?? "No Size Description"}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.sp,
                                                // letterSpacing:1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                            child: Text(
                              'Please select',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 16.sp),
                            ),
                          ),
                          Obx(() => Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      customerProductDetailControl
                                          .typeContainerIndex.value = 0;
                                      customerProductDetailControl.type.value =
                                          'basic';
                                      var tot = double.parse(
                                              customerProductDetailControl
                                                  .baseTotal
                                                  .toString()) *
                                          customerProductDetailControl
                                              .quantity.value;
                                      customerProductDetailControl
                                          .totalPrice.value = tot.toString();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp, vertical: 8.sp),
                                      decoration: BoxDecoration(
                                        color: customerProductDetailControl
                                                    .typeContainerIndex.value ==
                                                0
                                            ? Colors.orangeAccent
                                            : Colors.grey.shade200,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Basic',
                                          style: TextStyle(
                                              color: customerProductDetailControl
                                                          .typeContainerIndex
                                                          .value ==
                                                      0
                                                  ? Colors.white
                                                  : Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      customerProductDetailControl
                                          .clearcutOrRandomAdd(widget
                                              .data['clear_cut']
                                              .toString());
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "Price revised based on your selection."),
                                        duration: Duration(milliseconds: 500),
                                      ));
                                      customerProductDetailControl
                                          .typeContainerIndex.value = 1;
                                      customerProductDetailControl.type.value =
                                          'clearcut';
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp, vertical: 8.sp),
                                      decoration: BoxDecoration(
                                        border: Border.symmetric(
                                            vertical: BorderSide(
                                                color: Colors.grey.shade50,
                                                width: 0.5)),
                                        color: customerProductDetailControl
                                                    .typeContainerIndex.value ==
                                                1
                                            ? Colors.orangeAccent
                                            : Colors.grey.shade200,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Clearcut',
                                          style: TextStyle(
                                              color: customerProductDetailControl
                                                          .typeContainerIndex
                                                          .value ==
                                                      1
                                                  ? Colors.white
                                                  : Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      customerProductDetailControl
                                          .clearcutOrRandomAdd(
                                              widget.data['random'].toString());
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "Price revised based on your selection."),
                                        duration: Duration(milliseconds: 500),
                                      ));
                                      customerProductDetailControl
                                          .typeContainerIndex.value = 2;
                                      customerProductDetailControl.type.value =
                                          'random';
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp, vertical: 8.sp),
                                      decoration: BoxDecoration(
                                          color: customerProductDetailControl
                                                      .typeContainerIndex
                                                      .value ==
                                                  2
                                              ? Colors.orangeAccent
                                              : Colors.grey.shade200,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8.sp),
                                              bottomRight:
                                                  Radius.circular(8.sp))),
                                      child: Center(
                                          child: Text(
                                        'Random',
                                        style: TextStyle(
                                            color: customerProductDetailControl
                                                        .typeContainerIndex
                                                        .value ==
                                                    2
                                                ? Colors.white
                                                : Colors.black87,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp),
                                      )),
                                    ),
                                  ),
                                ],
                              )),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                          //   child: Obx(
                          //     () => customerProductDetailControl.type.value != "basic"
                          //         ? Padding(
                          //             padding: MediaQuery.of(context).viewInsets,
                          //             child: CustomTextField(
                          //               hintText: "${customerProductDetailControl.type.value == "clearcut" ? "Clearcut Amount" : "Random Amount"}",
                          //               controller: customerProductDetailControl.typeTextController,
                          //               onChange: (v) {
                          //                 customerProductDetailControl.addClearRandomToTotal(v);
                          //               },
                          //             ),
                          //           )
                          //         : Row(),
                          //   ),
                          // ),
                          // Obx(() => customerProductDetailControl.type.value != "basic"
                          //     ? Container(
                          //         padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.orangeAccent),
                          //         child: Text(
                          //           "Note : This amount will be added in the base price.",
                          //           style: TextStyle(color: Colors.white, fontSize: 14.sp),
                          //         ),
                          //       )
                          //     : Row()),
                        ],
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Product is out of stock or May removed by seller.",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              "Go Back",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
              Obx(() => customerProductDetailControl.totalPrice.value != "0"
                  ? Row(
                      children: [
                        Expanded(
                          child: Obx(() => InkWell(
                                onTap:
                                    customerProductDetailControl
                                            .totalPrice.value.isNotEmpty
                                        ? () {
                                            TextEditingController counterPrice =
                                                TextEditingController();
                                            final _formKey =
                                                GlobalKey<FormState>();
                                            // counterPrice.text = customerProductDetailControl.totalPrice.value;
                                            showModalBottomSheet<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Padding(
                                                  padding:
                                                      MediaQuery.of(context)
                                                          .viewInsets,
                                                  child: Container(
                                                    height: Get.height / 3.5,
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              18.0),
                                                      child: Form(
                                                        key: _formKey,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  'Please create bargain request',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                )),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            CustomTextField(
                                                              controller:
                                                                  counterPrice,
                                                              hintText:
                                                                  'Add Price',
                                                              keyBoardType:
                                                                  TextInputType
                                                                      .number,
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                ElevatedButton(
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: 12
                                                                            .sp,
                                                                        vertical:
                                                                            10.sp),
                                                                  ),
                                                                  child: Text(
                                                                    'CANCEL',
                                                                    style: TextStyle(
                                                                        fontSize: 16
                                                                            .sp,
                                                                        letterSpacing:
                                                                            0.8),
                                                                  ),
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context),
                                                                ),
                                                                SizedBox(
                                                                  width: 15,
                                                                ),
                                                                ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Color(
                                                                              0xFFF5951D),
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: 12
                                                                              .sp,
                                                                          vertical:
                                                                              10.sp)),
                                                                  child: Text(
                                                                    'REQUEST TO SELLER',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize: 16
                                                                            .sp,
                                                                        letterSpacing:
                                                                            0.8),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    // COUNTER
                                                                    double
                                                                        totalPrice =
                                                                        double.parse(customerProductDetailControl
                                                                            .totalPrice
                                                                            .value); // Replace with your total price value
                                                                    double
                                                                        percentage =
                                                                        2.0;
                                                                    double
                                                                        result =
                                                                        (totalPrice *
                                                                                percentage) /
                                                                            100.0;
                                                                    double
                                                                        minusTotalPrice =
                                                                        totalPrice -
                                                                            result;
                                                                    if (_formKey
                                                                        .currentState!
                                                                        .validate()) {
                                                                      if (double.parse(counterPrice
                                                                              .text
                                                                              .toString()) >
                                                                          minusTotalPrice) {
                                                                        context
                                                                            .loaderOverlay
                                                                            .show();
                                                                        try {
                                                                          CustomerBargainRelated()
                                                                              .raiseBargain(
                                                                            widget.data["id"].toString(),
                                                                            widget.data['instock']['id'].toString(),
                                                                            customerProductDetailControl.selectedAngleSize[0]['id'].toString(),
                                                                            counterPrice.text,
                                                                            customerProductDetailControl.quantity.value.toString(),
                                                                            customerProductDetailControl.type.toString(),
                                                                          )
                                                                              .then((value) {
                                                                            context.loaderOverlay.hide();
                                                                            print(value.responseBody);
                                                                            if (value.serverStatusCode ==
                                                                                200) {
                                                                              Get.back();
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  dismissDirection: DismissDirection.startToEnd,
                                                                                  content: Text("Counter request sent successfully."),
                                                                                ),
                                                                              );
                                                                            }
                                                                          });
                                                                        } catch (e) {
                                                                          // TODO
                                                                          context
                                                                              .loaderOverlay
                                                                              .hide();
                                                                        }
                                                                      } else {
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                "You can only request up to 2% of total.\nEnter amount greater than $minusTotalPrice",
                                                                            toastLength: Toast
                                                                                .LENGTH_SHORT,
                                                                            gravity: ToastGravity
                                                                                .BOTTOM,
                                                                            timeInSecForIosWeb:
                                                                                1,
                                                                            backgroundColor:
                                                                                Colors.black45,
                                                                            textColor: Colors.white,
                                                                            fontSize: 16.0);
                                                                      }
                                                                    }
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        : null,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 18.5, horizontal: 4),
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(15),
                                    color: customerProductDetailControl
                                            .totalPrice.value.isNotEmpty
                                        ? Color(0xFF213C63)
                                        : Colors.grey.shade500,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "BARGAIN",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontFamily: "Gilroy",
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.14,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        Expanded(
                          child: Obx(() => InkWell(
                                onTap:
                                    customerProductDetailControl
                                            .totalPrice.value.isNotEmpty
                                        ? () {
                                            if (customerProductDetailControl
                                                    .quantityTextField
                                                    .value
                                                    .text
                                                    .isNotEmpty &&
                                                double.parse(
                                                        customerProductDetailControl
                                                            .quantityTextField
                                                            .value
                                                            .text) >=
                                                    1.0) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Wrap(
                                                      children: [
                                                        Text(
                                                          "Would you like to pay loading amount as well?",
                                                          style: TextStyle(
                                                            fontSize: 17.sp,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    actions: [
                                                      ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        18.sp,
                                                                    vertical:
                                                                        8.sp)),
                                                        onPressed: () {
                                                          customerProductDetailControl
                                                              .addToCart(
                                                                  context,
                                                                  false)
                                                              .whenComplete(() {
                                                            Get.back();
                                                          });
                                                        },
                                                        child: Text(
                                                          "No",
                                                          style: TextStyle(
                                                              fontSize: 16.sp),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Color(
                                                                    0xFFF5951D),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        18.sp,
                                                                    vertical:
                                                                        8.sp)),
                                                        onPressed: () {
                                                          customerProductDetailControl
                                                              .addToCart(
                                                                  context, true)
                                                              .whenComplete(() {
                                                            Get.back();
                                                          });
                                                        },
                                                        child: Text(
                                                          "Yes",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16.sp,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Please fill quantity.'),
                                                ),
                                              );
                                            }
                                          }
                                        : null,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 4),
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(15),
                                    color: customerProductDetailControl
                                            .totalPrice.value.isNotEmpty
                                        ? Color(0xfff5951d)
                                        : Colors.grey.shade500,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "ADD TO CART",
                                      // "ADD TO CART | ₹${customerProductDetailControl.totalPrice.value}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontFamily: "Gilroy",
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.14,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    )
                  : Row()),
            ],
          ),
        );
      },
    );
  }
}
