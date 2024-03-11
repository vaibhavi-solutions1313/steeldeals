import 'dart:convert';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../apis/seller/bargain_related.dart';
import '../../../../../main.dart';
import '../../gen_widgets/cus_textfield.dart';

class SellerBargainView extends StatefulWidget {
  const SellerBargainView({Key? key}) : super(key: key);

  @override
  State<SellerBargainView> createState() => _SellerBargainViewState();
}

class _SellerBargainViewState extends State<SellerBargainView> {
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
                        icon: Icon(Icons.arrow_back_rounded,color: Colors.orangeAccent,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: const Align(
                        alignment: Alignment.centerLeft, child: Text("Bargain Requests", style: TextStyle(color: Color(0xFF213C63), fontSize: 21, fontWeight: FontWeight.w700))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Respond to buyers", style: TextStyle(color: Color(0xFF213C63), fontSize: 14, fontWeight: FontWeight.w600))),
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder<List>(
                  future: sellerBargainControl.getBargainList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Color(0xFFF5951D),
                      ));
                    }
                    if (snapshot.hasData) {
                      if(snapshot.data!.length != 0) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(width: 2, color: Colors.grey.shade200),
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
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      title: Text(
                                        snapshot.data![index]['product']['name'],
                                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.85)),
                                      ),
                                      subtitle: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(snapshot.data![index]['type'].toString().capitalize.toString(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Colors.orange)),
                                        ],
                                      ),
                                      childrenPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: List.generate(
                                            snapshot.data![index]['history'].length,
                                                (index1) {
                                              // CHECK WAITING FOR SELLER RESPONSE OR NOT
                                              if (snapshot.data![index]['history'].length - 1 == index1) {
                                                if (snapshot.data![index]['history'][index1].keys.first == "seller") {
                                                  customerBargainControl.isWaitingForBuyer.value = true;
                                                } else {
                                                  customerBargainControl.isWaitingForBuyer.value = false;
                                                }
                                              }
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  snapshot.data![index]['history'][index1].keys.first == "buyer" ? MainAxisAlignment.start : MainAxisAlignment.end,
                                                  children: [
                                                    BubbleSpecialOne(
                                                      text: snapshot.data![index]['history'][index1].keys.first == "buyer"
                                                          ? 'Buyer: ' + cartController.reformattedNumbers(snapshot.data![index]['history'][index1]['buyer'].toString(),true)
                                                          : 'Me: ' + cartController.reformattedNumbers(snapshot.data![index]['history'][index1]['seller'].toString(),true),
                                                      isSender: snapshot.data![index]['history'][index1].keys.first == "seller",
                                                      color: snapshot.data![index]['history'][index1].keys.first == "buyer" ? Color(0xFF213C63) : Color(0xFFF5951D),
                                                      textStyle: TextStyle(
                                                        fontSize: 12,
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: customerBargainControl.isWaitingForBuyer.value == false ? Color(0xFFF5951D) : Colors.grey),
                                                onPressed: customerBargainControl.isWaitingForBuyer.value == false
                                                    ? () {
                                                  context.loaderOverlay.show();
                                                  try {
                                                    SellerBargainRelated().acceptBargain(snapshot.data![index]['id'].toString()).then((value) {
                                                      var json = jsonDecode(value.responseBody!);
                                                      print(value.responseBody!);
                                                      context.loaderOverlay.hide();
                                                      if (value.serverStatusCode == 200) {
                                                        ScaffoldMessenger.of(context)
                                                            .showSnackBar(SnackBar(content: Text("Great! Customer will be happy to buy at this price.")));
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
                                                  style: TextStyle(color: customerBargainControl.isWaitingForBuyer.value == false ? Colors.white : Colors.grey.shade100),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF213C63)),
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
                                                            height: Get.height / 4,
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
                                                                        child: const Text(
                                                                          'Please provide counter price',
                                                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                                                        )),
                                                                    SizedBox(
                                                                      height: 15,
                                                                    ),
                                                                    CustomTextField(
                                                                      controller: counterPrice,
                                                                      hintText: 'Counter Price',
                                                                      keyBoardType: TextInputType.number,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 15,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        ElevatedButton(
                                                                          child: const Text('CANCEL'),
                                                                          onPressed: () => Navigator.pop(context),
                                                                        ),
                                                                        SizedBox(
                                                                          width: 15,
                                                                        ),
                                                                        ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF5951D)),
                                                                          child: const Text(
                                                                            'REQUEST TO BUYER',
                                                                            style: TextStyle(color: Colors.white),
                                                                          ),
                                                                          onPressed: () {
                                                                            // COUNTER
                                                                            if (_formKey.currentState!.validate()) {
                                                                              context.loaderOverlay.show();
                                                                              try {
                                                                                SellerBargainRelated()
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
                                                    style: TextStyle(color: Colors.white),
                                                  )),
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
                      } else {
                        return Center(child: Text("No Requests Found"));
                      }
                    } else {
                      return Center(child: Text("No Requests Found"));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
