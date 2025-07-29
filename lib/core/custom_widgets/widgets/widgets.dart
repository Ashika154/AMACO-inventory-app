import 'package:amaco_app/config/app_assets.dart';
import 'package:amaco_app/config/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/app_colors.dart';

class FormTextField extends StatefulWidget {
  final String hintText;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool isPassword;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final double? height;
  final String? errorText;
  final bool? readOnly;
  final bool? autoFocus;
  final String? helperText;

  const FormTextField(
      {super.key,
      required this.hintText,
      this.suffixIcon,
      required this.controller,
      this.inputType = TextInputType.text,
      this.isPassword = false,
      this.onChanged,
      this.validator,
      this.height,
      this.errorText,
      this.onTap,
      this.readOnly,
      this.helperText,
      this.autoFocus});

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? (widget.errorText != null ? 60 : 40),
      width: double.infinity,
      child: TextFormField(
        autofocus: widget.autoFocus ?? false,
        controller: widget.controller,
        keyboardType: widget.inputType,
        obscureText: widget.isPassword ? _obscureText : false,
        onChanged: widget.onChanged,
        validator: widget.validator,
        readOnly: widget.readOnly ?? false,
        onTap: widget.onTap,
        style: TextStyle(
          fontSize: AppFontSize.s12,
          fontWeight: AppFontWeight.w500,
          color: AppColors.black000000,
        ),
        decoration: InputDecoration(
          helperText: widget.helperText,
          hintText: widget.hintText,
          errorText: widget.errorText,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: AppColors.black000000,//.appWithValues(alpha: .4),
                width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: AppColors.black000000,//.appWithValues(alpha: .4),
                width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: AppColors.black000000,//.appWithValues(alpha: .4),
                width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: AppColors.black000000,//.appWithValues(alpha: .4),
                width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: AppColors.black000000,//.appWithValues(alpha: .4),
                width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: AppColors.black000000,//.appWithValues(alpha: .4),
                width: 1),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Transform.rotate(
                    angle: _obscureText ? 0 : 3.14,
                    child: SvgPicture.asset(
                      AppIcons.person,//eyeCloseIcon,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  onPressed: () {
                    setState(() => _obscureText = !_obscureText);
                  },
                )
              : (widget.suffixIcon != null
                  ? Icon(
                      widget.suffixIcon,
                      size: 20,
                    )
                  : null),
        ),
      ),
    );
  }
}
