import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:services_provider_application/views/buyer/views/sell_all_views/see_all_products.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';

// import '../../../../Utils/constants.dart';
import '../../../../constants.dart';
import '../../../../main.dart';
import '../subcat_view.dart';

class SeeAllCategoriesView extends StatefulWidget {
  const SeeAllCategoriesView({Key? key}) : super(key: key);

  @override
  State<SeeAllCategoriesView> createState() => _SeeAllCategoriesViewState();
}

class _SeeAllCategoriesViewState extends State<SeeAllCategoriesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SimpleAppBar("Our Categories"),
          Expanded(
            child: Obx(() => GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: .8,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  children: List.generate(catControl.categories.value.length, (index) {
                    String catImgUrl = Constants.baseUrl+catControl.categories[index]['thumb'] ?? "";
                    print('---------thumb---------');
                    print(Constants.baseUrl+catControl.categories[index]['thumb']);
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(18), border: Border.all(width: 1, color: Colors.grey.shade200)),
                        child: InkWell(
                          onTap: () {
                            print('-------SubCatView---------');
                            // Get.defaultDialog(
                            //   title: '',
                            //   content: SizedBox(
                            //     width: 300,
                            //     child: Column(
                            //       children: [
                            //         TextButton(
                            //           style: TextButton.styleFrom(
                            //             padding: const EdgeInsets.symmetric(
                            //                 horizontal: 45, vertical: 12),
                            //             backgroundColor: const Color(0xFFF5951D),
                            //           ),
                            //           onPressed: () {
                            //             Get.back();
                            //             buyerHomeControl.onCategoryPressed();
                            //           },
                            //           child: const Text(
                            //             "ISI-Brand",
                            //             style:
                            //             TextStyle(color: Colors.white),
                            //           ),
                            //         ),
                            //         OutlinedButton(
                            //           style: OutlinedButton.styleFrom(
                            //             padding: const EdgeInsets.symmetric(
                            //                 horizontal: 50),
                            //           ),
                            //           onPressed: () {
                            //             Get.back();
                            //             buyerHomeControl.onCategoryPressed();
                            //           },
                            //           child: const Text(
                            //             "Non-ISI",
                            //             style: TextStyle(
                            //               color: Color(0xFFF5951D),
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // );
                            // controller.onCategoryPressed();
                            if (catControl.categories[index]['subcategory'] != null) {
                              Get.to(()=>
                                SubCatView(
                                  data: catControl.categories[index]['subcategory'],
                                  title: catControl.categories[index]['name'],
                                ),
                              );
                            } else {
                              print('-------DIRECT---------');
                              /// SHOW DIRECT PRODUCT
                              try {
                                context.loaderOverlay.show();
                                customerProductDetailControl.getBuyerProducts(catControl.categories[index]['id'].toString()).then((value) {
                                  context.loaderOverlay.hide();
                                  if (customerProductDetailControl.buyerProductList.length != 0) {
                                    print('-------SeeAllProducts---------');
                                    Get.to(()=>
                                        SeeAllProducts(
                                          catId: catControl.categories[index]['id'].toString(),
                                          catName: catControl.categories[index]['name'].toString(),
                                        ),
                                        transition: Transition.cupertino);
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
                            }
                          },
                          child: Column(
                            children: [
                              Expanded(
                                child: Card(
                                  elevation: 2,
                                  child: FadeInImage(
                                    image: NetworkImage(catImgUrl),
                                    placeholder: AssetImage("assets/ph.jpg"),
                                    imageErrorBuilder: (context, error, stackTrace) {
                                      return Center(child: Image.asset("assets/ph.jpg"));
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  catControl.categories.value[index]['name'].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    letterSpacing: 0.24,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                )),
          )
        ],
      ),
    );
  }
}
