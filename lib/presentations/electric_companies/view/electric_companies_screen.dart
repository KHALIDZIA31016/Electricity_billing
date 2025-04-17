
import 'package:electricity_app/presentations/electric_companies/view/region_companies_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../extensions/size_box.dart';
import '../../../gen/assets.gen.dart';
import '../controller/electric_companies_control.dart';

class ElectricCompaniesScreen extends StatelessWidget {
  ElectricCompaniesScreen({super.key});

  final ElectricCompaniesController controller = Get.put(ElectricCompaniesController());

  final List<Map<String, String>> companies = [
    {"name": "Punjab", "region": "3 Companies"},
    {"name": "Sindh", "region": "3 Companies"},
    {"name": "KPK",  "region": "2 Companies"},
    {"name": "Islamabad", "region": "1 Company"},
    {"name": "Balochistan", "region": "1 Company"},
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
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
                physics: const NeverScrollableScrollPhysics(),
                itemCount: companies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3 / 1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final company = companies[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => RegionCompaniesScreen(region: company["name"]!));
                    },
                    child: CustomContainer(
                      padding: const EdgeInsets.all(12),
                      borderRadius: BorderRadius.circular(16),
                      bgColor: Colors.white,
                      shadowColor: Colors.grey.shade400,
                      blurRadius: 6,
                      offset: const Offset(2, 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
