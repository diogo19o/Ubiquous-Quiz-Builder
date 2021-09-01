import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/controllers/question_controller.dart';
import 'package:ubiquous_quizz_builder/controllers/services_bloc.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/models/Questions.dart';

import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Questionario questionario = DataSource().questionarioAtivo;
    print(questionario.perguntas[0].texto);
    QuestionController _controller;
    switch(questionario.questionarioDetails.modo) {
      case "classico": {
        _controller = Get.put(QuestionController(quizMode: 0));
      }
      break;

      case "contra_relogio": {
        _controller = Get.put(QuestionController(quizMode: 1));
      }
      break;

      case "morte_subita": {
        _controller = Get.put(QuestionController(quizMode: 2));
      }
      break;

      default: {
        _controller = Get.put(QuestionController(quizMode: 3));
      }
      break;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Flutter show the back button automatically
        backgroundColor: AppColors.PrimaryMidBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        title: Text(
          questionario.questionarioDetails.titulo,
          style: TextStyle(color: AppColors.SecondaryMid, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        /*actions: [
          FlatButton(onPressed: _controller.nextQuestion, child: Text("Skip")),
        ],*/
      ),
      body: Body(),
    );
  }
}
