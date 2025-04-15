import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/app_constant/app_images.dart';
import '../controller/splash_control.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Check your electricity Bills',
              style: TextStyle(color: Colors.black, fontSize: 22),
            ),
            Center(
              child: Container(
                height: 480,
                width: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.bg),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
