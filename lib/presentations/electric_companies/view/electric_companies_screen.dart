import 'package:electricity_app/core/widgets/text_widget.dart';
import 'package:electricity_app/extensions/size_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../gen/assets.gen.dart';
import '../../billCheck_screen/view/billCheck_screen.dart';
import '../controller/electric_companies_control.dart';

class ElectricCompaniesScreen extends StatefulWidget {
  ElectricCompaniesScreen({super.key});

  @override
  State<ElectricCompaniesScreen> createState() => _ElectricCompaniesScreenState();
}

class _ElectricCompaniesScreenState extends State<ElectricCompaniesScreen> {
  final ElectricCompanyController controller = Get.put(ElectricCompanyController());

  final List<Map<String, String>> companies = [
    {"name": "Punjab", "image": Assets.mepco.path, "region": "3 Companies"},
    {"name": "Sindh", "image": Assets.fesco.path, "region": "3 companies"},
    {"name": "KPK", "image": Assets.pesco.path, "region": "2 companies"},
    {"name": "Islamabad", "image": Assets.teco.path, "region": "1 company"},
    {"name": "Balochistan", "image": Assets.hesco.path, "region": "1 company"},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          title: 'Companies',
          bgColor: Colors.white,
          borderColor: Colors.grey,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.asHeight,
              CustomContainer(
                height: 50,
                width: double.infinity,
                borderRadius: BorderRadius.circular(16),
                bgColor: Colors.grey.shade400,
                child: Center(
                  child: regularTextWidget(
                    textTitle: 'Electricity Supply Companies in Pakistan',
                    textSize: 18,
                    textColor: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              16.asHeight,
              regularTextWidget(
                textTitle: 'Tap on a company to explore details.',
                textSize: 16,
                textColor: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              20.asHeight,
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: companies.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3/1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final company = companies[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() =>  Companies(region: company["name"]!)); // Replace with the appropriate screen
                    },
                    child: CustomContainer(
                      padding: EdgeInsets.all(12),
                      borderRadius: BorderRadius.circular(16),
                      bgColor: Colors.white,
                          shadowColor: Colors.grey.shade400,
                          blurRadius: 6,
                          offset: Offset(2, 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          12.asHeight,
                          regularTextWidget(
                            textTitle: company["name"]!,
                            textSize: 24,
                            textColor: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          4.asHeight,
                          regularTextWidget(
                            textTitle: company["region"]!,
                            textSize: 18,
                            textColor: Colors.grey.shade600,
                          ),
                        ],
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





