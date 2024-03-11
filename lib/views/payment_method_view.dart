  import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/extra/card_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';

import '../constants.dart';
import '../controllers/payment_method_controller.dart';
import 'order_details_view.dart';

final paymentMethodControl = Get.put(PaymentMethodController());

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({Key? key}) : super(key: key);

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SimpleAppBar('Payment Method'),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CreditCard(
                    cardNumber: "5450 7879 4864 7854",
                    cardExpiry: "10/25",
                    cardHolderName: "Card Holder",
                    cvv: "456",
                    bankName: "Axis Bank",
                    cardType: CardType.visa,
                    // Optional if you want to override Card Type
                    showBackSide: false,
                    frontBackground: Container(
                      color: const Color(0xFFDA9478),
                    ),
                    backBackground: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: const Color(0xFFDA9478),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    showShadow: false,
                    textExpDate: 'Exp. Date',
                    textName: 'Name',
                    textExpiry: 'MM/YY'),
              ),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (v) {}),
                  const Text('simply dummy text of the printing.')
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                child: Text(
                  'Card Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                color: const Color(0xFFF2F2F2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Card Holder Name',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(15)),
                        child: const TextField(
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Card Holder Name',
                            hintStyle: TextStyle(fontSize: 16),
                            border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Card Number',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(15)),
                        child: const TextField(
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Card Number',
                            hintStyle: TextStyle(fontSize: 16),
                            border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'CVV',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0, right: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const TextField(
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'xxx',
                                      hintStyle: TextStyle(fontSize: 16),
                                      border: OutlineInputBorder(
                                        // borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Expiry Date',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const TextField(
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'xx/xx',
                                      hintStyle: TextStyle(fontSize: 16),
                                      border: OutlineInputBorder(
                                        // borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15),
        child: InkWell(
          onTap: () async {
            Get.to(const OrdersDetailView());
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                  color: Constants.primaryButtonColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text('Payment',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
