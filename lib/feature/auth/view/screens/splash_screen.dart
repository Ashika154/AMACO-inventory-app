
import 'dart:async';

import 'package:amaco_app/config/app_assets.dart';
import 'package:amaco_app/config/app_colors.dart';
import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/core/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helper/shared_preferences_helper.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    bool loggedIn = false;

    WidgetsBinding.instance.addPostFrameCallback((_) async{
      loggedIn = await isUserLoggedIn();
    });

    Timer(Duration(seconds: 2),(){
      if(mounted){
         context.pushNamed( loggedIn? RouteName.homeScreen : RouteName.welcomeScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                  AppImages.appLogo,
                  width: 243,
                  height: 208,
              ),
              18.height,
              Text(
                 'AMACO INVESTMENT',
                style: TextStyle(
                  fontSize: AppFontSize.s24,
                  fontWeight: AppFontWeight.w700,
                  color: AppColors.black000000,
                  fontFamily: 'Play'
                ),
              ),
              Text(
                'GROUP LLC',
                style: TextStyle(
                    fontSize: AppFontSize.s24,
                    fontWeight: AppFontWeight.w700,
                    color: AppColors.black000000,
                    fontFamily: 'Play'
                ),
              ),
            ],
          ),
        ),
    );
  }
}
