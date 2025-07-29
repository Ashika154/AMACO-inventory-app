import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = HexColor('#FCFAF5');
  static Color secondaryColor = HexColor('#BC9E5A');
  static Color secondaryLiteColor = HexColor('#E3D6AA');
  static Color primaryRed = HexColor('#FF0000');
  static Color primaryWhite = HexColor('#FFFFFF');
  static Color primaryYellow = HexColor('#FFC102');
  static Color whiteF6F6F6 = HexColor('#F6F6F6');
  static Color black000000 = HexColor('#000000');
  static Color black3A3A3A = HexColor('#3A3A3A');
  static Color grey6B6B6B = HexColor('#6B6B6B');
  static Color greyText = HexColor('#A0A0A0');
  static Color greyD9D9D9 = HexColor('#D9D9D9');
  static Color grey787878 = HexColor('#787878');
  static Color grey7F7F7F = HexColor('#7F7F7F');
  static Color lightGreyF6F6F6 = HexColor('#F6F6F6');
  static Color blue007EAA = HexColor('#007EAA');
  static Color green24AB38 = HexColor('#24AB38');
  static Color transparent = Colors.transparent;
  static Color dividerColor = HexColor('#DEDEDE');
  static Color green4C9A1C = HexColor('#4C9A1C');
  static Color blueD0E3FF = HexColor('#D0E3FF');
  static Color lightGrey9E9E9E = HexColor('#9E9E9E');
  static Color orangeF99125 = HexColor('#F99125');
  static Color yellowF5D342 = HexColor('#F5D342');
  static Color violetB0A4B4 = HexColor('#B0A4B4');

}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
