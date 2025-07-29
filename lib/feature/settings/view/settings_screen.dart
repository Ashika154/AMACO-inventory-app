import 'package:amaco_app/config/app_colors.dart';
import 'package:amaco_app/core/custom_widgets/custom_app_bar.dart';
import 'package:amaco_app/core/routes/route_name.dart';
import 'package:amaco_app/feature/settings/controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../config/app_dimensions.dart';
import '../../../core/custom_widgets/custom_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Provider.of<SettingsController>(context);
    final notificationToggleValue = context.watch<SettingsController>().onNotification;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Setting',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                CustomText(
                  text: 'Profile',
                  fontSize: AppFontSize.s12,
                  fontWeight: AppFontWeight.w500,
                  color: AppColors.violetB0A4B4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    'Notifications'.makeLabel(),
                    Switch(
                        value: notificationToggleValue,
                        onChanged:(value){
                          settingsController.clickOnNotification(value);
                        })
                  ],
                ),
                InkWell(
                  hoverColor: AppColors.secondaryColor,
                  onTap: ()=>context.pushNamed(RouteName.settingsChangePasswordScreen),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Change Password'.makeLabel(),
                      Icon( Icons.arrow_forward_ios)
                    ],
                  ),
                ),
                CustomText(
                  text: 'Other',
                  fontSize: AppFontSize.s12,
                  fontWeight: AppFontWeight.w500,
                  color: AppColors.violetB0A4B4,
                ),
                InkWell(
                  hoverColor: AppColors.secondaryColor,
                  onTap: ()=>context.pushNamed(RouteName.privacyPolicyScreen),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Privacy Policy'.makeLabel(),
                      Icon( Icons.arrow_forward_ios)
                    ],
                  ),
                ),
                5.height,
                InkWell(
                  onTap: ()=>context.pushNamed(RouteName.termsAndConditionScreen),
                  hoverColor: AppColors.secondaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Terms & Conditions'.makeLabel(),
                      Icon( Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}

extension on String{
  Widget makeLabel(){
    return CustomText(
      text: this,
      fontSize: AppFontSize.s14,
      fontWeight: AppFontWeight.w500,
    );
  }
}
