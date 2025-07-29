import 'package:amaco_app/core/custom_widgets/app_button.dart';
import 'package:amaco_app/core/custom_widgets/custom_app_bar.dart';
import 'package:amaco_app/core/custom_widgets/custom_text_form_field.dart';
import 'package:amaco_app/feature/settings/controller/settings_controller.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_dimensions.dart';
import '../../../core/custom_widgets/custom_text.dart';
import '../../../core/routes/route_name.dart';

class SettingsChangePasswordScreen extends StatelessWidget {
  const SettingsChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final settingController = Provider.of<SettingsController>(context);

    void showSecondBottomSheet( )async{
      await showModalBottomSheet(
          isDismissible: true,
          context: context,
          backgroundColor: AppColors.primaryColor,
          builder: (context)=>
              Container(
                width: MediaQuery.of(context).size.width,
                height: 249,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                  child: Column(
                    spacing: 30,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Password Changed',
                        fontSize: AppFontSize.s20,
                        fontWeight: AppFontWeight.w700,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomText(
                          textAlign:  TextAlign.center,
                          text: 'Your password has been updated successfully.',
                          fontSize: AppFontSize.s16,
                          fontWeight: AppFontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              )
      ).then((_){
        settingController.showPasswordChangedSuccess();
      });
    }

    Widget getContent(){
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Change Password',
          showBackButton: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              spacing: 15,
              children: [
                Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Old Password'.makeLabel(),
                    CustomTextFieldWidget(
                      inputType: TextInputType.text,
                      hintText: 'Old Password',
                    ),
                  ],
                ),
                Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'New Password'.makeLabel(),
                    CustomTextFieldWidget(
                      inputType: TextInputType.text,
                      hintText: 'New Password',
                    ),
                  ],
                ),
                Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Re-Enter New Password'.makeLabel(),
                    CustomTextFieldWidget(
                      inputType: TextInputType.text,
                      hintText: 'Re-Enter New Password',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar:
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25,vertical: 18),
          width: size.width,
          decoration: BoxDecoration(
              color: AppColors.primaryColor
          ),
          child: AppButton(
            text: 'Change Password',
            onPressed: (){
              settingController.showPasswordChangedSuccess();
              showSecondBottomSheet();
            },
          ),
        ),
      );
    }

    return settingController.passwordChangedSuccess ?Blur(
        blur: 2.5,
        blurColor: AppColors.secondaryColor,
        child: getContent()):getContent();
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