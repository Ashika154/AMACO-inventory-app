import 'package:amaco_app/core/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_dimensions.dart';


class SearchButton extends StatelessWidget {
  const SearchButton({super.key, this.hintText, this.onTap});

  final String? hintText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            border: Border.all(
              color: AppColors.secondaryColor,
            ),
            borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.search_outlined,
              color: AppColors.grey6B6B6B,
            ),
            SizedBox(width: 20),
            Expanded(
              child: CustomText(
                text: hintText ?? 'Search',
                fontSize: AppFontSize.s12,
                fontWeight: AppFontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
