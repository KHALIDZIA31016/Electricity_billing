// import 'package:electricity_app/presentations/billCheck_screen/view/billCheck_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../core/themes/app_color.dart';
// import '../../../core/widgets/custom_appBar.dart';
// import '../../../core/widgets/custom_container.dart';
// import '../../../core/widgets/text_widget.dart';
// import '../../../extensions/size_box.dart';
// import '../controller/electric_companies_control.dart';
//
// class RegionCompaniesScreen extends StatelessWidget {
//
//   RegionCompaniesScreen({super.key, });
//
//   final ElectricCompaniesController controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     // final List<Map<String, dynamic>> selectedCompanies = controller.getCompaniesByRegion();
//
//     return Scaffold(
//       backgroundColor: AppColors.kWhite,
//       appBar: PreferredSize(
//         preferredSize: Size(0, 70),
//         child: CustomAppBar(
//           title: 'Electric Companies',
//           leading: IconButton(onPressed: (){
//             Get.back();
//           } ,icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhite, size: 22,),),
//
//         ),
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: GridView.builder(
//           itemCount: 3,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 12,
//             crossAxisSpacing: 12,
//             childAspectRatio: 1,
//           ),
//           itemBuilder: (context, index) {
//             // final company = selectedCompanies[index];
//             return CustomContainer(
//
//               ontap: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       backgroundColor: AppColors.kWhite,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                       title: Center(child: Text("name", style: TextStyle(fontWeight: FontWeight.bold))),
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Image.asset(
//                             "image",
//                             height: 100,
//                             errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported, color: Colors.red),
//                           ),
//                           const SizedBox(height: 20),
//                         Row(
//                           children: [
//                             CustomContainer(
//                               ontap: () {
//                                 Navigator.pop(context);
//                                 Get.to(() => BillCheckScreen(billType: "Domestic"));
//                               },
//                               height: 46, width: 100,
//                               borderRadius: BorderRadius.circular(10),
//                               bgColor: AppColors.kOffWhiteGrey,
//                               shadowColor: AppColors.kDark.withOpacity(.3),
//                               border: Border(
//                                   top: BorderSide(color: AppColors.kDark.withOpacity(0.3)),
//                                   bottom: BorderSide(color: AppColors.kDark.withOpacity(0.3),
//                                   )),
//                               child:  Center(
//                                   child: regularTextWidget(textTitle: 'Domestic Bill',
//                                       textSize: 16, textColor: AppColors.kDarker)),
//                             ),
//                             Spacer(),
//                             CustomContainer(
//                               ontap: () {
//                                 Navigator.pop(context);
//                                 Get.to(() => BillCheckScreen(billType: "Industrial"));
//                               },
//                               height: 46, width: 100,
//                               borderRadius: BorderRadius.circular(10),
//                               bgColor: AppColors.kOffWhiteGrey,
//                               shadowColor: AppColors.kDark.withOpacity(.3),
//                               border: Border(
//                                   top: BorderSide(color: AppColors.kDark.withOpacity(0.3)),
//                                   bottom: BorderSide(color: AppColors.kDark.withOpacity(0.3),
//                                   )),
//                               child:  Center(child: regularTextWidget(
//                                   textTitle: 'Industrial Bill', textSize: 16, textColor: AppColors.kDarker)),
//                             ),
//                           ],
//                         ),
//                           const SizedBox(height: 10),
//
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//
//               padding: const EdgeInsets.all(10),
//               borderRadius: BorderRadius.circular(12),
//               bgColor: AppColors.kWhite,
//               shadowColor: Colors.grey.shade300,
//               blurRadius: 5,
//               offset: const Offset(2, 3),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     "image",
//                     height: 100,
//                     errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported, color: Colors.red),
//                   ),
//                   10.asHeight,
//                   regularTextWidget(
//                     textTitle: "name",
//                     textSize: 16,
//                     fontWeight: FontWeight.bold,
//                     textColor: Colors.black,
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
