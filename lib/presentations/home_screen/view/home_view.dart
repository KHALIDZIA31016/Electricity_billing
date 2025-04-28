// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:electricity_app/core/themes/app_color.dart';
// import 'package:electricity_app/core/widgets/text_widget.dart';
// import 'package:electricity_app/extensions/size_box.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:panara_dialogs/panara_dialogs.dart';
// import '../../../core/widgets/custom_appBar.dart';
// import '../../../core/widgets/custom_container.dart';
// import '../../../core/widgets/custom_drawer.dart';
// import '../../../gen/assets.gen.dart';
// import '../homeTabs/BillsCheckTab/view/bill_checkTab_view.dart';
// import '../homeTabs/CalculatorTab/view/CalculatorTab_view.dart';
// import '../homeTabs/SolarPanelTab/view/bill_checkTab_view.dart';
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async{
//         PanaraConfirmDialog.show(
//             context,
//             message: 'Rate Us',
//             confirmButtonText: 'Exit App',
//             cancelButtonText: 'Rate US',
//             onTapConfirm: () {
//               SystemNavigator.pop();
//               // Open Play Store URL
//               // launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.example.app")); // Replace with your real package name
//             },
//             onTapCancel: () {
//               Navigator.of(context).pop(); // Close dialog
//               Future.delayed(Duration(milliseconds: 300), () {
//                 // Exit the app
//                 Get.back(); // Close the current screen (or use SystemNavigator.pop())
//               });
//             },
//         panaraDialogType: PanaraDialogType.normal,
//         barrierDismissible: true,
//         );
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor:AppColors.kWhite,
//         appBar: PreferredSize(
//           preferredSize: Size(0,70),
//           child: CustomAppBar(
//             title: 'Electricity Bills ',
//             // bgColor:AppColors.kDarkGreen1,
//             borderColor:AppColors.kDarkGreen2,
//           ),
//         ),
//         drawer: CustomDrawer(),
//         body: DefaultTabController(
//           length: 3,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               20.asHeight,
//               // tabBar tabs
//               TabBar(
//                 labelColor: Colors.black,
//                 tabs: [
//                   Tab(text: "Bills Check", icon: Image.asset(Assets.bill.path, scale: 12,)),
//                   Tab(text: "Solar Panels", icon: Image.asset(Assets.solarEnergy.path, scale: 12,)),
//                   Tab(text: "Calculator", icon: Image.asset(Assets.calculator.path, scale: 16,)),
//                 ],
//               ),
//               // tabBar view
//               SizedBox(
//                 height: 120,
//                 child: TabBarView(
//                   children: [
//                     BillsCheckTab(),
//                     SolarPanelsTab(),
//                     CalculatorTab(),
//                   ],
//                 ),
//               ),
//               40.asHeight,
//               // Slider
//               CarouselSlider(
//                 disableGesture: true,
//                 options: CarouselOptions(
//                   height: MediaQuery.of(context).size.height * 0.56,
//                   enlargeCenterPage: true,
//                   disableCenter: true,
//                   // enlargeFactor: 0.34,
//                   pauseAutoPlayOnTouch: true,
//                   autoPlayAnimationDuration: Duration(seconds: 3),
//                   autoPlay: true,
//                   viewportFraction: 0.7,
//                   aspectRatio: 16 / 9,
//                   autoPlayInterval: Duration(seconds: 3),
//                   // reverse: true,
//                 ),
//                 items: [
//                   {
//                     "image": Assets.crashBulb.path,
//                     "text": "Save Electricity for later",
//                   },
//                   {
//                     "image": Assets.tableBulb.path,
//                     "text": "Turn off appliances not in use",
//                   },
//                   {
//                     "image": Assets.ladySolar.path,
//                     "text": "Track your electricity usage",
//                   },
//                 ].map((item) {
//                   return Builder(
//                     builder: (BuildContext context) {
//                       return CustomContainer(
//                         // height: 300,
//                         width: MediaQuery.of(context).size.width,
//                         child: Column(
//                           children: [
//                             CustomContainer(
//                               height: 340,
//                               bgColor: Colors.grey,
//                               width: MediaQuery.of(context).size.width,
//                               borderRadius: BorderRadius.circular(16),
//                               decorationImage: DecorationImage(
//                                 image: AssetImage(item['image']!),
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             regularTextWidget(
//                               textTitle: item['text']!,
//                                 textAlign: TextAlign.center,
//                                 textSize: 16, textColor: AppColors.kDarker,
//                                 fontWeight: FontWeight.w400
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 }).toList(),
//               ).paddingSymmetric(horizontal: 16)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//


import 'package:carousel_slider/carousel_slider.dart';
import 'package:electricity_app/core/themes/app_color.dart';
import 'package:electricity_app/core/widgets/text_widget.dart';
import 'package:electricity_app/extensions/size_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/custom_drawer.dart';
import '../../../gen/assets.gen.dart';
import '../homeTabs/BillsCheckTab/view/bill_checkTab_view.dart';
import '../homeTabs/CalculatorTab/view/CalculatorTab_view.dart';
import '../homeTabs/SolarPanelTab/view/bill_checkTab_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Use the async method for handling back buttons
      child: Scaffold(
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
              40.asHeight,
              // Slider
              CarouselSlider(
                disableGesture: true,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.56,
                  enlargeCenterPage: true,
                  disableCenter: true,
                  pauseAutoPlayOnTouch: true,
                  autoPlayAnimationDuration: Duration(seconds: 3),
                  autoPlay: true,
                  viewportFraction: 0.7,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: Duration(seconds: 3),
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
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            CustomContainer(
                              height: 340,
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
                              textSize: 16,
                              textColor: AppColors.kDarker,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ).paddingSymmetric(horizontal: 16),
            ],
          ),
        ),
      ),
    );
  }
}
