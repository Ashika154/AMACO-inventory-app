import 'package:amaco_app/config/app_colors.dart';
import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/core/custom_widgets/app_back_button.dart';
import 'package:amaco_app/core/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget implements PreferredSize {
   const CustomAppBar({super.key, this.title, this.showBackButton});
  final String? title;
  final bool? showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      automaticallyImplyLeading: false,
      leading:showBackButton == false?null :AppBackButton(),
      title: CustomText(
        fontWeight: AppFontWeight.w500,
        fontSize: AppFontSize.s16,
        text: title?? '',),
    );

  }
   @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget get child => throw UnimplementedError();

}
