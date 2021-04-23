import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static final Color PrimaryMidBlue = HexColor("1565c0");
  static final Color PrimaryDarkBlue = HexColor("003c8f");
  static final Color PrimaryLight = HexColor("5e92f3");
  static final Color SecondaryDark = HexColor("82b3c9");
  static final Color SecondaryMid = HexColor("b3e5fc");
  static final Color SecondaryLight = HexColor("e6ffff");
  static final Color Orange = Colors.amber[700];

  static final LinearGradient backgroudFade = LinearGradient(
  colors: [AppColors.PrimaryDarkBlue, AppColors.PrimaryMidBlue],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  );

}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
