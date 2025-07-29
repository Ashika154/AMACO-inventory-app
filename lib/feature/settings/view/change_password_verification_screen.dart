import 'package:amaco_app/core/custom_widgets/custom_app_bar.dart';
import 'package:amaco_app/core/routes/route_name.dart';
import 'package:amaco_app/feature/settings/controller/settings_controller.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_dimensions.dart';
import '../../../config/app_strings.dart';
import '../../../core/custom_widgets/app_button.dart';
import '../../../core/custom_widgets/custom_text.dart';

class ChangePasswordVerificationScreen extends StatelessWidget {
  const ChangePasswordVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final settingsController = Provider.of<SettingsController>(context,listen: false);

    void showSecondBottomSheet( )async{
      Future.delayed(Duration(seconds: 3),(){
        context.pushNamed(RouteName.welcomeScreen);
      });
      await showModalBottomSheet(
          isDismissible:true,
          context: context,
          backgroundColor: AppColors.primaryColor,
          builder: (context)=>
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                  child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Account Deleted',
                        fontSize: AppFontSize.s20,
                        fontWeight: AppFontWeight.w700,
                      ),
                      CustomText(
                        text: 'Your account has been permanently removed. We\'re sorry to see you go.',
                        fontSize: AppFontSize.s16,
                        fontWeight: AppFontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
      );
    }

    void showBottomSheet( )async{
      await showModalBottomSheet(
          isDismissible: false,
          context: context,
          backgroundColor: AppColors.primaryColor,
          builder: (context)=>
              Container(
                width: MediaQuery.of(context).size.width,
                height: 294,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Delete Account?',
                        fontSize: AppFontSize.s20,
                        fontWeight: AppFontWeight.w700,
                      ),
                      CustomText(
                        text: 'Are you sure you want to delete your account?',
                        fontSize: AppFontSize.s16,
                        fontWeight: AppFontWeight.w400,
                      ),
                      20.height,
                      Row(
                        spacing: 20,
                        children: [
                          Flexible(child: AppButton
                            (
                              onPressed: (){context.pop();settingsController.showDeleteOption();},
                              border: Border.all(
                                color: AppColors.secondaryColor
                              ),
                              color: AppColors.primaryColor,
                              textColor: AppColors.secondaryColor,
                              text: 'Cancel'
                            ),
                          ),
                          Flexible(
                              child: AppButton(
                                  text: 'Yes',
                                  onPressed: ()=>showSecondBottomSheet(),
                              )
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
      );
    }


    Widget content(){
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Verification',
          showBackButton: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 75),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                CustomText(
                  text: 'Verification',
                  fontFamily: ConstantString.appFontBold,
                  fontSize: AppFontSize.s32,
                  fontWeight: AppFontWeight.w700,
                  color: AppColors.secondaryColor,
                ),
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'We have sent an email to your email account with a verification code!'
                      ,style: TextStyle(
                        color: AppColors.black000000,
                        fontFamily: ConstantString.appFont,
                        fontSize: AppFontSize.s16,
                        fontWeight: AppFontWeight.w400,
                      )
                    )
                  ]
                )),
                15.height,
                Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Verification Code',
                      fontWeight: AppFontWeight.w500,
                      fontSize: AppFontSize.s16,
                    ),
                    Container(
                      width: 343,
                      padding: EdgeInsets.symmetric(horizontal: 100,vertical: 16),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.secondaryColor,
                          ),
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: CustomText(
                        textAlign: TextAlign.center,
                        text: '1234',
                        fontSize: AppFontSize.s16,
                        fontWeight: AppFontWeight.w400,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:  EdgeInsets.only(right: size.width<390?10 :30),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                      text: 'Resend code',
                      fontWeight: AppFontWeight.w400,
                      fontSize: AppFontSize.s12,
                      color: AppColors.secondaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.secondaryColor,
                    ),
                  ),
                ),
                AppButton(
                  text: 'Confirm',
                  onPressed: (){ settingsController.showDeleteOption();showBottomSheet();},
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Consumer<SettingsController>(
      builder: (context,controller,_) {
        return controller.clickDeleteSuccess?
        Blur(
            blur: 2.5,
            blurColor: AppColors.primaryColor,
            child:content()
        )
            :content();
      }
    );
  }
}
