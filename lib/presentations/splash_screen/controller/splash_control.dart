
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("Splash Controller onInit called");
    Future.delayed(const Duration(seconds: 3), () {
      print("Navigating to home...");
      Get.offNamed(AppRoutes.homeScreen);  // You should see this log
    });
  }
}