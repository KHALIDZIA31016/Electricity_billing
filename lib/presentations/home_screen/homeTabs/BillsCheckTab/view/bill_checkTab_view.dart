import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/widgets/neumorphic_btn.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../electric_companies/view/electric_companies_screen.dart';

class BillsCheckTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: NeumorphicButton(
        text: "Electricity Bills",
        imagePath: Assets.bill.path, // Replace with your actual image path
        onTap: () {
          Get.to(ElectricCompaniesScreen());
        },
      ),

    );
  }
}