import 'package:electricity_app/core/widgets/text_widget.dart';
import 'package:electricity_app/extensions/size_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/app_color.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';

class ResultSolar extends StatelessWidget {
  final int totalLoad;
  final int panelsRequired;
  final int panelCapacity;
  final List<int> enteredQuantities; // Store entered quantities

  const ResultSolar({
    super.key,
    required this.totalLoad,
    required this.panelsRequired,
    required this.panelCapacity,
    required this.enteredQuantities,
  });

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      'Tube Light', 'Energy Saver', 'LED bulbs',
      'TV', 'LED TV', 'Computer', 'Laptop',
      'Ceiling Fan', 'Stand Fan', 'Split AC', 'Inverter AC', 'Freezer', 'Refrigerator', 'Washing Machine', 'Iron',
      'Water pumps', //Corrected spelling
    ];

    // Ensure the length of titles and enteredQuantities match
    assert(titles.length == enteredQuantities.length);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          title: 'Solar Load Result',
          borderColor: AppColors.kDarkGreen2,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  regularTextWidget(
                      textTitle: '🔋 Total Load (in watts):  ',
                      textSize: 18,
                      textColor: AppColors.kPineGreen,
                      fontWeight: FontWeight.w600),
                  regularTextWidget(
                      textTitle: '$totalLoad Watts',
                      textSize: 18,
                      textColor: Colors.blue,
                      fontWeight: FontWeight.w600),
                ],
              ),
              Divider(color: AppColors.kDarkGreen1, indent: 60, endIndent: 60, thickness: 2,),
              // const SizedBox(height: 16),
              Wrap(
                children: [
                  regularTextWidget(
                      textTitle: '☀️ Panels Required: ',
                      textSize: 18,
                      textColor: AppColors.kPineGreen,
                      fontWeight: FontWeight.w600),
                  regularTextWidget(
                      textTitle: "$panelsRequired panels",
                      textSize: 18,
                      textColor: Colors.blue,
                      fontWeight: FontWeight.w600),
                ],
              ),

              Center(
                child: regularTextWidget(
                    textTitle: " (Each $panelCapacity Watts)",
                    textSize: 16,
                    textColor: AppColors.kBlack,
                    fontWeight: FontWeight.w600),
              ),

              16.asHeight,
              const Divider(color:AppColors.kDarkGreen1, thickness: 2),
              16.asHeight,
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return CustomContainer(
                    bgColor: AppColors.kEmeraldGreen.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: ListTile(
                      dense: true,
                      title: regularTextWidget(
                          textTitle: titles[index], textSize: 16, textColor: AppColors.kBlack,
                        fontWeight: FontWeight.w600
                      ),
                      trailing: regularTextWidget(
                          textTitle: '${enteredQuantities[index]}', textSize: 16, textColor: AppColors.kSoftBlack,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}