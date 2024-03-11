import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../main.dart';
import 'sell_all_views/see_all_products.dart';

class SubCatView extends StatefulWidget {
  final dynamic data;
  final String? title;
  const SubCatView({Key? key, this.data, this.title}) : super(key: key);

  @override
  State<SubCatView> createState() => _SubCatViewState();
}

class _SubCatViewState extends State<SubCatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.3,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.orangeAccent,
          ),
        ),
        title: Text(widget.title ?? "NIL", style: TextStyle(fontSize: 18, color: Color(0xFF213C63), fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
        child: Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
            ),
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(18.0),
                //   child: Row(
                //     children: [
                //       Text('${widget.data.length.toString()} Products', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 0.0,
                    childAspectRatio: 1 / 1.5,
                    shrinkWrap: false,
                    padding: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                    children: List.generate(
                      widget.data.length,
                          (index) {
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: InkWell(
                            onTap: () {
                              try {
                                context.loaderOverlay.show();
                                customerProductDetailControl.getBuyerProducts(widget.data[index]['id'].toString()).then((value) {
                                  context.loaderOverlay.hide();
                                  if (customerProductDetailControl.buyerProductList.length != 0) {
                                    Get.to(SeeAllProducts(
                                      catId: widget.data[index]['id'].toString(),
                                      catName: widget.data[index]['name'].toString(),
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text("No Products Found!"),
                                      duration: Duration(seconds: 1),
                                    ));
                                  }
                                });
                              } catch (e) {
                                context.loaderOverlay.hide();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Unable to fetch. retry!"),
                                  duration: Duration(seconds: 1),
                                ));
                                // TODO
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100, borderRadius: BorderRadius.circular(18), border: Border.all(width: 1, color: Colors.grey.shade200)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        child: FadeInImage(
                                          fit: BoxFit.contain,
                                          image: NetworkImage(widget.data[index]['thumb'].toString()),
                                          placeholder: AssetImage("assets/ph.jpg"),
                                          imageErrorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              "assets/ph.jpg",
                                              fit: BoxFit.contain,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(widget.data[index]['name'].toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      widget.data[index]['description'].toString(),
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black54),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
