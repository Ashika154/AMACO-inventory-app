import 'package:flutter/material.dart';

class AppFontSize {
  static double s8 = 8;
  static double s9 = 9;
  static double s10 = 10;
  static double s11 = 11;
  static double s12 = 12;
  static double s13 = 13;
  static double s14 = 14;
  static double s15 = 15;
  static double s16 = 16;
  static double s17 = 17;
  static double s18 = 18;
  static double s19 = 19;
  static double s20 = 20;
  static double s21 = 21;
  static double s22 = 22;
  static double s24 = 24;
  static double s25 = 25;
  static double s26 = 26;
  static double s28 = 28;
  static double s30 = 30;
  static double s32 = 32;
  static double s34 = 34;
  static double s40 = 40;
  static double s35 = 35;
}

class AppFontWeight {
  static FontWeight w200 = FontWeight.w200;
  static FontWeight w300 = FontWeight.w300;
  static FontWeight w400 = FontWeight.w400;
  static FontWeight w500 = FontWeight.w500;
  static FontWeight w600 = FontWeight.w600;
  static FontWeight w700 = FontWeight.w700;
  static FontWeight w800 = FontWeight.w800;
  static FontWeight w900 = FontWeight.w900;
}

extension Sizes on num {
  SizedBox get height => SizedBox(
        height: toDouble(),
      );
  SizedBox get width => SizedBox(
        width: toDouble(),
      );
}
