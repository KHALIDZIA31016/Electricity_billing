import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:electricity_app/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../gen/assets.gen.dart';
import '../themes/app_color.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {


  Future<void> _openPrivacyPolicy() async {
    final Uri url = Uri.parse(
        "https://privacypolicymuslimapplications.blogspot.com/2020/04/privacy-policy-of-muslim-applications_22.html");
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open the link')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error launching URL: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 260,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  Image.asset(Assets.appIcon.path, scale: 6),
                  regularTextWidget(
                      textTitle: 'Electricity Bills',
                      textSize: 24,
                      textColor: AppColors.kDarker),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Image.asset(Assets.moreApp.path, scale: 18),
            title: regularTextWidget(
                textTitle: 'More Apps',
                textSize: 18,
                textColor: AppColors.kDarkLighter,
                fontWeight: FontWeight.w600),
          ),
          ListTile(
            leading: Image.asset(Assets.rateIcon.path, scale: 18),
            title: regularTextWidget(
                textTitle: 'Rate Us',
                textSize: 18,
                textColor: AppColors.kDarkLighter,
                fontWeight: FontWeight.w600),
          ),
          ListTile(
            leading: Image.asset(Assets.privayIcon.path, scale: 18),
            title: regularTextWidget(
                textTitle: 'Privacy Policy',
                textSize: 18,
                textColor: AppColors.kDarkLighter,
                fontWeight: FontWeight.w600),
            onTap: () {
              Navigator.pop(context);
              _openPrivacyPolicy();},
          ),
          Spacer(),
          ListTile(
            leading: Icon(Icons.verified_sharp),
            title: regularTextWidget(
                textTitle: 'Version',
                textSize: 18,
                textColor: AppColors.kDarkLighter,
                fontWeight: FontWeight.w600),
            subtitle: regularTextWidget(
                textTitle: ' 1.1.1',
                textSize: 18,
                textColor: AppColors.kDarkLighter,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}