import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/constants.dart';
import 'package:services_provider_application/controllers/rate_us_controller.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';

class RateUsView extends StatefulWidget {
  const RateUsView({Key? key}) : super(key: key);

  @override
  State<RateUsView> createState() => _RateUsViewState();
}

class _RateUsViewState extends State<RateUsView> {
  final rateUsControl = Get.put(RateUsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SimpleAppBar('Rating'),
              const Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.redAccent,
                    backgroundImage: NetworkImage(
                      'https://picsum.photos/200',
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Rajat Singh',
                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 18),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      '652 - UKW',
                      style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w600, fontSize: 14),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'How is your Service',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(
                    child: Text('Your feedback will help improve driving experience', style: TextStyle(color: Color(0xff8a8a8f), fontSize: 16), textAlign: TextAlign.center),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          rateUsControl.selectedRatingIndex.value = 1;
                        },
                        child: Icon(
                          Icons.star,
                          size: 30,
                          color: rateUsControl.selectedRatingIndex.value >= 1 ? Colors.yellow : Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          rateUsControl.selectedRatingIndex.value = 2;
                        },
                        child: Icon(
                          Icons.star,
                          size: 30,
                          color: rateUsControl.selectedRatingIndex.value >= 2 ? Colors.yellow : Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          rateUsControl.selectedRatingIndex.value = 3;
                        },
                        child: Icon(
                          Icons.star,
                          size: 30,
                          color: rateUsControl.selectedRatingIndex.value >= 3 ? Colors.yellow : Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          rateUsControl.selectedRatingIndex.value = 4;
                        },
                        child: Icon(
                          Icons.star,
                          size: 30,
                          color: rateUsControl.selectedRatingIndex.value >= 4 ? Colors.yellow : Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          rateUsControl.selectedRatingIndex.value = 5;
                        },
                        child: Icon(
                          Icons.star,
                          size: 30,
                          color: rateUsControl.selectedRatingIndex.value >= 5 ? Colors.yellow : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(color: const Color(0xFFEFEFF2), borderRadius: BorderRadius.circular(10)),
                child: const TextField(
                  decoration:
                      InputDecoration(border: InputBorder.none, hintText: 'Additional Comments...', contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15)),
                  maxLines: 4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                child: InkWell(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Constants.primaryButtonColor,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        child: Center(
                          child: Text(
                            'SUBMIT REVIEW',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
