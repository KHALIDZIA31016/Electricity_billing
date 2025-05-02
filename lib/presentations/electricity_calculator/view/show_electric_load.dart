// import 'package:electricity_app/core/themes/app_color.dart';
// import 'package:electricity_app/core/widgets/custom_appBar.dart';
// import 'package:electricity_app/core/widgets/custom_container.dart';
// import 'package:electricity_app/core/widgets/text_widget.dart';
// import 'package:electricity_app/extensions/size_box.dart';
// import 'package:electricity_app/gen/assets.gen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// import '../../../ads_manager/banner_ads.dart';
// import '../../../ads_manager/interstitial_ads.dart';
// import '../../../services/remote_config_service.dart';
// import '../controller/electric_companies_control.dart';
//
// class ElectricCompaniesScreen extends StatefulWidget {
//   ElectricCompaniesScreen({super.key});
//
//   @override
//   State<ElectricCompaniesScreen> createState() => _ElectricCompaniesScreenState();
// }
//
// class _ElectricCompaniesScreenState extends State<ElectricCompaniesScreen> {
//   final interstitialAdController = Get.find<InterstitialAdController>();
//   final BannerAdController bannerAdController = Get.find<BannerAdController>();
//
//   final ElectricCompaniesController controller = Get.put(ElectricCompaniesController());
//   final List<Map<String, dynamic>> companies = [
//     {"name": "IESCO", 'location': 'Islamabad', "image": Assets.iesco.path,
//       "url": "https://bill.pitc.com.pk/iescobill"},
//
//
//     {"name": "SEPCO", 'location': 'Sukkur', "image": Assets.sepco.path,
//       "url": "https://bill.pitc.com.pk/sepcobill"},
//
//     {"name": "LESCO", 'location': 'Lahore', "image": Assets.lesco.path,
//       "url": "https://bill.pitc.com.pk/lescobill"},
//
//     {"name": "PESCO", 'location': 'Peshawar', "image": Assets.pesco.path,
//       "url": "https://bill.pitc.com.pk/pescobill"},
//
//     {"name": "QESCO", 'location': 'Quetta', "image": Assets.qesco.path,
//       "url": "https://bill.pitc.com.pk/qescobill"},
//
//     {"name": "TESCO", 'location': 'Tribal Areas', "image": Assets.teco.path,
//       "url": "https://bill.pitc.com.pk/tescobill"},
//
//     {"name": "GEPCO", 'location': 'Gujranwala', "image": Assets.gepco.path,
//       "url": "https://bill.pitc.com.pk/gepcobill"},
//
//     {"name": "FESCO", 'location': 'Faisalabad', "image": Assets.fesco.path,
//       "url": "https://bill.pitc.com.pk/fescobill"},
//
//     {"name": "MEPCO", 'location': 'Faisalabad', "image": Assets.mepco.path,
//       "url": "https://bill.pitc.com.pk/mepcobill"},
//
//     {"name": "HESCO", 'location': 'Faisalabad', "image": Assets.hesco.path,
//       "url": "https://bill.pitc.com.pk/hescobill"},
//
//     {"name": "K-ELECTRIC", 'location': 'Karachi', "image": Assets.kelectric.path,
//       "url": "https://staging.ke.com.pk:24555/"},
//
//   ];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     interstitialAdController.checkAndShowAdOnVisit();
//     bannerAdController.loadBannerAd('ad4');
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.kWhite,
//       appBar: PreferredSize(
//         preferredSize: Size(0, 70),
//         child: CustomAppBar(
//           title: 'Electric Companies',
//           leading: IconButton(
//             onPressed: () => Get.back(),
//             icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         width: double.infinity,
//         child: bannerAdController.getBannerAdWidget('ad4'), // Display the ad
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
//                   textColor: AppColors.kCharcoal,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
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
//                   final company = companies[index];
//                   return CustomContainer(
//                     ontap: () {
//                       interstitialAdController.checkAndShowAdOnVisit();
//                       Get.to(() => WebViewScreen(url: company["url"], companyName: companies[index]['name'],));
//                     },
//                     padding: const EdgeInsets.all(12),
//                     borderRadius: BorderRadius.circular(16),
//                     bgColor: AppColors.kWhite,
//                     shadowColor: Colors.grey.shade400,
//                     blurRadius: 6,
//                     offset: const Offset(2, 4),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(company['image'], scale: 3),
//                         10.asHeight,
//                         regularTextWidget(
//                           textTitle: company['name'],
//                           textSize: 20,
//                           textColor: AppColors.kBlack0D.withOpacity(0.8),
//                           fontWeight: FontWeight.w400,
//
//                         ),
//                         regularTextWidget(
//                           textTitle: company['location'],
//                           textSize: 14,
//                           textColor: Colors.blue,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ],
//                     ),
//                   );
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
// //
// // class WebViewScreen extends StatefulWidget {
// //   final String url;
// //   final String companyName;
// //
// //   const WebViewScreen({super.key, required this.url, required this.companyName});
// //
// //   @override
// //   State<WebViewScreen> createState() => _WebViewScreenState();
// // }
// //
// // class _WebViewScreenState extends State<WebViewScreen> {
// //   late final WebViewController controller;
// //   bool isLoading = true;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     controller = WebViewController()
// //       ..setJavaScriptMode(JavaScriptMode.unrestricted)
// //       ..setNavigationDelegate(
// //         NavigationDelegate(
// //           onPageStarted: (url) {
// //             setState(() {
// //               isLoading = true;
// //             });
// //           },
// //           onPageFinished: (url) {
// //             setState(() {
// //               isLoading = false;
// //             });
// //           },
// //           onNavigationRequest: (request) {
// //             if (request.url.startsWith('https://www.youtube.com/')) {
// //               return NavigationDecision.prevent;
// //             }
// //             return NavigationDecision.navigate;
// //           },
// //         ),
// //       )
// //       ..loadRequest(Uri.parse(widget.url));
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColors.kWhite,
// //       appBar: PreferredSize(
// //         preferredSize: const Size.fromHeight(70),
// //         child: CustomAppBar(
// //           title:  widget.companyName.toUpperCase(),
// //           leading: IconButton(
// //             onPressed: () => Get.back(),
// //             icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
// //           ),
// //         ),
// //       ),
// //       body: Stack(
// //         children: [
// //           WebViewWidget(controller: controller),
// //           if (isLoading)
// //             const Center(
// //               child: CircularProgressIndicator(),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// //
//
// class WebViewScreen extends StatefulWidget {
//   final String url;
//   final String companyName;
//
//   const WebViewScreen({super.key, required this.url, required this.companyName});
//
//   @override
//   State<WebViewScreen> createState() => _WebViewScreenState();
// }
//
// class _WebViewScreenState extends State<WebViewScreen> {
//   late final WebViewController controller;
//   bool isLoading = true;
//   String? referenceNumber;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadReferenceNumber(); // Load the saved reference number
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (url) {
//             setState(() {
//               isLoading = true;
//             });
//           },
//           onPageFinished: (url) {
//             setState(() {
//               isLoading = false;
//             });
//           },
//           onNavigationRequest: (request) {
//             // Save reference number if the URL contains it
//             if (request.url.contains('ref=')) {
//               Uri uri = Uri.parse(request.url);
//               String? ref = uri.queryParameters['ref'];
//               if (ref != null) {
//                 _saveReferenceNumber(ref); // Save reference number from query parameter
//               }
//             }
//
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(_getInitialUrl())); // Load the initial URL with reference number if available
//   }
//
//   Future<void> _loadReferenceNumber() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     referenceNumber = prefs.getString('reference_number');
//   }
//
//   Future<void> _saveReferenceNumber(String referenceNumber) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('reference_number', referenceNumber);
//   }
//
//   String _getInitialUrl() {
//     String initialUrl = widget.url;
//
//     // Check if there's a saved reference number and append it to the URL
//     if (referenceNumber != null && referenceNumber!.isNotEmpty) {
//       final Uri uri = Uri.parse(initialUrl);
//       final queryParameters = uri.queryParameters;
//       String newUrl = Uri(
//         scheme: uri.scheme,
//         host: uri.host,
//         path: uri.path,
//         queryParameters: {...queryParameters, 'ref': referenceNumber!}, // Include the reference number
//       ).toString();
//       return newUrl;
//     }
//     return initialUrl; // Return original URL if no reference number
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.kWhite,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(70),
//         child: CustomAppBar(
//           title: widget.companyName.toUpperCase(),
//           leading: IconButton(
//             onPressed: () => Get.back(),
//             icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           WebViewWidget(controller: controller),
//           if (isLoading)
//             const Center(child: CircularProgressIndicator()),
//         ],
//       ),
//     );
//   }
// }
