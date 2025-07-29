import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_dimensions.dart';
import 'custom_text.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double? fontSize;
  final double? width;
  final double? height;
  final double? cornerRadius;
  final Color? color;
  final Color? textColor;
  final Widget? prefix;
  final Widget? suffix;
  final EdgeInsets? padding;
  final BoxBorder? border;
  final bool isEnabled;
  final bool isLoading;

  const AppButton({
    super.key,
    this.onPressed,
    required this.text,
    this.fontSize,
    this.width,
    this.height,
    this.color,
    this.prefix,
    this.suffix,
    this.textColor,
    this.padding,
    this.cornerRadius,
    this.border,
    this.isEnabled = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(cornerRadius ?? 20),
      onTap: (isEnabled && !isLoading) ? onPressed : null,
      child: Container(
        height: height ?? 56,
        width: width ?? 343,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          border: border,
          gradient: LinearGradient(
            colors: [
              (isEnabled && !isLoading)
                  ? (color ?? AppColors.secondaryColor)
                  : AppColors.greyText,
              (isEnabled && !isLoading)
                  ? (color ?? AppColors.secondaryColor)
                  : AppColors.greyText,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) ...[
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? AppColors.primaryWhite,
                  ),
                ),
              ),
              if (text.isNotEmpty) 8.width,
            ] else ...[
              if (prefix != null) ...[prefix!, 4.width],
            ],
            if (!isLoading || text.isEmpty) ...[
              Flexible(
                child: CustomText(
                  text: text,
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize ?? AppFontSize.s14,
                  color: textColor ??
                      ((isEnabled && !isLoading)
                          ? AppColors.primaryWhite
                          : AppColors.greyText),
                ),
              ),
              if (suffix != null && !isLoading) ...[4.width, suffix!],
            ],
          ],
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? fontSize;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final FontWeight? fontWeight;
  final Color? textColor;

  const CustomTextButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.textColor,
    this.fontWeight,
    this.fontSize,
    this.backgroundColor = Colors.blue,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: padding,
          child: Center(
            child: CustomText(
              text: text,
              fontWeight: fontWeight ?? AppFontWeight.w600,
              fontSize: AppFontSize.s10,
            ),
          ),
        ),
      ),
    );
  }
}
