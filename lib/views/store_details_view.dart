// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../Utils/constants.dart';
// import '../widgets/simple_app_bar.dart';
// import 'buyer/views/home/cart_view.dart';
//
// class StoreDetailsView extends StatefulWidget {
//   const StoreDetailsView({Key? key}) : super(key: key);
//
//   @override
//   State<StoreDetailsView> createState() => _StoreDetailsViewState();
// }
//
// class _StoreDetailsViewState extends State<StoreDetailsView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /**
//                * ? app bar
//                */
//               const SimpleAppBar('Preview'),
//
//               /**
//                * ? product info
//                */
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             "Angle TMT",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 20,
//                               letterSpacing: 0.20,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             "Price : 777,000.00",
//                             style: TextStyle(
//                               color: Color(0x7f000000),
//                               fontSize: 14,
//                               letterSpacing: 0.14,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           SizedBox(
//                             width: 144,
//                             child: Text(
//                               "simply dummy text of the printing and \ntypesetting industry. text of the ...more",
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(width: 30),
//                       Expanded(
//                         child: Container(
//                           height: 150,
//                           decoration: BoxDecoration(
//                             image: const DecorationImage(
//                                 image:
//                                     NetworkImage('https://picsum.photos/200'),
//                                 fit: BoxFit.cover),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 40,
//                   ),
//                 ],
//               ),
//
//               /**
//                * ? divider and title
//                */
//
//               Column(
//                 children: [
//                   Container(
//                     height: 1,
//                     width: double.infinity,
//                     color: Constants.primaryButtonColor.withOpacity(.1),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: const [
//                         Expanded(
//                           child: Center(
//                             child: Text(
//                               "Store ID",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14,
//                                 letterSpacing: 0.28,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Center(
//                             child: Text(
//                               "Products",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14,
//                                 letterSpacing: 0.28,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Center(
//                             child: Text(
//                               "Size",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14,
//                                 letterSpacing: 0.28,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Center(
//                             child: Text(
//                               "Quantity",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14,
//                                 letterSpacing: 0.28,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Center(
//                             child: Text(
//                               "Rate",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14,
//                                 letterSpacing: 0.28,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: 1,
//                     width: double.infinity,
//                     color: Constants.primaryButtonColor.withOpacity(.1),
//                   ),
//                 ],
//               ),
//
//               /**
//                * ?product total
//                */
//               Column(
//                 children: [
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const Expanded(
//                         child: Center(
//                           child: Text(
//                             "967242",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                               letterSpacing: 0.24,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const Expanded(
//                         child: Center(
//                           child: Text(
//                             "6 m ms \nrounded",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                               letterSpacing: 0.24,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Center(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: const [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                                 child: Text(
//                                   "25*5",
//                                   style: TextStyle(
//                                     color: Color(0xff7b7b7b),
//                                     fontSize: 12,
//                                     letterSpacing: 0.24,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                                 child: Text(
//                                   "35*5",
//                                   style: TextStyle(
//                                     color: Color(0xff7b7b7b),
//                                     fontSize: 12,
//                                     letterSpacing: 0.24,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Center(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(2),
//                                   color: const Color(0xffeaeaea),
//                                 ),
//                                 child: const Padding(
//                                   padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//                                   child: Text(
//                                     "500 ton.",
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 12,
//                                       letterSpacing: 0.24,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(2),
//                                   color: const Color(0xffeaeaea),
//                                 ),
//                                 child: const Padding(
//                                   padding:
//                                       const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                                   child: Text(
//                                     "500 ton.",
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 12,
//                                       letterSpacing: 0.24,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Center(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: const [
//                               Padding(
//                                 padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//                                 child: Text(
//                                   "₹ 500.00",
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12,
//                                     letterSpacing: 0.24,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//                                 child: Text(
//                                   "₹ 500.00",
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12,
//                                     letterSpacing: 0.24,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     height: 1,
//                     width: double.infinity,
//                     color: Constants.primaryButtonColor.withOpacity(.1),
//                   ),
//
//                   /**
//                    * ? total amount
//                    */
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const [
//                           Text(
//                             "Total",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                               letterSpacing: 0.24,
//                             ),
//                           ),
//                           Text(
//                             "₹,782,500.00",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                               letterSpacing: 0.24,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 14),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const [
//                           Text(
//                             "IGST",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                               letterSpacing: 0.24,
//                             ),
//                           ),
//                           Text(
//                             "₹200.00",
//                             textAlign: TextAlign.right,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                               letterSpacing: 0.24,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 14),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const [
//                           Text(
//                             "SGST",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                               letterSpacing: 0.24,
//                             ),
//                           ),
//                           Text(
//                             "₹200.00",
//                             textAlign: TextAlign.right,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                               letterSpacing: 0.24,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 14),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const [
//                           Text(
//                             "CGST",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                               letterSpacing: 0.24,
//                             ),
//                           ),
//                           Text(
//                             "₹200.00",
//                             textAlign: TextAlign.right,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                               letterSpacing: 0.24,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 14),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const [
//                           Text(
//                             "Loading Amount",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                               letterSpacing: 0.24,
//                             ),
//                           ),
//                           Text(
//                             "₹200.00",
//                             textAlign: TextAlign.right,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                               letterSpacing: 0.24,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 14),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const [
//                           Text(
//                             "Tcs",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                               letterSpacing: 0.24,
//                             ),
//                           ),
//                           Text(
//                             "₹200.00",
//                             textAlign: TextAlign.right,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                               letterSpacing: 0.24,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 14),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const [
//                           Text(
//                             "Others",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                               letterSpacing: 0.24,
//                             ),
//                           ),
//                           Text(
//                             "₹200.00",
//                             textAlign: TextAlign.right,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                               letterSpacing: 0.24,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20,),
//                   Container(
//                     width: double.infinity,
//                     height: 1,
//                     color: Constants.primaryButtonColor.withOpacity(.1),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: const [
//                         Text(
//                           "Grand Total",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 15,
//                             letterSpacing: 0.30,
//                           ),
//                         ),
//                         Text(
//                           "₹,782,000.00",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 12,
//                             letterSpacing: 0.24,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     height: 1,
//                     color: Constants.primaryButtonColor.withOpacity(.1),
//                   ),
//                 ],
//               ),
//
//               /**
//                * ? check out button
//                */
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: InkWell(
//                   onTap: () {
//                     // Get.to(() => ShippingDetailView());
//                     Get.to(() => CartView());
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     height: 56,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Constants.primaryButtonColor,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: const [
//                         Text(
//                           "Add to Cart",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontFamily: "Gilroy",
//                             fontWeight: FontWeight.w600,
//                             letterSpacing: 0.14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
