import 'package:amaco_app/config/app_strings.dart';
import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_dimensions.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final String? fontFamily;
  final double? letterSpacing;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final double? textScaleFactor;
  final List<Shadow>? shadows;
  final EdgeInsets? padding;
  final bool softWrap;

  const CustomText({
    super.key,
    this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.letterSpacing,
    this.maxLines,
    this.textOverflow,
    this.decoration,
    this.decorationColor,
    this.textScaleFactor,
    this.shadows,
    this.softWrap = true,
    this.padding,
    this.fontFamily
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(text ?? '',
          softWrap: true,
          overflow: maxLines == null
              ? TextOverflow.visible
              : (textOverflow ?? TextOverflow.ellipsis),
          maxLines: maxLines,
          style: TextStyle(
              fontFamily:fontFamily ??ConstantString.appFont,
              fontStyle: FontStyle.normal,
              shadows: shadows,
              letterSpacing: letterSpacing,
              fontSize: fontSize,
              fontWeight: fontWeight,
              decoration: decoration,
              decorationColor: decorationColor,
              color: color ?? AppColors.black000000),
          textAlign: textAlign),
    );
  }
}

Text textF16(String text,
    {FontWeight? fontWeight, Color? color, TextAlign? textAlign}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontFamily: ConstantString.appFont,
      fontSize: AppFontSize.s16,
      fontWeight: fontWeight ?? AppFontWeight.w400,
      color: color ?? AppColors.black000000,
    ),
  );
}

Text textF12(String text,
    {FontWeight? fontWeight, Color? color, TextAlign? textAlign}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontFamily: ConstantString.appFont,
      fontSize: AppFontSize.s12,
      fontWeight: fontWeight ?? AppFontWeight.w500,
      color: color ?? AppColors.black000000,
    ),
  );
}
