import 'package:electricity_app/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../themes/app_color.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 260,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
                decoration: BoxDecoration(
                  // color: Colors.blue
                ),
                child: Column(
                  spacing: 10,
                  children: [
                    Image.asset(Assets.appIcon.path, scale: 6,),
                    regularTextWidget(textTitle: 'Electricity Bills', textSize: 24, textColor: AppColors.kDarker),
                  ],
                )),
          ),
          ListTile(
              leading: Image.asset(Assets.moreApp.path, scale: 18,),
              title: regularTextWidget(textTitle: 'More Apps', textSize: 18, textColor: AppColors.kDarkLighter, fontWeight: FontWeight.w600)
          ),
          ListTile(
              leading: Image.asset(Assets.rateIcon.path, scale: 18,),
              title: regularTextWidget(textTitle: 'Rate Us', textSize: 18, textColor: AppColors.kDarkLighter, fontWeight: FontWeight.w600)
          ),
          ListTile(
              leading: Image.asset(Assets.privayIcon.path, scale: 18,),
              title: regularTextWidget(textTitle: 'Privacy Policy', textSize: 18, textColor: AppColors.kDarkLighter, fontWeight: FontWeight.w600)
          ),
          Spacer(),
          ListTile(
              leading: Icon(Icons.verified_sharp),
              title: regularTextWidget(textTitle: 'Version', textSize: 18, textColor: AppColors.kDarkLighter, fontWeight: FontWeight.w600),
              subtitle: regularTextWidget(textTitle: ' 1.1.1', textSize: 18, textColor: AppColors.kDarkLighter, fontWeight: FontWeight.w600)
          )
        ],
      ),
    );
  }
}