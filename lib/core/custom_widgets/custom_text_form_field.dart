import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/config/app_strings.dart';
import 'package:amaco_app/core/custom_widgets/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import 'app_decorations.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget(
      {super.key,
      required this.inputType,
      this.controller,
      this.hintStyle,
      this.contentPadding,
      this.focusedBorder,
      this.border,
      this.hintText,
      this.enabledBorder,
      this.errorBorder,
      this.focusedErrorBorder,
      this.padding,
      this.validator,
      this.customErrorText,
      this.textAlign,
      this.textAlignVertical,
      this.expands,
      this.maxLines,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText,
      this.disabledBorder,
      this.autoFocus,
      this.onChanged,
      this.readOnly,
      this.onTap,
      this.onFieldSubmitted,
      this.labelText,
      this.fillColor,
      this.borderRadius,
      this.borderColor,
      this.filled,
      this.focusNode,
      this.maxLength,
      this.counterText, this.width,
      });

  final TextInputType inputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextStyle? hintStyle;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final String? hintText;
  final String? counterText;
  final String? labelText;
  final String? customErrorText;
  final EdgeInsets? padding;
  final bool? expands;
  final bool? readOnly;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final int? maxLines;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? autoFocus;
  final bool? filled;
  final Color? fillColor;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 0),
      child: SizedBox(
        height: 56,
        width: width?? 343,
        child: TextFormField(
          maxLines: maxLines,
          readOnly: readOnly ?? false,
          cursorColor: AppColors.greyText,
          textAlign: textAlign ?? TextAlign.left,
          textAlignVertical: textAlignVertical,
          keyboardType: inputType,
          autofocus: autoFocus ?? false,
          expands: expands ?? false,
          obscureText: obscureText ?? false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: onChanged,
          onTap: onTap,
          maxLength: maxLength,
          onFieldSubmitted: onFieldSubmitted,
          focusNode: focusNode,
          style: TextStyle(
              fontFamily: ConstantString.appFont,
              fontWeight: FontWeight.w400,
              fontSize: ResponsiveUtils.isMobile(context) ? 14 : 20,
              color: AppColors.black000000,
              decorationColor: AppColors.primaryWhite),
          decoration: InputDecoration(
            fillColor: fillColor ?? AppColors.lightGreyF6F6F6,
            filled: filled ?? false,
            counterText: counterText,
            hoverColor: Colors.transparent,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            prefixIconConstraints:
                const BoxConstraints(maxWidth: 55, minWidth: 35),
            suffixIconConstraints:
                const BoxConstraints(maxWidth: 50, minWidth: 45),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: border ??
                OutlineInputBorder(
                    borderRadius: borderRadius ?? AppRadius.radius15,
                    borderSide: BorderSide(
                        color: borderColor ?? AppColors.secondaryColor)),
            enabledBorder: enabledBorder ??
                OutlineInputBorder(
                    borderRadius: borderRadius ?? AppRadius.radius15,
                    borderSide: BorderSide(
                        color: borderColor ?? AppColors.secondaryColor)),
            focusedBorder: focusedBorder ??
                OutlineInputBorder(
                    borderRadius: borderRadius ?? AppRadius.radius15,
                    borderSide: BorderSide(
                        color: borderColor ?? AppColors.secondaryColor)),
            focusedErrorBorder: focusedErrorBorder ??
                OutlineInputBorder(
                    borderRadius: borderRadius ?? AppRadius.radius15,
                    borderSide: BorderSide(
                        color: borderColor ?? AppColors.secondaryColor)),
            errorBorder: errorBorder ??
                OutlineInputBorder(
                    borderRadius: borderRadius ?? AppRadius.radius15,
                    borderSide: BorderSide(
                        color: borderColor ?? AppColors.secondaryColor)),
            disabledBorder: disabledBorder ??
                OutlineInputBorder(
                    borderRadius: borderRadius ?? AppRadius.radius15,
                    borderSide: BorderSide(
                        color: borderColor ?? AppColors.secondaryColor)),
            hintText: hintText,
            hintStyle: hintStyle ??
                TextStyle(
                  fontFamily: ConstantString.appFont,
                  fontWeight: FontWeight.w400,
                  fontSize: ResponsiveUtils.isMobile(context) ? 14 : 20,
                  color: AppColors.greyText,
                ),
            labelText: labelText,
            labelStyle: TextStyle(
              fontFamily: ConstantString.appFont,
              fontWeight: FontWeight.w400,
              fontSize: ResponsiveUtils.isMobile(context) ? 14 : 20,
              color: AppColors.greyText,
            ),
            errorStyle: TextStyle(
              fontFamily: ConstantString.appFont,
              fontSize: isMobile ? 12 : 14.0,
              height: 0.8,
            ),
            errorMaxLines: 1,
          ),
          controller: controller,
          validator: validator,
        ),
      ),
    );
  }
}

