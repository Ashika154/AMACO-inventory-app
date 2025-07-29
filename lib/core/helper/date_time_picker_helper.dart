import 'package:amaco_app/config/app_colors.dart';
import 'package:flutter/material.dart';

class DateTimeHelper {
  static final Color dialogBackgroundColor = AppColors.primaryWhite;
  static final Color labelTextColor = AppColors.secondaryColor;
  static final Color buttonColor = AppColors.secondaryColor;

  static Future<DateTime?> pickDate(BuildContext context,
      {DateTime? initialDate}) async {
    print('pickDate called with context: $context, initialDate: $initialDate');
    final now = DateTime.now();
    final result = await showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      barrierDismissible: false,
      builder: (context, child) {
        print(
            'DatePicker builder called with context: $context, child: $child');
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.secondaryColor,
            textTheme: TextTheme(
              titleLarge: TextStyle(color: labelTextColor),
              bodyMedium: TextStyle(color: labelTextColor),
            ),
            colorScheme: ColorScheme.dark(
              primary: AppColors.secondaryColor,
              onPrimary: AppColors.primaryWhite,
              onSurface: AppColors.secondaryColor,
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: dialogBackgroundColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  foregroundColor: AppColors.primaryWhite
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    print('DatePicker returned: $result');
    return result;
  }

  // Custom themed Time Picker
  static Future<TimeOfDay?> pickTime(BuildContext context, {TimeOfDay? initialTime}) async {
    final now = TimeOfDay.now();
    return await showTimePicker(
      context: context,
      initialTime: initialTime ?? now,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: dialogBackgroundColor,
            colorScheme: ColorScheme.dark(
              primary: AppColors.secondaryColor,
              onPrimary: AppColors.primaryWhite,
              surface: dialogBackgroundColor,
              onSurface: labelTextColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: buttonColor),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  static String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  static String formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$minute $period";
  }
}
