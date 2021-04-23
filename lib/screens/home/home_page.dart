import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'file:///C:/Users/diogo/AndroidStudioProjects/ubiquous_quizz_builder/lib/screens/home/components/app_bar.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'file:///C:/Users/diogo/AndroidStudioProjects/ubiquous_quizz_builder/lib/screens/home/components/user_avatar.dart';

import 'components/bottom_nav_bar.dart';
import 'components/category_title_bar.dart';
import 'components/gird_category.dart';
import 'components/slider_questionarios.dart';

class HomeScreen extends StatelessWidget {
  DataSource dataSource = DataSource();
  int currentIndex = 0;

  setBottomBarIndex(index) {
    /*setState(() {
      currentIndex = index;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        extendBody: true,
        appBar: buildAppBar(context,
            title: 'Quiz Builder', actions: [UserAvatar()],),
        body: Container(
          decoration: BoxDecoration(
              gradient: AppColors.backgroudFade),
          child: Stack(
            children: [
              Column(
                children: [
                  QuizTypeBar(
                    title: "Modos de Jogo",
                  ),
                  CategoryGrid(),
                  SizedBox(height: 20),
                  QuizTypeBar(
                    title: "Modo Questionário",
                  ),
                  SliderQuestionario()
                ],
              ),
              CurvedBottomNavBar(),
            ],
          ),
        )
        );
  }
}
