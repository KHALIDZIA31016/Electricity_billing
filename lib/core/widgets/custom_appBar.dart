import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.bgColor,
    required this.borderColor, // Added this parameter for the border color
  }) : super(key: key);

  final String title;
  final Color bgColor;
  final Color borderColor; // New property for the bottom border color

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(16), bottomLeft: Radius.circular(16)),
        border: Border(
          bottom: BorderSide(color: borderColor, width: 2), // Bottom border
        ),
      ),
      child: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent, // Make AppBar transparent to show the border
        leading: IconButton(onPressed: (){
          Get.back();
        } ,icon: Icon(Icons.arrow_circle_left, color: Colors.black38,),),
        title: Text(
          title,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
        ),
        actions: [
          // PopupMenuItem(child: Icon(Icons.more_vert, color: Colors.black, size: 24,)),
          GestureDetector(
              onTap: (){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text('Change the  theme',))));
              },
              child: Icon(Icons.sunny_snowing, size: 24,))
        ],
        elevation: 0, // Remove shadow for a cleaner look
      ),
    );
  }
}