import 'package:carousel_slider/carousel_slider.dart';
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
    print("HomeScreen Loaded");
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 60),
        child: CustomAppBar(
          title: 'Home Screen',
          bgColor: Colors.white,
          borderColor: Colors.grey,
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            20.asHeight,
            // check elegibility text
            CustomContainer(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 50, width: double.infinity,
              borderRadius: BorderRadius.circular(16),
              bgColor: Colors.grey.shade300,
              ontap: (){
                Get.to(ElectricCompaniesScreen());
              },
              child: Center(
              child: regularTextWidget(
                textTitle: 'Check your Electricity Company here',
                textSize: 18, textColor: Colors.black87,
                spreadRadius: 10,
                offset: Offset(1.7, 2),
                blurRadius: 10,
                shadowColor: Colors.grey.shade700,
                fontWeight: FontWeight.w600
              )),
            ),

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
                  "image": Assets.highVolt.path,
                  "text": "Save Electricity for later",
                },
                {
                  "image": Assets.highVolt.path,
                  "text": "Turn off appliances not in use",
                },
                {
                  "image": Assets.electricity.path,
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
                              textSize: 18, textColor: Colors.black87,
                              spreadRadius: 10,
                              offset: Offset(1.7, 2),
                              blurRadius: 10,
                              shadowColor: Colors.grey.shade700,
                              fontWeight: FontWeight.w600
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ).paddingSymmetric(horizontal: 24, vertical: 10),

            // TabBar
            TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: "Bills Check", icon: Icon(Icons.receipt_long)),
                Tab(text: "Solar Panels", icon: Icon(Icons.solar_power)),
                Tab(text: "Calculator", icon: Icon(Icons.calculate)),
              ],
            ),

            // TabBarView wrapped in Expanded to avoid overflow
            Flexible(
              child: TabBarView(
                children: [
                  BillsCheckTab(),
                  SolarPanelsTab(),
                  CalculatorTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
