import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/screens/home/components/app_bar.dart';
import 'package:ubiquous_quizz_builder/screens/home/components/user_avatar.dart';
import 'package:ubiquous_quizz_builder/screens/login/login_page.dart';

import 'components/bottom_nav_bar.dart';
import 'components/category_title_bar.dart';
import 'components/gird_category.dart';
import 'components/slider_questionarios.dart';

class HomeScreen extends StatelessWidget {
  DataSource dataSource = DataSource();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        extendBody: true,
        appBar: buildAppBar(
          context,
          title: 'Quiz Builder',
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.off(() => LoginScreen()),
          ),
          actions: [UserAvatar()],
        ),
        body: Container(
          decoration: BoxDecoration(gradient: AppColors.backgroudFade),
          child: Stack(
            children: [
              Container(
                height: size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    QuizTypeBar(
                      title: "Modos de Jogo",
                    ),
                    CategoryGrid(),
                    SizedBox(height: 20),
                    /*ListTile(
                      leading: new Image.memory(dataSource.imageBytes),
                      title: new Text("imagem"),
                    ),*/
                    QuizTypeBar(
                      title: "Modo Questionário",
                    ),
                    SliderQuestionario()
                  ],
                ),
              ),
              CurvedBottomNavBar(),
            ],
          ),
        ));
  }
}
