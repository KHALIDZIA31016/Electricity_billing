import 'package:electricity_app/extensions/size_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/text_widget.dart';
import '../controller/billCheck_screen.control.dart';


class BillCheckScreen extends StatelessWidget {
  final String billType;
  BillCheckScreen({Key? key, required this.billType}) : super(key: key);

  final controller = Get.put(BillCheckController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: PreferredSize(
        preferredSize: const Size(0, 70),
        child: CustomAppBar(
          title: '$billType Bill',
          leading: IconButton(onPressed: (){
            Get.back();
          } ,icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22,),),

        ),
      ),
      body: Column(
        children: [
          CustomContainer(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            borderRadius: BorderRadius.circular(12),
            height: 240,
            width: double.infinity,
            bgColor: AppColors.kOffWhiteGrey,
            border: Border.all(color: Colors.deepPurple.shade100),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.circle_outlined, color: AppColors.kOliveGreen),
                    label: regularTextWidget(
                      textTitle: 'Enter your Reference no here',
                      textSize: 16,
                      textColor: Colors.grey,
                    ),
                    hintText: 'Reference no',
                  ),
                ).paddingSymmetric(horizontal: 16, vertical: 16),
                const Spacer(),
                CustomContainer(
                  height: 50,
                  width: 240,
                  borderRadius: BorderRadius.circular(16),
                  bgColor: AppColors.kDarkGreen1,
                  child: Center(
                    child: regularTextWidget(
                      textTitle: 'Get Duplicate bill',
                      textSize: 18,
                      textColor: Colors.white,
                    ),
                  ),
                ),
                10.asHeight,
              ],
            ),
          ),
          regularTextWidget(
            textAlign: TextAlign.center,
            textTitle:
            'Please write correct reference number and company you select',
            textSize: 16,
            textColor: Colors.red,
          ).paddingSymmetric(horizontal: 24),
          20.asHeight,

          // Toggle History Section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomContainer(
                height: 50,
                width: 200,
                borderRadius: BorderRadius.circular(16),
                bgColor:AppColors.kDarkGreen1,
                child: Center(
                  child: regularTextWidget(
                    textTitle: 'Searched History',
                    textSize: 18,
                    textColor: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              Obx(
                    () => Switch(
                      activeColor: AppColors.kDarkGreen1,
                  value: controller.showHistory.value,
                  onChanged: controller.toggleHistory,
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16),
          20.asHeight,

          // History Display Area
          Obx(() {
            if (controller.showHistory.value) {
              if (controller.searchHistory.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    regularTextWidget(
                      textTitle: 'Your Previous Searches:',
                      textSize: 16,
                      textColor: Colors.black,
                      fontWeight: FontWeight.bold,
                    ).paddingSymmetric(horizontal: 16),
                    10.asHeight,
                    ...controller.searchHistory.map(
                          (ref) => ListTile(
                        leading: const Icon(Icons.history, color: AppColors.kDarkGreen1,),
                        title: Text(ref),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(
                        onPressed: controller.clearHistory,
                        icon: const Icon(Icons.delete_forever),
                        label: const Text('Delete History'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                      ).paddingAll(12),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: regularTextWidget(
                    textTitle: 'You have no searches before',
                    textSize: 16,
                    textColor: Colors.grey,
                  ),
                );
              }
            } else {
              return Center(
                child: regularTextWidget(
                  textTitle: 'History is Off',
                  textSize: 16,
                  textColor: Colors.grey,
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
