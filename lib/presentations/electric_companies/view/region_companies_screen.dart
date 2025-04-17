// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../core/widgets/custom_container.dart';
// import '../../../core/widgets/text_widget.dart';
// import '../../../extensions/size_box.dart';
// import '../controller/electric_companies_control.dart';
//
// class RegionCompaniesScreen extends StatelessWidget {
//   final String region;
//
//   RegionCompaniesScreen({super.key, required this.region});
//
//   final ElectricCompaniesController controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, String>> selectedCompanies = controller.getCompaniesByRegion(region);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$region Companies'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: GridView.builder(
//           itemCount: selectedCompanies.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 12,
//             crossAxisSpacing: 12,
//             childAspectRatio: 1,
//           ),
//           itemBuilder: (context, index) {
//             final company = selectedCompanies[index];
//             return CustomContainer(
//               padding: const EdgeInsets.all(10),
//               borderRadius: BorderRadius.circular(12),
//               bgColor: Colors.white,
//               shadowColor: Colors.grey.shade300,
//               blurRadius: 5,
//               offset: const Offset(2, 3),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(company["image"]!, height: 50),
//                   10.asHeight,
//                   regularTextWidget(
//                     textTitle: company["name"]!,
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



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../extensions/size_box.dart';
import '../controller/electric_companies_control.dart';

class RegionCompaniesScreen extends StatelessWidget {
  final String region;

  RegionCompaniesScreen({super.key, required this.region});

  final ElectricCompaniesController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> selectedCompanies = controller.getCompaniesByRegion(region);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          title: '$region companies',
          bgColor: Colors.white,
          borderColor: Colors.grey,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: selectedCompanies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final company = selectedCompanies[index];
            return CustomContainer(
              padding: const EdgeInsets.all(10),
              borderRadius: BorderRadius.circular(12),
              bgColor: Colors.white,
              shadowColor: Colors.grey.shade300,
              blurRadius: 5,
              offset: const Offset(2, 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    company["image"]!,
                    height: 100,
                    errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported, color: Colors.red),
                  ),
                  10.asHeight,
                  regularTextWidget(
                    textTitle: company["name"]!,
                    textSize: 16,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

