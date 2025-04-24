//
// import 'package:electricity_app/core/routes/app_routes.dart';
// import 'package:electricity_app/core/themes/app_color.dart';
// import 'package:electricity_app/presentations/electric_companies/view/region_companies_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../core/widgets/custom_appBar.dart';
// import '../../../core/widgets/custom_container.dart';
// import '../../../core/widgets/text_widget.dart';
// import '../../../extensions/size_box.dart';
// import '../../../gen/assets.gen.dart';
// import '../controller/electric_companies_control.dart';
//
// class ElectricCompaniesScreen extends StatelessWidget {
//   ElectricCompaniesScreen({super.key});
//
//   final ElectricCompaniesController controller = Get.put(ElectricCompaniesController());
//
//
//   final List<Map<String, dynamic>> companies = [
//     {"name": "iesco", 'location': 'Islamabad' ,"image": Assets.iesco.path},
//     {"name": "kelectric", 'location': 'Islamabad' ,"image": Assets.kelectric.path},
//     {"name": "sepco", 'location': 'Islamabad' ,"image": Assets.sepco.path},
//     {"name": "lesco", 'location': 'Islamabad' ,"image": Assets.lesco.path},
//     {"name": "pesco",'location': 'Islamabad' , "image": Assets.pesco.path},
//     {"name": "qesco", 'location': 'Islamabad' ,"image": Assets.qesco.path},
//     {"name": "teco", 'location': 'Islamabad' ,"image": Assets.teco.path},
//     {"name": "gepco", 'location': 'Islamabad' ,"image": Assets.gepco.path},
//     {"name": "fesco", 'location': 'Islamabad' ,"image": Assets.fesco.path},
//
//   ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.kWhite,
//       appBar: PreferredSize(
//         preferredSize: Size(0, 70),
//         child: CustomAppBar(
//           title: 'Electric Companies',
//           leading: IconButton(onPressed: (){
//             Get.back();
//           } ,icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22,),),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               20.asHeight,
//               Center(
//                 child: regularTextWidget(
//                   textTitle: 'Electricity Supply Companies in Pakistan',
//                   textSize: 18,
//                   textColor:   AppColors.kCharcoal,
//                   fontWeight:    FontWeight.w600
//                 ),
//               ),
//
//               20.asHeight,
//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: companies.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 2.6 / 3,
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 12,
//                 ),
//                 itemBuilder: (context, index) {
//                     return CustomContainer(
//                       padding: const EdgeInsets.all(12),
//                       borderRadius: BorderRadius.circular(16),
//                       bgColor: AppColors.kWhite,
//                       shadowColor: Colors.grey.shade400,
//                       blurRadius: 6,
//                       offset: const Offset(2, 4),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset(companies[index]['image'] ,scale: 3,),
//                           10.asHeight,
//                           regularTextWidget(
//                             textTitle: companies[index]['name'],
//                             textSize: 20,
//                             textColor: AppColors.kBlack0D.withOpacity(0.8),
//                             fontWeight: FontWeight.w600,
//                             blurRadius: 10,
//                             spreadRadius: 4,
//                             shadowColor: AppColors.kDark,
//                             offset: Offset(1.2, 2)
//                           ),
//                           regularTextWidget(
//                             textTitle: companies[index]['location'],
//                             textSize: 14,
//                             textColor:  Colors.blue,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ],
//                       ));
//                 },
//               ),
//               24.asHeight,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:electricity_app/core/themes/app_color.dart';
import 'package:electricity_app/core/widgets/custom_appBar.dart';
import 'package:electricity_app/core/widgets/custom_container.dart';
import 'package:electricity_app/core/widgets/text_widget.dart';
import 'package:electricity_app/extensions/size_box.dart';
import 'package:electricity_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controller/electric_companies_control.dart';

class ElectricCompaniesScreen extends StatelessWidget {
  ElectricCompaniesScreen({super.key});

  final ElectricCompaniesController controller = Get.put(ElectricCompaniesController());

  final List<Map<String, dynamic>> companies = [
    {"name": "iesco", 'location': 'Islamabad', "image": Assets.iesco.path,
      "url": "https://bill.pitc.com.pk/iescobill"},


    {"name": "sepco", 'location': 'Sukkur', "image": Assets.sepco.path,
      "url": "https://bill.pitc.com.pk/sepcobill"},

    {"name": "lesco", 'location': 'Lahore', "image": Assets.lesco.path,
      "url": "https://bill.pitc.com.pk/lescobill"},

    {"name": "pesco", 'location': 'Peshawar', "image": Assets.pesco.path,
      "url": "https://bill.pitc.com.pk/pescobill"},

    {"name": "qesco", 'location': 'Quetta', "image": Assets.qesco.path,
      "url": "https://bill.pitc.com.pk/qescobill"},

    {"name": "teco", 'location': 'Tribal Areas', "image": Assets.teco.path,
      "url": "https://bill.pitc.com.pk/tescobill"},

    {"name": "gepco", 'location': 'Gujranwala', "image": Assets.gepco.path,
      "url": "https://bill.pitc.com.pk/gepcobill"},

    {"name": "fesco", 'location': 'Faisalabad', "image": Assets.fesco.path,
      "url": "https://bill.pitc.com.pk/fescobill"},

    {"name": "mepco", 'location': 'Faisalabad', "image": Assets.mepco.path,
      "url": "https://bill.pitc.com.pk/mepcobill"},

    {"name": "hesco", 'location': 'Faisalabad', "image": Assets.hesco.path,
      "url": "https://bill.pitc.com.pk/hescobill"},

    {"name": "kelectric", 'location': 'Karachi', "image": Assets.kelectric.path,
      "url": "https://staging.ke.com.pk:24555/"},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          title: 'Electric Companies',
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.asHeight,
              Center(
                child: regularTextWidget(
                  textTitle: 'Electricity Supply Companies in Pakistan',
                  textSize: 18,
                  textColor: AppColors.kCharcoal,
                  fontWeight: FontWeight.w600,
                ),
              ),
              20.asHeight,
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: companies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.6 / 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final company = companies[index];
                  return CustomContainer(
                    ontap: () {
                      Get.to(() => WebViewScreen(url: company["url"]));
                    },
                    padding: const EdgeInsets.all(12),
                    borderRadius: BorderRadius.circular(16),
                    bgColor: AppColors.kWhite,
                    shadowColor: Colors.grey.shade400,
                    blurRadius: 6,
                    offset: const Offset(2, 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(company['image'], scale: 3),
                        10.asHeight,
                        regularTextWidget(
                          textTitle: company['name'],
                          textSize: 20,
                          textColor: AppColors.kBlack0D.withOpacity(0.8),
                          fontWeight: FontWeight.w400,
                          // blurRadius: 10,
                          // spreadRadius: 4,
                          // shadowColor: AppColors.kDark,
                          // offset: const Offset(1.2, 2),
                        ),
                        regularTextWidget(
                          textTitle: company['location'],
                          textSize: 14,
                          textColor: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  );
                },
              ),
              24.asHeight,
            ],
          ),
        ),
      ),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (url) {
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          title: 'Check Online Bill',
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
          ),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}



