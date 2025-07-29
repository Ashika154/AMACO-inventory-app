import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_dimensions.dart';
import 'custom_text.dart';

List<BoxShadow> greyBoxShadow() {
  return [
    BoxShadow(
        color: AppColors.black000000.withValues(alpha: .2),
        blurRadius: 2,
        offset: const Offset(0, 0),
        spreadRadius: 0)
  ];
}

List<BoxShadow> yellowBoxShadow() {
  return [
    BoxShadow(
        color: AppColors.primaryYellow.withValues(alpha: .4),
        blurRadius: 2,
        offset: const Offset(0, 0),
        spreadRadius: 0)
  ];
}

Border border1({Color? color}) {
  return Border.all(color: color ?? AppColors.primaryWhite);
}

class AppRadius {
  static BorderRadius radius4 = BorderRadius.circular(4);
  static BorderRadius radius8 = BorderRadius.circular(8);
  static BorderRadius radius10 = BorderRadius.circular(10);
  static BorderRadius radius12 = BorderRadius.circular(12);
  static BorderRadius radius14 = BorderRadius.circular(14);
  static BorderRadius radius15 = BorderRadius.circular(15);
  static BorderRadius radius20 = BorderRadius.circular(20);
  static BorderRadius radius25 = BorderRadius.circular(25);
  static BorderRadius radius30 = BorderRadius.circular(30);
}

ScaffoldMessengerState showSnackBar(BuildContext context, String message,
    {Color? textColor, Color? backgroundColor, double? fontSize}) {
  return ScaffoldMessenger.of(context)
    ..showSnackBar(
      SnackBar(
        content: CustomText(
            text: message,
            fontSize: fontSize ?? AppFontSize.s16,
            color: textColor ?? AppColors.primaryWhite),
        backgroundColor: backgroundColor ?? AppColors.secondaryColor,
        duration: const Duration(seconds: 3),
      ),
    );
}
