import 'package:carousel_slider/carousel_slider.dart';
import 'package:electricity_app/core/app_constant/app_images.dart';
import 'package:electricity_app/core/widgets/text_widget.dart';
  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_container.dart';
import '../controller/electricCompanies_control.dart';

class ElectricCompaniesScreen extends StatelessWidget {
  ElectricCompaniesScreen({super.key});

  final ElectricCompanyController controller = Get.put(ElectricCompanyController());

  @override
  Widget build(BuildContext context) {

    final List<String> title = [ 'Industrial Bill', 'Domestic Bill'];


    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          title: 'Companies',
          bgColor: Colors.deepPurple.shade200,
          borderColor: Colors.grey.shade200,
        ),
      ),
      body: Center(
        child:  Column(
          children: [
            CustomContainer(
              padding: EdgeInsets.all(12),
              height: 130,
              width: 130,
              ontap: () => showDialog(context: context, builder: (context) {
                return    Dialog(
                  backgroundColor: Colors.grey,
                  child: CustomContainer(
                    height: 260, width: 200,
                    bgColor: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    child: Column(
                      children: [
                        Image.asset(AppImages.bg, scale: 3,),
                        
                        Flexible(
                            child: GridView.builder(
                              itemCount: 2,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  childAspectRatio: 2/1.2
                                ),
                                itemBuilder: (cxt, index){
                                  return CustomContainer(
                                    // height: 10, width: 10, bgColor: Colors.blue,
                                    margin: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                    child: CustomContainer(
                                      borderRadius: BorderRadius.circular(10),
                                      bgColor: Colors.white,
                                      offset: Offset(1.2, 2.9),
                                      border: Border(
                                          bottom: BorderSide(color: Colors.grey.shade300),
                                          top: BorderSide(color: Colors.grey.shade300),
                                      ),
                                      spreadRadius: 10, 
                                      blurRadius: 1.2,
                                      child: Column(
                                        children: [
                                          Icon(Icons.delivery_dining_sharp),
                                          Text(title[index])
                                        ],
                                      ),
                                    ),
                                  );
                                }))
                        
                        
                        
                      ],
                    ),
                  ),
                );
              },),
              bgColor: Colors.blue.shade100,
              decorationImage: DecorationImage(
                image: AssetImage(AppImages.splashBg,),
                fit: BoxFit.scaleDown,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            const SizedBox(height: 10),
            Text(
              'company.name',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
