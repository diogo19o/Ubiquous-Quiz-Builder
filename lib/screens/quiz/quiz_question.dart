import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/controllers/question_controller.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/models/Questions.dart';

import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Questionario questionario = DataSource().questionarioAtivo;
    QuestionController _controller = Get.put(QuestionController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Flutter show the back button automatically
        backgroundColor: AppColors.PrimaryMidBlue,
        iconTheme: IconThemeData(color: AppColors.Orange),
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
