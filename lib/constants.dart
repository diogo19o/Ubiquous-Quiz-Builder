import 'package:flutter/material.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';

const kPrimaryColor = Color(0XFF6A62B7);
const kBackgroundColor = Color(0XFFE5E5E5);
const kTextColor = Color(0XFF2C2C2C);
const kCardInfoBG = Color(0XFF686868);
const kRatingStarColor = Color(0XFFF4D150);
const kInputBackgroundColor = Color(0XFFF3F3F3);
const kPrimaryLightColor = Color(0XFF897CFF);

const double kDefaultPadding20 = 20.0;
const double kDefaultPadding10 = 10.0;

final kPrimaryGradient = LinearGradient(
  colors: [ AppColors.PrimaryMidBlue, AppColors.SecondaryMid],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);