import 'dart:convert';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/views/seller/views/gen_widgets/cus_textfield.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';
import '../../../apis/buyer/bargain_related.dart';
import '../../../main.dart';

class BargainListView extends StatefulWidget {
  const BargainListView({Key? key}) : super(key: key);

  @override
  State<BargainListView> createState() => _BargainListViewState();
}

class _BargainListViewState extends State<BargainListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SimpleAppBar("Bargain Requests"),
          Expanded(
            child: FutureBuilder<List>(
              future: customerBargainControl.getBargainList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Color(0xFFF5951D),
                  ));
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 8.sp),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.sp),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12.sp),
                              border: Border.all(width: 2.sp, color: Colors.grey.shade200),
                            ),
                            child: Theme(
                              data: ThemeData(
                                useMaterial3: true,
                                dividerColor: Colors.transparent,
                                canvasColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                expansionTileTheme: ExpansionTileThemeData(
                                    // collapsedBackgroundColor: Colors.orangeAccent.withOpacity(0.2),
                                    // backgroundColor: Colors.orangeAccent.withOpacity(0.1),
                                    ),
                              ),
                              child: ExpansionTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.sp),
                                ),
                                title: Text(
                                  snapshot.data![index]['product']['name'],
                                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.85), fontSize: 16.sp),
                                ),
                                subtitle: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.sp),
                                      child: Text(snapshot.data![index]['type'].toString().capitalize.toString(),
                                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Colors.orange)),
                                    ),
                                  ],
                                ),
                                childrenPadding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 4.sp),
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: List.generate(
                                      snapshot.data![index]['history'].length,
                                      (index1) {
                                        // CHECK WAITING FOR SELLER RESPONSE OR NOT
                                        if (snapshot.data![index]['history'].length - 1 == index1) {
                                          if (snapshot.data![index]['history'][index1].keys.first == "buyer") {
                                            customerBargainControl.isWaitingForBuyer.value = true;
                                          } else {
                                            customerBargainControl.isWaitingForBuyer.value = false;
                                          }
                                        }
                                        return Padding(
                                          padding: EdgeInsets.symmetric(vertical: 4.0.sp),
                                          child: Row(
                                            mainAxisAlignment:
                                                snapshot.data![index]['history'][index1].keys.first == "buyer" ? MainAxisAlignment.end : MainAxisAlignment.start,
                                            children: [
                                              BubbleSpecialOne(
                                                text: snapshot.data![index]['history'][index1].keys.first == "buyer"
                                                    ? 'Me: ' + cartController.reformattedNumbers(snapshot.data![index]['history'][index1]['buyer'].toString(), true)
                                                    : 'Seller: ' + cartController.reformattedNumbers(snapshot.data![index]['history'][index1]['seller'].toString(), true),
                                                isSender: snapshot.data![index]['history'][index1].keys.first == "buyer",
                                                color: snapshot.data![index]['history'][index1].keys.first == "buyer" ? Color(0xFF213C63) : Color(0xFFF5951D),
                                                textStyle: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.white,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 18.sp),
                                                backgroundColor: customerBargainControl.isWaitingForBuyer.value == false ? Color(0xFFF5951D) : Colors.grey),
                                            onPressed: customerBargainControl.isWaitingForBuyer.value == false
                                                ? () {
                                                    context.loaderOverlay.show();
                                                    try {
                                                      CustomerBargainRelated().acceptBargain(snapshot.data![index]['id'].toString()).then((value) {
                                                        var json = jsonDecode(value.responseBody!);
                                                        print(value.responseBody!);
                                                        context.loaderOverlay.hide();
                                                        if (value.serverStatusCode == 200) {
                                                          ScaffoldMessenger.of(context)
                                                              .showSnackBar(SnackBar(content: Text("Great! You can find this product in you cart now.")));
                                                          setState(() {});
                                                        } else if (value.serverStatusCode == 400) {
                                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(json['message'])));
                                                          setState(() {});
                                                        } else {
                                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong.")));
                                                        }
                                                      });
                                                    } catch (e) {
                                                      context.loaderOverlay.hide();
                                                      // TODO
                                                    }
                                                  }
                                                : null,
                                            child: Text(
                                              customerBargainControl.isWaitingForBuyer.value == false ? "ACCEPT OFFER" : "WAITING",
                                              style: TextStyle(color: customerBargainControl.isWaitingForBuyer.value == false ? Colors.white : Colors.grey.shade100,fontSize: 16.sp),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                            style:
                                                ElevatedButton.styleFrom(backgroundColor: Color(0xFF213C63), padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 18.sp)),
                                            onPressed: () {
                                              TextEditingController counterPrice = TextEditingController();
                                              final _formKey = GlobalKey<FormState>();
                                              // counterPrice.text = customerProductDetailControl.totalPrice.value;
                                              showModalBottomSheet<void>(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Padding(
                                                    padding: MediaQuery.of(context).viewInsets,
                                                    child: Container(
                                                      height: Get.height / 3.8,
                                                      color: Colors.white,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(18.0),
                                                        child: Form(
                                                          key: _formKey,
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: <Widget>[
                                                              Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(
                                                                    'Please provide counter price',
                                                                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                  )),
                                                              SizedBox(
                                                                height: 15.sp,
                                                              ),
                                                              CustomTextField(
                                                                controller: counterPrice,
                                                                hintText: 'Counter Price',
                                                                keyBoardType: TextInputType.number,
                                                              ),
                                                              SizedBox(
                                                                height: 15.sp,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 18.sp)),
                                                                    child: Text(
                                                                      'CANCEL',
                                                                      style: TextStyle(fontSize: 16.sp),
                                                                    ),
                                                                    onPressed: () => Navigator.pop(context),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 15.sp,
                                                                  ),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor: Color(0xFFF5951D), padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 18.sp)),
                                                                    child: Text(
                                                                      'REQUEST TO SELLER',
                                                                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                                                    ),
                                                                    onPressed: () {
                                                                      // COUNTER
                                                                      if (_formKey.currentState!.validate()) {
                                                                        context.loaderOverlay.show();
                                                                        try {
                                                                          CustomerBargainRelated()
                                                                              .updateBargainPrice(
                                                                            snapshot.data![index]["id"].toString(),
                                                                            counterPrice.text,
                                                                          )
                                                                              .then((value) {
                                                                            context.loaderOverlay.hide();
                                                                            print(value.responseBody);
                                                                            if (value.serverStatusCode == 200) {
                                                                              Get.back();
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  dismissDirection: DismissDirection.startToEnd,
                                                                                  content: Text("Counter request sent successfully."),
                                                                                ),
                                                                              );
                                                                              setState(() {});
                                                                            }
                                                                          });
                                                                        } catch (e) {
                                                                          // TODO
                                                                          context.loaderOverlay.hide();
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
                                            },
                                            child: Text(
                                              "COUNTER",
                                              style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                      child: Text(
                    "No Requests Found",
                    style: TextStyle(fontSize: 16.sp),
                  ));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
