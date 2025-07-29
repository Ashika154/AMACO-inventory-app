import 'package:amaco_app/config/app_colors.dart';
import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/config/app_strings.dart';
import 'package:amaco_app/core/custom_widgets/app_button.dart';
import 'package:amaco_app/core/custom_widgets/custom_text.dart';
import 'package:amaco_app/core/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            CustomText(
              text: 'Welcome to',
              fontWeight: AppFontWeight.w500,
              fontSize:AppFontSize.s24 ,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'AMACO INVESTMENT',
                  fontFamily: ConstantString.appFontBold,
                  fontWeight: AppFontWeight.w900,
                  fontSize:AppFontSize.s24 ,
                  color:AppColors.secondaryColor,
                ),
                CustomText(
                  text: 'GROUP LLC',
                  fontFamily: ConstantString.appFontBold,
                  fontWeight: AppFontWeight.w900,
                  fontSize:AppFontSize.s24 ,
                  color:AppColors.secondaryColor,
                ),
              ],
            ),
            10.height,
            AppButton(
                text: 'Register',
                color: AppColors.primaryColor,
                textColor:AppColors.secondaryColor ,
                border: Border.all(
                  color: AppColors.secondaryColor
                ),
              onPressed:() =>context.pushNamed(RouteName.registerScreen),
            ),
            AppButton(
              text: 'Login',
              onPressed:() =>context.pushNamed(RouteName.loginScreen),
            ),
          ],
        ),
      ),
    );
  }
}
