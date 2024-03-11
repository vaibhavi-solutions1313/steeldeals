import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/Utils/constants.dart';
import 'package:services_provider_application/views/buyer/views/product_detail/product_details_view.dart';

import '../../../main.dart';

class StoreView extends StatefulWidget {
  final String? storeName;
  final String? storeImage;
  final dynamic data;
  const StoreView({
    Key? key,
    this.storeName,
    this.storeImage,
    this.data,
  }) : super(key: key);

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: storeInCustomerControl.sliverControl,
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            expandedHeight: Adaptive.h(33.33),
            primary: true,
            floating: true,
            backgroundColor: Color(0xFF213C63),
            leading: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    size: 18.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            actions: [
              Obx(() => storeInCustomerControl.isSearchEnabled.value == false
                  ? Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          onPressed: () {
                            storeInCustomerControl.resetSorting();
                            storeInCustomerControl.sliverControl.animateTo(
                              storeInCustomerControl.sliverControl.initialScrollOffset,
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.easeIn,
                            );
                            storeInCustomerControl.sliverControl.animateTo(
                              Adaptive.h(28),
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.easeIn,
                            );
                            storeInCustomerControl.isSearchEnabled.value = true;
                          },
                          icon: Icon(
                            Icons.search_rounded,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  : Row()),
              // SizedBox(
              //   width: 2,
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(4.0),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey,
              //           blurRadius: 2.0,
              //         ),
              //       ],
              //       borderRadius: BorderRadius.circular(100),
              //     ),
              //     child: IconButton(
              //         onPressed: () {
              //           // showModalBottomSheet(
              //           //   backgroundColor: Colors.white.withOpacity(0.9),
              //           //   context: context,
              //           //   builder: (context) {
              //           //     return ListView(
              //           //       children: [
              //           //         Row(
              //           //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           //           children: [
              //           //             Align(
              //           //               alignment: Alignment.centerLeft,
              //           //               child: Padding(
              //           //                 padding: const EdgeInsets.only(left: 12.0, top: 10),
              //           //                 child: Text(
              //           //                   "Owner Info",
              //           //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.8)),
              //           //                 ),
              //           //               ),
              //           //             ),
              //           //             IconButton(
              //           //               onPressed: () {
              //           //                 Get.back();
              //           //               },
              //           //               icon: Icon(
              //           //                 Icons.clear,
              //           //                 color: Color(0xFF9A208C),
              //           //               ),
              //           //             ),
              //           //           ],
              //           //         ),
              //           //         widget.data['owner'] != null
              //           //             ? Align(
              //           //           alignment: Alignment.centerLeft,
              //           //           child: Padding(
              //           //             padding: const EdgeInsets.only(left: 12.0, top: 0),
              //           //             child: Column(
              //           //               crossAxisAlignment: CrossAxisAlignment.stretch,
              //           //               children: [
              //           //                 Text(
              //           //                   widget.data['owner']['name'] != "" ? widget.data['owner']['name'] : "Not Available",
              //           //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.7)),
              //           //                 ),
              //           //                 Text(
              //           //                   widget.data['owner']['phone_no'] != "" ? widget.data['owner']['phone_no'] : "Not Available",
              //           //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.7)),
              //           //                 ),
              //           //                 Text(
              //           //                   widget.data['owner']['email'] != "" ? widget.data['owner']['email'] : "Not Available",
              //           //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.7)),
              //           //                 ),
              //           //               ],
              //           //             ),
              //           //           ),
              //           //         )
              //           //             : Text("Owner info not available."),
              //           //         SizedBox(
              //           //           height: 8,
              //           //         ),
              //           //         Align(
              //           //           alignment: Alignment.centerLeft,
              //           //           child: Padding(
              //           //             padding: const EdgeInsets.only(left: 12, top: 8.0),
              //           //             child: Text(
              //           //               "Timings",
              //           //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.8)),
              //           //             ),
              //           //           ),
              //           //         ),
              //           //         SingleChildScrollView(
              //           //           scrollDirection: Axis.horizontal,
              //           //           child: DataTable(
              //           //               columns: [
              //           //                 // Set the name of the column
              //           //                 DataColumn(
              //           //                   label: Text('Sr No.'),
              //           //                 ),
              //           //                 DataColumn(
              //           //                   label: Text('Weekday'),
              //           //                 ),
              //           //                 DataColumn(
              //           //                   label: Text('Open-Close'),
              //           //                 ),
              //           //               ],
              //           //               rows: List.generate(
              //           //                   widget.data['time_slots'].length,
              //           //                       (index) => DataRow(
              //           //                       color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
              //           //                         // All rows will have the same selected color.
              //           //                         if (states.contains(MaterialState.selected)) {
              //           //                           return Theme.of(context).colorScheme.primary.withOpacity(0.08);
              //           //                         }
              //           //                         // Even rows will have a grey color.
              //           //                         if (index.isEven) {
              //           //                           return Colors.grey.withOpacity(0.3);
              //           //                         }
              //           //                         return null; // Use default value for other states and odd rows.
              //           //                       }),
              //           //                       cells: [
              //           //                         DataCell(Text("${index + 1}")),
              //           //                         DataCell(Text(storesControl.weekday(widget.data['time_slots'][index]['day_of_week'].toString()))),
              //           //                         DataCell(Text(
              //           //                             "${widget.data['time_slots'][index]['slot_hours'][0]['start_time']} - ${widget.data['time_slots'][index]['slot_hours'][0]['end_time']}")),
              //           //                       ]))),
              //           //         ),
              //           //         Align(
              //           //           alignment: Alignment.centerLeft,
              //           //           child: Padding(
              //           //             padding: const EdgeInsets.all(8.0),
              //           //             child: Text(
              //           //               "Address",
              //           //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.8)),
              //           //             ),
              //           //           ),
              //           //         ),
              //           //         widget.data['unit_number'] != null
              //           //             ? Align(
              //           //           alignment: Alignment.centerLeft,
              //           //           child: Padding(
              //           //             padding: const EdgeInsets.all(8.0),
              //           //             child: Text(
              //           //               "${widget.data['unit_number']}, ${widget.data['street_name']}, ${widget.data['street_name']}. ${widget.data['state']}, ${widget.data['postcode']}",
              //           //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.7)),
              //           //             ),
              //           //           ),
              //           //         )
              //           //             : Text("Address not found."),
              //           //       ],
              //           //     );
              //           //   },
              //           // );
              //         },
              //         icon: const Icon(
              //           Icons.info_outline,
              //           color: Colors.black,
              //         )),
              //   ),
              // ),
            ],
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.storeName ?? "Store Name",
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              background: InkWell(
                onTap: () {
                  // Get.to(
                  // ImageView(
                  //   images: widget.data['images'] ?? [],
                  // ),
                  // transition: Transition.cupertino);
                },
                child: Image.network(
                  Constants.baseUrl+widget.storeImage!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset("assets/images/ph_res.jpg");
                  },
                ),
              ),
            ),
          ),
          Obx(() => storeInCustomerControl.isSearchEnabled.value == false
              ? SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0, top: 8, bottom: 8),
                          child: Text(
                            "Categories",
                            style: TextStyle(color: Color(0xFF213C63), fontSize: 21, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, bottom: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              customerHomeControl.storeCatList.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    storeInCustomerControl.selectedCatIndex.value = index;
                                    storeInCustomerControl.sortByCategories(customerHomeControl.storeCatList[index]['id'].toString());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: storeInCustomerControl.selectedCatIndex.value == index ? Colors.orangeAccent : Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    child: Text(
                                      customerHomeControl.storeCatList[index]['name'],
                                      style: TextStyle(color: storeInCustomerControl.selectedCatIndex.value == index ? Colors.white : Colors.black, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : SliverToBoxAdapter()),
          Obx(() => storeInCustomerControl.isSearchEnabled.value == true
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0.sp, vertical: 18),
                    child: Material(
                      color: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.sp)),
                      child: Obx(() => TextField(
                            autofocus: true,
                            controller: storeInCustomerControl.searchControl.value,
                            onChanged: (value) {
                              // storeInCustomerControl.refreshSearch();
                              List localData = List.from(customerHomeControl.storeProductList);
                              List foundData = localData
                                  .where(
                                      (element) => element['name'].toString().toLowerCase().contains(storeInCustomerControl.searchControl.value.text.toString().toLowerCase()))
                                  .toList();
                              customerHomeControl.storeNewProductList.clear();
                              customerHomeControl.storeNewProductList.value = foundData;
                              if (value.isEmpty) {
                                customerHomeControl.storeNewProductList.value = List.from(customerHomeControl.storeProductList.value);
                              }
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 25.sp),
                                hintText: 'Search for Store Products...',
                                hintStyle: const TextStyle(color: Colors.grey),
                                // prefixIcon: const Icon(Icons.search, color: Colors.transparent),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    storeInCustomerControl.isSearchEnabled.value = false;
                                    customerHomeControl.storeNewProductList.value = List.from(customerHomeControl.storeProductList);
                                    storeInCustomerControl.searchControl.value.clear();
                                    customerHomeControl.isSearchEnabled.value = false;
                                    storeInCustomerControl.sliverControl.animateTo(
                                      storeInCustomerControl.sliverControl.initialScrollOffset,
                                      duration: const Duration(milliseconds: 100),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.grey,
                                  ),
                                ),
                                border: InputBorder.none),
                          )),
                    ),
                  ),
                )
              : SliverToBoxAdapter()),
          Obx(
            () => customerHomeControl.storeNewProductList.isNotEmpty
                ? AnimationLimiter(
                    child: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 18.sp),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12.sp),
                                  onTap: () {
                                    Get.to(
                                        ProductDetailView(
                                          data: customerHomeControl.storeNewProductList[index],
                                        ),
                                        transition: Transition.cupertino);
                                  },
                                  child: Container(
                                    // margin: const EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(color: Colors.grey.shade100, blurRadius: 5.0, spreadRadius: 8),
                                      ],
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey.shade100),
                                      borderRadius: BorderRadius.circular(12.sp),
                                    ),
                                    child: Row(
                                      children: [
                                        
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: SizedBox(
                                              width: Get.width / 4.5,
                                              height: Get.width / 4.5,
                                              child: FadeInImage(
                                                image: NetworkImage(customerHomeControl.storeNewProductList[index]['images'] != null
                                                    ? Constants.baseUrl+customerHomeControl.storeNewProductList[index]['images'][0]['url'].toString()
                                                    : ""),
                                                imageErrorBuilder: (context, error, stackTrace) {
                                                  return Image.asset(
                                                    "assets/ph.jpg",
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                                fit: BoxFit.contain,
                                                placeholder: const AssetImage("assets/ph.jpg"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15.sp,
                                        ),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  customerHomeControl.storeNewProductList[index]['name'].toString(),
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.black.withOpacity(0.7)),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text("Starting from ₹${customerHomeControl.storeNewProductList[index]['price'].toString()}",
                                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp, color: Colors.orangeAccent))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        childCount: customerHomeControl.storeNewProductList.length,
                      ), //SliverChildBuildDelegate
                    ),
                  )
                : SliverToBoxAdapter(
                    child: SizedBox(
                      height: 250,
                      child: Center(
                        child: Text(
                          "No product added by partner",
                          style: TextStyle(color: Colors.black, fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
