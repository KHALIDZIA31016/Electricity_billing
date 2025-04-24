import 'package:electricity_app/extensions/size_box.dart';
import 'package:electricity_app/presentations/electricity_calculator/view/show_result_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/app_color.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../gen/assets.gen.dart';

class AppliancesScreen extends StatefulWidget {
  const AppliancesScreen({super.key});

  @override
  _AppliancesScreenState createState() => _AppliancesScreenState();
}

class _AppliancesScreenState extends State<AppliancesScreen> {
  // List to store results dynamically
  List<Map<String, dynamic>> results = [];

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> devicesTitle = [

      {'name': 'Refrigerator', 'image': Assets.refrigerator.path},
      {'name': 'Freezer', 'image': Assets.freezer.path},
      {'name': 'Washing Machine', 'image': Assets.mahine.path},
      {'name': 'Television', 'image': Assets.tv.path},
      {'name': 'Water Pump', 'image': Assets.pump.path},
      {'name': 'Electric Iron', 'image': Assets.iron.path},
      {'name': 'Electric Fans', 'image': Assets.coffeeMaker.path},
      {'name': 'Electric Heater', 'image': Assets.airCoolerPng.path},
      {'name': 'Electric Geyser', 'image': Assets.geyser.path},
      {'name': 'Electric Light', 'image': Assets.light.path},
      {'name': 'Microwave Oven', 'image': Assets.microwave.path},
      {'name': 'Air Conditioner', 'image': Assets.ac.path},
      {'name': 'Cloth Dryer', 'image': Assets.dryer.path},
      {'name': 'Air Cooler', 'image': Assets.airCoolerPng.path},
      {'name': 'Computer/Laptop', 'image': Assets.laptop.path},
      {'name': 'Printer', 'image': Assets.printer.path},
      {'name': 'Coffee Maker', 'image': Assets.coffeeMaker.path},
      {'name': 'DishWasher', 'image': Assets.dishwasher.path},
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 70),
        child: CustomAppBar(
          title: 'Electricity consumption calculator',
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
      bottomSheet: CustomContainer(
        height: 50, width: double.infinity,
        bgColor: AppColors.kDarkGreen1,
        ontap: (){
          Get.to(ShowResult(results: results));
        },
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        borderRadius: BorderRadius.circular(16),
        // shadowColor: Colors.grey,
        offset: Offset(1.4, 2.4),
        child: Center(child: regularTextWidget(
            textTitle: 'Show results', textSize: 18,
            textColor: AppColors.kWhite)),
      ),
      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                itemCount: devicesTitle.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // mainAxisSpacing: 4,
                  // crossAxisSpacing: 4,
                  childAspectRatio: 3 / 2.6,
                ),
                itemBuilder: (context, index) {
                  return CustomContainer(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    height: 146,
                    width: 320,
                    ontap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          int selectedWatt1 = 100;
                          int quantity = 1;
                          int dailyUsage = 1;
          
                          TextEditingController wattController = TextEditingController();
                          TextEditingController quantityController = TextEditingController();
                          TextEditingController usageController = TextEditingController();
          
                          List<int> wattOptions = List.generate(30, (index) => (index + 1) * 100); // 100, 200, ..., 3000
          
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                content: CustomContainer(
                                  width: 300,
                                  height: 344,
                                  child: Column(
                                    children: [
                                      // Header Title
                                      CustomContainer(
                                        width: double.infinity,
                                        height: 46,
                                        bgColor: AppColors.kDarkGreen1,
                                        borderRadius: BorderRadius.circular(16),
                                        child: Center(
                                          child: regularTextWidget(
                                            textTitle: devicesTitle[index]['name'],
                                            textSize: 16,
                                            textColor: AppColors.kWhite,
                                          ),
                                        ),
                                      ),
          
                                      SizedBox(height: 12),
          
                                      // First Container: Power Input and Dropdown
                                      CustomContainer(
                                        height: 88,
                                        bgColor: Colors.blue.shade500,
                                        borderRadius: BorderRadius.circular(16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 12, top: 8),
                                              child: regularTextWidget(
                                                textTitle: 'Enter power',
                                                textSize: 16,
                                                textColor: AppColors.kWhite,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    controller: wattController,
                                                    keyboardType: TextInputType.number,
                                                    decoration: const InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: 'e.g. 500',
                                                      contentPadding: EdgeInsets.all(12),
                                                    ),
                                                    onChanged: (value) {
                                                      int? parsed = int.tryParse(value);
                                                      if (parsed != null) {
                                                        selectedWatt1 = parsed;
                                                      }
                                                    },
                                                  ),
                                                ),
                                                Text(
                                                  'Watts',
                                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white, size: 30),
                                                  onPressed: () async {
                                                    int? selectedValue = await showDialog<int>(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: SizedBox(
                                                            width: 200,
                                                            height: 200,
                                                            child: ListView(
                                                              children: [100, 1000, 2000, 3000, 5000].map((value) {
                                                                return ListTile(
                                                                  title: Text('$value Watts'),
                                                                  onTap: () => Navigator.pop(context, value),
                                                                );
                                                              }).toList(),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                    if (selectedValue != null) {
                                                      setState(() {
                                                        selectedWatt1 = selectedValue;
                                                        wattController.text = selectedValue.toString(); // Only number
                                                        wattController.selection = TextSelection.fromPosition(
                                                          TextPosition(offset: wattController.text.length),
                                                        );
                                                      });
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      CustomContainer(
                                        height: 56,
                                        bgColor: Colors.blue.shade500,
                                        borderRadius: BorderRadius.circular(16),
                                        // margin: EdgeInsets.symmetric(vertical: 8),
                                        child: TextField(
                                          controller: quantityController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Enter Quantity',
                                            contentPadding: EdgeInsets.all(12),
                                          ),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            setState(() {
                                              quantity = int.tryParse(value) ?? 1;
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      // Third Container: Daily Usage Input
                                      CustomContainer(
                                        height: 56,
                                        bgColor: Colors.blue.shade500,
                                        borderRadius: BorderRadius.circular(16),
                                        // margin: EdgeInsets.symmetric(vertical: 8),
                                        child: TextField(
                                          controller: usageController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Enter Daily Usage (hours)',
                                            contentPadding: EdgeInsets.all(12),
                                          ),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            setState(() {
                                              int parsed = int.tryParse(value) ?? 1;
                                              dailyUsage = parsed;
                                              usageController.text = '$parsed hrs';
                                              usageController.selection = TextSelection.fromPosition(
                                                TextPosition(offset: usageController.text.length),
                                              );
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      // Save Button
                                      SizedBox(
                                        height: 46, width: double.infinity,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor: WidgetStatePropertyAll(AppColors.kDarkGreen1),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(16),
                                                  ))),
                                          onPressed: () {
                                            double energy = (selectedWatt1 * dailyUsage * quantity) / 1000;
                                            setState(() {
                                              results.add({
                                                'title': devicesTitle[index]['name'],
                                                'wattage': selectedWatt1,
                                                'quantity': quantity,
                                                'dailyUsage': dailyUsage,
                                                'energy': energy,
                                              });
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: regularTextWidget(textTitle: 'Save', textSize: 18, textColor: AppColors.kWhite),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              );
                            },
                          );
                        },
                      );
                    },
          
                    borderRadius: BorderRadius.circular(10),
                    bgColor: AppColors.kDarkGreen1,
                    child: Center(
                        child: Column(
                          // spacing: 20,
                          children: [
                            10.asWidth,
                            CustomContainer(
                              height: 80, width: 90,
                              bgColor: Colors.grey.shade300,
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              borderRadius: BorderRadius.circular(10),
                             shadowColor: Colors.black54,
                              offset: Offset(-3.0, 3.0),
                              blurRadius: 10,
                              child: Image.asset(devicesTitle[index]['image']),
                            ),
                            10.asHeight,

                            regularTextWidget(
                                textTitle: devicesTitle[index]['name'], textSize: 16, textColor: AppColors.kWhite
                                , fontWeight: FontWeight.w600),
                          ],
                        )),
                  );
                },
              ),
              70.asHeight,
            ],
          ),
        ),
      ),

    );
  }
}



