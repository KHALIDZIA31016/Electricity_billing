import 'package:electricity_app/core/app_constant/app_images.dart';
import 'package:electricity_app/core/widgets/custom_container.dart';
import 'package:electricity_app/core/widgets/text_widget.dart';
import 'package:electricity_app/extensions/size_box.dart';
import 'package:electricity_app/presentations/home_screen/controller/home_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/custom_appBar.dart';
import '../../electric_companies/view/electricCompanies_view.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    print("HomeScreen Loaded");
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(0, 60),
          child: CustomAppBar(
            title: 'Home Screen',
            // bgColor: Colors.deepPurple.shade300,
            bgColor: Colors.white,
            borderColor: Colors.grey,
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CustomContainer(
              height: 260, width: 260,
                ontap: controller.ForElectricCompanies,
                bgColor: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border(
                  bottom: BorderSide(color: Colors.deepPurple.shade100, width: 2)
                ),
              child: Column(
                children: [
                  CustomContainer(
                    height: 200, width: 260,
                    decorationImage: DecorationImage(image:
                    NetworkImage('https://i.ytimg.com/vi/jq4J0bDqmTc/hq720.jpg?sqp=-oaymwE7CK4FEIIDSFryq4qpAy0IARUAAAAAGAElAADIQj0AgKJD8AEB-AH-CYAC0AWKAgwIABABGHIgUCg9MA8=&rs=AOn4CLDY6ATymCnFgFEYeyyDkGLHyCE7jw'),
                        fit: BoxFit.fill
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  20.asHeight,
                  regularTextWidget(
                      textTitle: 'Check your electricity Bills', textSize: 20, textColor: Colors.black87,
                       spreadRadius: 20.7, blurRadius: 0.7, shadowColor: Colors.grey.shade400,
                        offset: Offset(0.8, 1.7), fontWeight: FontWeight.w400
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