class CustomCupertinoTextFieldWidget extends StatelessWidget {
  const CustomCupertinoTextFieldWidget({
    super.key,
    required this.inputType,
    this.controller,
    this.hintStyle,
    this.contentPadding,
    this.hintText,
    this.labelText,
    this.customErrorText,
    this.validator,
    this.textAlign,
    this.maxLines,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.autoFocus,
    this.onChanged,
    this.textAlignVertical,
    this.readOnly,
  });

  final TextInputType inputType;
  final TextEditingController? controller;
  final TextStyle? hintStyle;
  final String? hintText;
  final String? labelText;
  final String? customErrorText;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign? textAlign;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? autoFocus;
  final void Function(String)? onChanged;
  final bool? readOnly;
  final TextAlignVertical? textAlignVertical;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: FormField<String>(
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: controller?.text,
        builder: (FormFieldState<String> state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (labelText != null) ...{
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    labelText!,
                    style: TextStyle(
                      fontFamily: ConstantString.appFont,
                      fontWeight: FontWeight.w400,
                      fontSize: ResponsiveUtils.isMobile(context) ? 14 : 20,
                      color: AppColors.greyText,
                    ),
                  ),
                ),
                10.height,
              },
              CupertinoTextField(
                controller: controller,
                keyboardType: inputType,
                autofocus: autoFocus ?? false,
                obscureText: obscureText ?? false,
                readOnly: readOnly ?? false,
                maxLines: maxLines,
                textAlignVertical: textAlignVertical,
                padding: contentPadding ??
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textAlign: textAlign ?? TextAlign.left,
                style: TextStyle(
                  fontFamily: ConstantString.appFont,
                  fontWeight: FontWeight.w400,
                  fontSize: ResponsiveUtils.isMobile(context)
                      ? AppFontSize.s14
                      : AppFontSize.s20,
                  color: AppColors.black000000,
                ),
                placeholder: hintText,
                placeholderStyle: hintStyle ??
                    TextStyle(
                      fontFamily: ConstantString.appFont,
                      fontWeight: FontWeight.w400,
                      fontSize: ResponsiveUtils.isMobile(context) ? 14 : 20,
                      color: AppColors.greyText,
                    ),
                prefix: prefixIcon,
                suffix: suffixIcon,
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite,
                  borderRadius: AppRadius.radius10,
                  boxShadow: greyBoxShadow(),
                  border: Border.all(color: AppColors.primaryWhite),
                ),
                onChanged: (value) {
                  state.didChange(value);
                  if (onChanged != null) onChanged!(value);
                },
              ),
              // if (state.hasError)
              //   Padding(
              //     padding: const EdgeInsets.only(left: 20, top: 5, right: 20),
              //     child: CustomText(
              //       text: customErrorText ?? state.errorText!,
              //       color: CupertinoColors.systemRed,
              //       fontSize: ResponsiveUtils.isMobile(context)
              //           ? AppFontSize.s12
              //           : AppFontSize.s14,
              //     ),
              //   ),
            ],
          );
        },
      ),
    );
  }
}
