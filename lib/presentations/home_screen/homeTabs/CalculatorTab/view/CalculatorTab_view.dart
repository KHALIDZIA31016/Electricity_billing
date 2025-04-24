import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/widgets/neumorphic_btn.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../electricity_calculator/view/electricity_calculator_view.dart';



class CalculatorTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: NeumorphicButton(
        text: "Electricity Calculator",
        imagePath: Assets.calculator.path, // Replace with your actual image path
        onTap: () {
          Get.to(ElectricityCalculator());
        },
      ),
    );
  }
}