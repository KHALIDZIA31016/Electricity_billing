import 'package:electricity_app/presentations/splash_screen/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/routes/app_routes.dart';

void main() {
  runApp(const EBillingApp());
}

class EBillingApp extends StatelessWidget {
  const EBillingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen,
      getPages: AppRoutes.routes,
    );}
}
