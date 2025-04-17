import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/widgets/neumorphic_btn.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../electric_companies/view/electric_companies_screen.dart';

class SolarPanelsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: NeumorphicButton(
        text: "Solar Panels Estimation",
        imagePath: Assets.highVolt.path, // Replace with your actual image path
        onTap: () {
          Get.to(ElectricCompaniesScreen());
        },
      ),
    );
  }
}