import 'package:flutter/material.dart';
import 'package:ubiquous_quizz_builder/constants.dart';

final cardInfoDecoration = BoxDecoration(
  borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(15), bottomRight: Radius.circular(35)),
  color: kCardInfoBG.withOpacity(0.6),
);

final cardBackgroundDecoration = BoxDecoration(
  borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(15),
      bottomRight: Radius.circular(35),
      topLeft: Radius.circular(35),
      topRight: Radius.circular(15)),
  color: kCardInfoBG.withOpacity(0.2),
);
