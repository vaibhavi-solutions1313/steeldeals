import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/views/seller/views/gen_widgets/cus_textfield.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';

class Metal {
  final String name;
  final double density;
  final String unit;

  Metal(this.name, this.density, this.unit);
}

final List<Metal> metals = [
  Metal('Steel', 7850, 'kg/m³'),
  Metal('Aluminum', 2700, 'kg/m³'),
  Metal('Copper', 8960, 'kg/m³'),
  Metal('Brass', 8400, 'kg/m³'),
  Metal('Lead', 11340, 'kg/m³'),
  Metal('Gold', 19300, 'kg/m³'),
  Metal(
      'Silver',
      10500,
      ''
          'kg/m³'),
  Metal('Zinc', 7130, 'kg/m³'),
  Metal('Nickel', 8800, 'kg/m³'),
  Metal('Platinum', 21400, 'kg/m³'),
  Metal('Titanium', 4500, 'kg/m³'),
  Metal('Iron', 7870, 'kg/m³'),
  Metal('Tungsten', 19300, 'kg/m³'),
  Metal('Magnesium', 1740, 'kg/m³'),
  Metal('Mercury', 13595, 'kg/m³'),
  Metal('Tin', 7310, 'kg/m³'),
  Metal('Cobalt', 8900, 'kg/m³'),
  Metal('Chromium', 7190, 'kg/m³'),
  Metal('Molybdenum', 10220, 'kg/m³'),
];

class MetalWeightCalculator extends StatefulWidget {
  @override
  _MetalWeightCalculatorState createState() => _MetalWeightCalculatorState();
}

class _MetalWeightCalculatorState extends State<MetalWeightCalculator> {
  final weightController = TextEditingController();
  String selectedMetal = 'Steel';
  double result = 0.0;

  void calculateWeight() {
    final metal = metals.firstWhere((element) => element.name == selectedMetal);
    setState(() {
      final weight = double.tryParse(weightController.text) ?? 0.0;
      result = weight * metal.density;
    });
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SimpleAppBar("Metal Weight Calculator"),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300, width: 1), borderRadius: BorderRadius.circular(8)),
                  child: DropdownButton<String>(
                    menuMaxHeight: Adaptive.h(50),
                    underline: Row(),
                    isExpanded: true,
                    hint: Text("Select Metal"),
                    borderRadius: BorderRadius.circular(8),
                    focusColor: Colors.orangeAccent,
                    value: selectedMetal,
                    onChanged: (value) {
                      setState(() {
                        selectedMetal = value!;
                      });
                    },
                    items: metals.map((metal) {
                      return DropdownMenuItem<String>(
                        value: metal.name,
                        child: Text(
                          metal.name,
                          style: TextStyle(color: Colors.black.withOpacity(0.65), fontSize: 16.sp),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16.0),
                CustomTextField(
                  controller: weightController,
                  hintText: "Weight (kg/m³)",
                  keyBoardType: TextInputType.number,
                ),
                SizedBox(height: 16.0),
                Text(
                  'Result: $result ${metals.firstWhere((element) => element.name == selectedMetal).unit}',
                  style: TextStyle(fontSize: 18.0.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: calculateWeight,
                  style: TextButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 12.sp), backgroundColor: Color(0xFFF5951D)),
                  child: Text(
                    'CALCULATE',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.sp, letterSpacing: 0.8),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0.sp),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 10.sp),
                    decoration: BoxDecoration(color: Colors.orangeAccent.withOpacity(0.25), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outlined,
                          color: Colors.black.withOpacity(0.7),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: Text(
                            "The metal weight calculator calculates the weight of metal objects based on their dimensions and density.",
                            style: TextStyle(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w600, fontSize: 15.sp),
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
