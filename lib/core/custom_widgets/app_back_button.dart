import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/app_colors.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: AppColors.grey6B6B6B, size: 20),
      onPressed: () {
        GoRouter.of(context).pop();
      },
    );
  }
}