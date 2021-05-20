import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/controllers/question_controller.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    List<dynamic> status = Get.arguments;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                status[0],
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: AppColors.Orange),
              ),
              Spacer(),
              Text(
                "Respostas certas: ${status[1]}",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: AppColors.Orange),
              ),
              Spacer(),
              Text(
                "Respostas Erradas: ${status[2] - status[1]}",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: AppColors.Orange),
              ),
              Spacer(),
              Text(
                "Pontuação final - ${status[3]}",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: AppColors.Orange),
              ),
              Spacer(),
              Text(
                "${_qnController.numOfCorrectAns * 10}/${_qnController.questions.length * 10}",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: AppColors.PrimaryMidBlue),
              ),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}
