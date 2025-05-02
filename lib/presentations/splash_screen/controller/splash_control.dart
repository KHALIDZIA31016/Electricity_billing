//
// import 'package:get/get.dart';
// import '../../../ads_manager/splash_interstitial.dart';
// import '../../../core/routes/app_routes.dart';
// import '../../home_screen/view/home_view.dart';
//
// class SplashController extends GetxController {
//   final SplashInterstitialAd interstitialAdController = Get.put(SplashInterstitialAd());
//
//   @override
//   void onInit() {
//     super.onInit();
//     interstitialAdController.loadInterstitialAd();
//
//     print("Splash Controller onInit called");
//   }
//   Future<void> showAdAndNavigate() async {
//   // Check if the ad is available and show it
//   await interstitialAdController.checkAndShowAdOnVisit();
//
//   // After the ad is shown, navigate to the HomeScreen
//   Get.to(HomeScreen());
// }
// }


import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../ads_manager/splash_interstitial.dart';
import '../../home_screen/view/home_view.dart';

class SplashController extends GetxController {
  final SplashInterstitialAd interstitialAdController = Get.put(SplashInterstitialAd());

  @override
  void onInit() {
    super.onInit();
    interstitialAdController.loadInterstitialAd();
    print("Splash Controller onInit called");
  }

  Future<void> onGetStartedPressed() async {
    await interstitialAdController.checkAndShowAdOnVisit();
    Get.to(HomeScreen());  // Navigate to HomeScreen after showing the ad
  }
}

