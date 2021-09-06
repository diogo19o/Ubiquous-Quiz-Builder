import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/controllers/question_controller.dart';
import 'package:ubiquous_quizz_builder/controllers/services_bloc.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/models/Questions.dart';
import 'package:ubiquous_quizz_builder/screens/quiz/quiz_initial_page.dart';

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

    exitQuiz(){
      Get.back();
      Get.back();
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Flutter show the back button automatically
        backgroundColor: AppColors.PrimaryMidBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => showDialog(context: context, builder: (context) => AlertDialog(
            title: Text("Se sair perde o progresso total deste questionário. \n\nTem a certeza?"),
            actions: [
              TextButton(
                  onPressed: () => exitQuiz() /*Get.back()*/,
                  child: Text("Sair")),
              TextButton(
                  onPressed: () => {Get.back()},
                  child: Text("Continuar")),
            ],
          ))
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