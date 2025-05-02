import 'package:electricity_app/core/widgets/text_widget.dart';
import 'package:electricity_app/presentations/home_screen/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../gen/assets.gen.dart';
import '../controller/splash_control.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Stack(
        children: [
          CustomContainer(
            ontap: ()  {
                // Show ad before navigation
            },
            decorationImage: DecorationImage(image: AssetImage(Assets.splash.path), fit: BoxFit.fill),
          ),
          Positioned(
              bottom: 42,
              left: 120,
              child: GestureDetector(
                  onTap: ()   async {
                    await controller.onGetStartedPressed();
                    Get.to(HomeScreen());
                  },
                  child: regularTextWidget(
                      textTitle: 'Get Started',
                      textSize: 24,
                      textColor: Colors.amber,
                      fontWeight: FontWeight.w700
                  )
              )
          ),
        ],
      ),
    );
  }
}

