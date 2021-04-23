import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';

AppBar buildAppBar(BuildContext context, {String title, List<Widget> actions, Widget leading}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: AppColors.PrimaryDarkBlue,
    elevation: 0,
    title: Text(
      title,
      style: GoogleFonts.merriweather(
        color: Colors.amber[700],
        fontSize: 27,
      ),
    ),
    leading: IconButton(
      icon: Icon(MdiIcons.logout, color: Colors.white),
      onPressed: () => Navigator.of(context).pop(),
    ),
    actions: actions,
  );
}