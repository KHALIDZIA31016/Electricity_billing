import 'package:electricity_app/core/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../extensions/size_box.dart';
import '../../../gen/assets.gen.dart';
import '../../air_conditioner/view/air_conditioner.dart';
import '../../battery_life_view/battery_life_view.dart';
import '../../solar_load_screen/view/solar_load_view.dart';
import '../../solar_plant/view/solar_plant_view.dart';
import '../../water_pump/view/water_pump.dart';
import 'appliances_screen_view.dart';

class ElectricityCalculator extends StatelessWidget {
  ElectricityCalculator({super.key});
  List<Map<String, dynamic>> results = [];
  final List<String> namesTitle = [
    'Home Generator Design',
    'Solar Plant',
    'Required Solar',
    'Battery Life',
    'Air Conditioner Size',
    'Water Pump',
    'Net Metering',
  ];

  final List<String> subTitle = [
    '17 appliances record',
    'Required data to calculate',
    'Required data to calculate',
    'Required data to calculate',
    'Required data to calculate',
    'Required data to calculate',
    'Internet required to find',
  ];

  final List<String> images = [
    Assets.generator.path,
    Assets.solarEnergy.path,
    Assets.solarEnergy.path,
    Assets.battery.path,
    Assets.ac.path,
    Assets.pump.path,
    Assets.metering.path,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: PreferredSize(
        preferredSize: Size(0, 70),
        child: CustomAppBar(
          title: 'Electricity Calculator',
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.kWhite,
              size: 22,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.asHeight,
              Center(
                child: regularTextWidget(
                  textTitle: 'Electricity Supply Companies in Pakistan',
                  textSize: 18,
                  textColor: AppColors.kCharcoal,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: namesTitle.length,
                itemBuilder: (context, index) {
                  return CustomContainer(
                    ontap: () {
                      if (index == 0) {
                        Get.to(AppliancesScreen());
                      } else if(index == 3){
                        Get.to(BatteryLifeCalculator(
                          results: results,
                          title: namesTitle[index], // Pass the selected title
                        ));
                      } else if(index == 1){
                        Get.to(SolarCalculatorScreen());
                      }
                      else if(index == 2){
                        Get.to(SolarLoadView());
                      } else if(index == 4){
                        Get.to(AcSizeCalculatorScreen());
                      }else if(index == 5){
                        Get.to(WaterPumpCalculator());
                      }
                    },
                    margin: EdgeInsets.symmetric(vertical: 10),
                    borderRadius: BorderRadius.circular(16),
                    bgColor: AppColors.kDarkGreen1,
                    // shadowColor: Colors.grey.shade400,
                    // gradient: LinearGradient(
                    //   stops: const [0.0, 0.5,  1.0],
                    //   colors: [
                    //     const Color(0xFF1B5E20),
                    //     // const Color(0xFF388E3C), // A slightly less dark transition
                    //     const Color(0xFF388E3C), // Another slightly less dark transition
                    //     const Color(0xFF1B5E20),
                    //   ],// Keeps the lighter color centered
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    // ),
                    blurRadius: 6,
                    offset: const Offset(2, 4),
                    child: ListTile(
                      dense: true,
                      leading: Image.asset(images[index], scale: 18),
                      title: regularTextWidget(
                        textTitle: namesTitle[index],
                        textSize: 18,
                        textColor: AppColors.kWhite,
                        fontWeight: FontWeight.w500,
                      ),
                      subtitle: regularTextWidget(
                        textTitle: subTitle[index],
                        textSize: 14,
                        textColor: AppColors.kWhite,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.kOffWhiteGrey,
                        size: 18,
                      ),
                    ),
                  );
                },
              ),
              24.asHeight,
            ],
          ),
        ),
      ),
    );
  }
}


