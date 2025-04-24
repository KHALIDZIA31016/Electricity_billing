import 'package:carousel_slider/carousel_slider.dart';
import 'package:electricity_app/core/themes/app_color.dart';
import 'package:electricity_app/core/widgets/text_widget.dart';
import 'package:electricity_app/extensions/size_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/neumorphic_btn.dart';
import '../../../gen/assets.gen.dart';
import '../../electric_companies/view/electric_companies_screen.dart';
import '../homeTabs/BillsCheckTab/view/bill_checkTab_view.dart';
import '../homeTabs/CalculatorTab/view/CalculatorTab_view.dart';
import '../homeTabs/SolarPanelTab/view/bill_checkTab_view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.kWhite,
      appBar: PreferredSize(
        preferredSize: Size(0,70),
        child: CustomAppBar(
          title: 'Home Screen',
          // bgColor:AppColors.kDarkGreen1,
          borderColor:AppColors.kDarkGreen2,
        ),
      ),
      drawer: Drawer(
        width: 260,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: DrawerHeader(
                  decoration: BoxDecoration(
                    // color: Colors.blue
                  ),
                  child: Column(
                spacing: 10,
                children: [
                  Image.asset(Assets.solarEnergy.path, scale: 6,),
                  regularTextWidget(textTitle: 'Solar Power', textSize: 24, textColor: AppColors.kDarker),
                ],
              )),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: regularTextWidget(textTitle: 'More Apps', textSize: 18, textColor: AppColors.kDarkLighter, fontWeight: FontWeight.w600)
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.verified_sharp),
              title: regularTextWidget(textTitle: 'Version', textSize: 18, textColor: AppColors.kDarkLighter, fontWeight: FontWeight.w600),
              subtitle: regularTextWidget(textTitle: ' 1.1.1', textSize: 18, textColor: AppColors.kDarkLighter, fontWeight: FontWeight.w600)
            )
          ],
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            20.asHeight,
            TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: "Bills Check", icon: Image.asset(Assets.bill.path, scale: 12,)),
                Tab(text: "Solar Panels", icon: Image.asset(Assets.solarEnergy.path, scale: 12,)),
                Tab(text: "Calculator", icon: Image.asset(Assets.calculator.path, scale: 16,)),
              ],
            ),

            SizedBox(
              height: 120,
              child: TabBarView(
                children: [
                  BillsCheckTab(),
                  SolarPanelsTab(),
                  CalculatorTab(),
                ],
              ),
            ),
            // check elegibility text
            // CustomContainer(
            //   margin: EdgeInsets.symmetric(horizontal: 16),
            //   height: 50, width: double.infinity,
            //   borderRadius: BorderRadius.circular(16),
            //   bgColor: Colors.grey.shade300,
            //   ontap: (){
            //     Get.to(ElectricCompaniesScreen());
            //   },
            //   child: Center(
            //   child: regularTextWidget(
            //     textTitle: 'Check your Electricity Company here',
            //     textSize: 18, textColor: Colors.black87,
            //     spreadRadius: 10,
            //     offset: Offset(1.7, 2),
            //     blurRadius: 10,
            //     shadowColor: Colors.grey.shade700,
            //     fontWeight: FontWeight.w600
            //   )),
            // ),

            // Inside your build method:
            CarouselSlider(
              disableGesture: true,
              options: CarouselOptions(
                height: 400,
                enlargeCenterPage: true,
                disableCenter: true,
                // enlargeFactor: 0.34,
                pauseAutoPlayOnTouch: true,
                autoPlayAnimationDuration: Duration(seconds: 3),
                autoPlay: true,
                viewportFraction: 0.7,
                aspectRatio: 16 / 9,
                autoPlayInterval: Duration(seconds: 3),
                // reverse: true,
              ),
              items: [
                {
                  "image": Assets.crashBulb.path,
                  "text": "Save Electricity for later",
                },
                {
                  "image": Assets.tableBulb.path,
                  "text": "Turn off appliances not in use",
                },
                {
                  "image": Assets.ladySolar.path,
                  "text": "Track your electricity usage",
                },
              ].map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return CustomContainer(
                      // height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          CustomContainer(
                            height: 360,
                            bgColor: Colors.grey,
                            width: MediaQuery.of(context).size.width,
                            borderRadius: BorderRadius.circular(16),
                            decorationImage: DecorationImage(
                              image: AssetImage(item['image']!),
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(height: 8),
                          regularTextWidget(
                            textTitle: item['text']!,
                              textAlign: TextAlign.center,
                              textSize: 16, textColor: AppColors.kDarker,
                              fontWeight: FontWeight.w400
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ).paddingSymmetric(horizontal: 24, vertical: 10),
          ],
        ),
      ),
    );
  }
}
