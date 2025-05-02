// import 'package:electricity_app/core/widgets/text_widget.dart';
// import 'package:electricity_app/extensions/size_box.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../ads_manager/banner_ads.dart';
// import '../../../core/themes/app_color.dart';
// import '../../../core/widgets/custom_appBar.dart';
// import '../../../core/widgets/custom_container.dart';
//
// class ResultSolar extends StatefulWidget {
//   final int totalLoad;
//   final int panelsRequired;
//   final int panelCapacity;
//   final List<int> enteredQuantities;
//
//   const ResultSolar({
//     super.key,
//     required this.totalLoad,
//     required this.panelsRequired,
//     required this.panelCapacity,
//     required this.enteredQuantities,
//   });
//
//   @override
//   State<ResultSolar> createState() => _ResultSolarState();
// }
//
// class _ResultSolarState extends State<ResultSolar> {
//   final BannerAdController bannerAdController = Get.find<BannerAdController>();
//
//   @override
//   void initState() {
//     super.initState();
//     // Load banner ad here, if needed
//     bannerAdController.loadBannerAd('ad2');
//   }
//
//   @override
//   @override
//   Widget build(BuildContext context) {
//     List<String> titles = [
//       'Tube Light', 'Energy Saver', 'LED bulbs',
//       'TV', 'LED TV', 'Computer', 'Laptop',
//       'Ceiling Fan', 'Stand Fan', 'Split AC', 'Inverter AC',
//       'Freezer', 'Refrigerator', 'Washing Machine',
//       'Iron', 'Water pumps',
//     ];
//
//     assert(titles.length == widget.enteredQuantities.length);
//
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(70),
//         child: CustomAppBar(
//           title: 'Solar Load Result',
//           borderColor: AppColors.kDarkGreen2,
//           leading: IconButton(
//             onPressed: () => Get.back(),
//             icon: const Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         width: double.infinity,
//         child: bannerAdController.getBannerAdWidget('ad2'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header container (Summary)
//               ListView.builder(
//                 shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: 10,
//                   itemBuilder: (context, index){
//                 return CustomContainer(
//                   height: 120,
//                   width: double.infinity,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: Colors.grey.shade300, width: 2),
//                   shadowColor: Colors.grey.shade100,
//                   spreadRadius: 14,
//                   blurRadius: 20,
//                   offset: Offset(-2, 2),
//                   child: InkWell(
//                     onTap: () {
//                       Get.to(
//                         DetailScreen(
//                           totalLoad: widget.totalLoad,
//                           panelsRequired: widget.panelsRequired,
//                           panelCapacity: widget.panelCapacity,
//                           enteredQuantities: widget.enteredQuantities,
//                         ),
//                       );
//                     },
//                     child: Column(
//                       children: [
//                         Wrap(
//                           children: [
//                             regularTextWidget(
//                               textTitle: '🔋 Total Load (in watts):  ',
//                               textSize: 18,
//                               textColor: AppColors.kPineGreen,
//                               fontWeight: FontWeight.w600,
//                             ),
//                             regularTextWidget(
//                               textTitle: '${widget.totalLoad} Watts',
//                               textSize: 18,
//                               textColor: Colors.blue,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ],
//                         ),
//                         const Divider(color: AppColors.kDarkGreen1, indent: 60, endIndent: 60, thickness: 2),
//                         Wrap(
//                           children: [
//                             regularTextWidget(
//                               textTitle: '☀️ Panels Required: ',
//                               textSize: 18,
//                               textColor: AppColors.kPineGreen,
//                               fontWeight: FontWeight.w600,
//                             ),
//                             regularTextWidget(
//                               textTitle: "${widget.panelsRequired} panels",
//                               textSize: 18,
//                               textColor: Colors.blue,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ],
//                         ),
//                         Center(
//                           child: regularTextWidget(
//                             textTitle: " (Each ${widget.panelCapacity} Watts)",
//                             textSize: 16,
//                             textColor: AppColors.kBlack,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//
//               16.asHeight,
//               const Divider(color: AppColors.kDarkGreen1, thickness: 2),
//               16.asHeight,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }
//
// class DetailScreen extends StatelessWidget {
//   final int totalLoad;
//   final int panelsRequired;
//   final int panelCapacity;
//   final List<int> enteredQuantities;
//
//   const DetailScreen({
//     super.key,
//     required this.totalLoad,
//     required this.panelsRequired,
//     required this.panelCapacity,
//     required this.enteredQuantities,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> titles = [
//       'Tube Light', 'Energy Saver', 'LED bulbs',
//       'TV', 'LED TV', 'Computer', 'Laptop',
//       'Ceiling Fan', 'Stand Fan', 'Split AC', 'Inverter AC',
//       'Freezer', 'Refrigerator', 'Washing Machine',
//       'Iron', 'Water pumps',
//     ];
//
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(70),
//         child: CustomAppBar(
//           title: 'Solar Load Details',
//           borderColor: AppColors.kDarkGreen2,
//           leading: IconButton(
//             onPressed: () => Get.back(),
//             icon: const Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//           child: Column(
//             children: [
//               // Display total load and required panels
//               Wrap(children: [
//                 regularTextWidget(
//                   textTitle: '🔋 Total Load (in watts):  ',
//                   textSize: 18,
//                   textColor: AppColors.kPineGreen,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 regularTextWidget(
//                   textTitle: '${totalLoad} Watts',
//                   textSize: 18,
//                   textColor: Colors.blue,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ]),
//               Divider(color: AppColors.kDarkGreen1, indent: 60, endIndent: 60, thickness: 2,),
//               Wrap(children: [
//                 regularTextWidget(
//                   textTitle: '☀️ Panels Required: ',
//                   textSize: 18,
//                   textColor: AppColors.kPineGreen,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 regularTextWidget(
//                   textTitle: "${panelsRequired} panels",
//                   textSize: 18,
//                   textColor: Colors.blue,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ]),
//               Center(
//                 child: regularTextWidget(
//                   textTitle: " (Each ${panelCapacity} Watts)",
//                   textSize: 16,
//                   textColor: AppColors.kBlack,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               16.asHeight,
//               const Divider(color: AppColors.kDarkGreen1, thickness: 2),
//               16.asHeight,
//               // List all items and their entered quantities
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: titles.length,
//                 itemBuilder: (context, index) {
//                   return CustomContainer(
//                     bgColor: AppColors.kEmeraldGreen.withValues(alpha: 0.2),
//                     borderRadius: BorderRadius.circular(16),
//                     margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                     child: ListTile(
//                       dense: true,
//                       title: regularTextWidget(
//                         textTitle: titles[index],
//                         textSize: 16,
//                         textColor: AppColors.kBlack,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       trailing: regularTextWidget(
//                         textTitle: '${enteredQuantities[index]}',
//                         textSize: 16,
//                         textColor: AppColors.kSoftBlack,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
