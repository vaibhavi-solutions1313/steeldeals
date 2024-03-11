import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/constants.dart';
import 'package:services_provider_application/modules/counter_offer/counter_offer_controller.dart';
import 'package:services_provider_application/views/seller/views/gen_widgets/cus_textfield.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';

import '../../apis/buyer/product_apis.dart';

class CounterOfferView extends StatelessWidget {
  final String productId;
  final String productName;
  final String stockId;
  final List sizes;
  CounterOfferView({Key? key, required this.productId, required this.stockId, required this.sizes, required this.productName}) : super(key: key);
  CounterOfferController controller = Get.put(CounterOfferController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SimpleAppBar('Counter Offer'),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 18),
              children: [
                Text(
                  'Product '+productName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.75)),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Stock ID - $stockId",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.75)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Available Sizes -",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.75)),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: List.generate(
                    sizes.length,
                    (index) => ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        color: Colors.grey.shade200,
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Text(
                          sizes[index]['size'],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Quantity",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.75)),
                ),
                SizedBox(
                  height: 4,
                ),
                CustomTextField(
                  hintText: "Quantity",
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Amount",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 4,
                ),
                CustomTextField(
                  hintText: "Counter Amount",
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    BuyerProductApis().counterPrice(productId, stockId, 'sizeId', controller.price.text, controller.quantity.text);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Constants.primaryButtonColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Counter",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Gilroy",
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.14,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
