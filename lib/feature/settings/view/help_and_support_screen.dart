import 'package:amaco_app/config/app_assets.dart';
import 'package:amaco_app/config/app_colors.dart';
import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/core/custom_widgets/custom_app_bar.dart';
import 'package:amaco_app/core/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Help & Support',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          spacing: 30,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Contact Us',
              fontSize: AppFontSize.s12,
              fontWeight: AppFontWeight.w500,
              color: AppColors.violetB0A4B4,
            ),
            Row(
              spacing: 15,
              children: [
                SvgPicture.asset(
                  AppIcons.mobileIcon
                ),
                CustomText(
                  text: '+971 54 321 9876',
                  fontSize: AppFontSize.s14,
                  fontWeight: AppFontWeight.w400,
                )
              ],
            ),
            Row(
              spacing: 15,
              children: [
                SvgPicture.asset(
                    AppIcons.emailIcon
                ),
                CustomText(
                  text: 'support@yourapp.com',
                  fontSize: AppFontSize.s14,
                  fontWeight: AppFontWeight.w400,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
