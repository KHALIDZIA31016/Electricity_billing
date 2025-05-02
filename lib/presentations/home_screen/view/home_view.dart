import 'package:carousel_slider/carousel_slider.dart';
import 'package:electricity_app/core/themes/app_color.dart';
import 'package:electricity_app/core/widgets/text_widget.dart';
import 'package:electricity_app/extensions/size_box.dart';
import 'package:electricity_app/presentations/electric_companies/view/electric_companies_screen.dart';
import 'package:electricity_app/presentations/solar_load_screen/view/solar_load_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import '../../../ads_manager/banner_ads.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/custom_drawer.dart';
import '../../../gen/assets.gen.dart';
import '../../electricity_calculator/view/electricity_calculator_view.dart';
import '../homeTabs/BillsCheckTab/view/bill_checkTab_view.dart';
import '../homeTabs/CalculatorTab/view/CalculatorTab_view.dart';
import '../homeTabs/SolarPanelTab/view/bill_checkTab_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BannerAdController bannerAdController = Get.find<BannerAdController>();

  Future<bool> _onWillPop() async {
    final bool? shouldExit = await PanaraConfirmDialog.show(
      context,
      message: 'Rate Us',
      confirmButtonText: 'Exit App',
      cancelButtonText: 'Rate Us',
      onTapConfirm: () {
        SystemNavigator.pop(); // Exit the app
      },
      onTapCancel: () {
        Navigator.of(context).pop(); // Close the dialog
      },
      panaraDialogType: PanaraDialogType.normal,
      barrierDismissible: true,
      imagePath: Assets.appIcon.path
    );

    return shouldExit ?? false; // If dialog is canceled, return false
  }
  void initState() {
    super.initState();
    // Load banner ad here, if needed
    bannerAdController.loadBannerAd('ad5');
  }
  final screenIndexing = [
    NetMeteringScreen(
      companyName: 'Net Metering',
      url: 'https://roshanpakistan.pk/net_metering/',
    ),
    ElectricCompaniesScreen(),
    SolarLoadView(),

  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Use the async method for handling back buttons
      child: Scaffold(
        bottomNavigationBar: Container(
          width: double.infinity,
          child: bannerAdController.getBannerAdWidget('ad5'), // Display the ad
        ),
        backgroundColor: AppColors.kWhite,
        appBar: PreferredSize(
          preferredSize: Size(0, 70),
          child: CustomAppBar(
            title: 'Electricity Bills',
            borderColor: AppColors.kDarkGreen2,
          ),
        ),
        drawer: CustomDrawer(),
        body: DefaultTabController(
          length: 3,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                20.asHeight,
                // tabBar tabs
                TabBar(
                  labelColor: Colors.black,
                  tabs: [
                    Tab(text: "Bills Check", icon: Image.asset(Assets.bill.path, scale: 12)),
                    Tab(text: "Solar Panels", icon: Image.asset(Assets.solarEnergy.path, scale: 12)),
                    Tab(text: "Calculator", icon: Image.asset(Assets.calculator.path, scale: 16)),
                  ],
                ),
                // tabBar view
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
                CarouselSlider(
                  disableGesture: true,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.56,
                    enlargeCenterPage: true,
                    disableCenter: true,
                    pauseAutoPlayOnTouch: true,
                    autoPlayAnimationDuration: Duration(seconds: 3),
                    autoPlay: true,
                    viewportFraction: 0.75,
                    autoPlayInterval: Duration(seconds: 3),
                  ),
                  items: [
                    {
                      "image": Assets.crashBulb.path,
                      "text": "Net Metering",
                    },
                    {
                      "image": Assets.tableBulb.path,
                      "text": "Electricity bills",
                    },
                    {
                      "image": Assets.ladySolar.path,
                      "text": "Solar load Estimation",
                    },
                  ]
                      .asMap()
                      .entries
                      .map((entry) {
                    int index = entry.key;
                    var item = entry.value;
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the corresponding screen
                            Get.to(screenIndexing[index]);
                          },
                          child: CustomContainer(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                CustomContainer(
                                  height: 340,
                                  bgColor: Colors.grey,
                                  width:
                                  MediaQuery.of(context).size.width,
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
                                  textSize: 16,
                                  textColor: AppColors.kDarker,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  })
                      .toList(),
                ).paddingSymmetric(horizontal: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
