import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/Utils/constants.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';

import '../../../../main.dart';

class SeeAllStoresView extends StatefulWidget {
  const SeeAllStoresView({Key? key}) : super(key: key);

  @override
  State<SeeAllStoresView> createState() => _SeeAllStoresViewState();
}

class _SeeAllStoresViewState extends State<SeeAllStoresView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SimpleAppBar("Our Partners"),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: List.generate(customerHomeControl.storesList.value.length, (index) {
                String catImgUrl = Constants.baseUrl + customerHomeControl.storesList.value[index]['image'][0] ?? "";
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: InkWell(
                    onTap: () {
                      customerHomeControl.onViewStoreDetail(context,index,catImgUrl);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 45.sp,
                          height: 45.sp,
                          decoration: BoxDecoration(
                            // color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(width: 0.25, color: Colors.grey.shade200),
                          ),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: FadeInImage(
                                image: NetworkImage(catImgUrl),
                                placeholder: AssetImage("assets/ph.jpg"),
                                imageErrorBuilder: (context, error, stackTrace) {
                                  return Center(child: Image.asset("assets/ph.jpg"));
                                },
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 18.0, left: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  customerHomeControl.storesList.value[index]['shop_name'].toString(),
                                  style: TextStyle(color: Colors.black, fontSize: 18, letterSpacing: 0.24, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 8.sp,
                                ),
                                Row(
                                  children: [
                                    customerAddControl.isCurrentLocationFound.value == true
                                        ? Text(
                                            customerHomeControl.findNearestStores()[index]['restData']['address'] != null
                                                ? "${customerHomeControl.findNearestStores()[index]['restData']['address'] ?? ""} • ${customerHomeControl.getDistance(customerHomeControl.findNearestStores()[index]['restData']['latitude'], customerHomeControl.findNearestStores()[index]['restData']['longitude']).toStringAsFixed(1)}km"
                                                : "${customerHomeControl.findNearestStores()[index]['restData']['address'] ?? ""}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: Colors.black.withOpacity(0.70),
                                            ),
                                          )
                                        : Text(
                                            customerHomeControl.findNearestStores()[index]['restData']['address'] ?? "",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: Colors.black.withOpacity(0.70),
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.sp,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[
                                        const Color(0xFFF5951D).withOpacity(0.7),
                                        const Color(0xFFF5951D).withOpacity(0.3),
                                        const Color(0xFFF5951D).withOpacity(0.08),
                                        const Color(0xFFF5951D).withOpacity(0.01),
                                      ],
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(color: Color(0xFF213C63), borderRadius: BorderRadius.circular(25)),
                                          child: Icon(
                                            Icons.online_prediction,
                                            color: Colors.white,
                                            size: 14.sp,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "SHOP IS ONLINE",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
