import 'package:electricity_app/presentations/electric_companies/view/electric_companies_screen.dart';
import 'package:electricity_app/presentations/solar_load_screen/view/solar_load_view.dart';
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
      // home: ElectricCompaniesScreen(),
      initialRoute: AppRoutes.splashScreen,
      getPages: AppRoutes.routes,
    );}
}
