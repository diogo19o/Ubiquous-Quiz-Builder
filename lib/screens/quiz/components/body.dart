import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/constants.dart';
import 'package:ubiquous_quizz_builder/controllers/question_controller.dart';

import 'progress_bar.dart';
import 'question_card.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // So that we have acccess our controller
    QuestionController _questionController = Get.put(QuestionController());
    print(_questionController
        .dataSource.questionarioAtivo.questionarioDetails.modo);
    return Container(
      color: AppColors.PrimaryMidBlue,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _questionController.quizMode != 3
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding20),
                    child: ProgressBar())
                : Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Modo Questionário",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ],
                  ),
            SizedBox(height: 10),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding20),
              child: Obx(
                () => Text.rich(
                  TextSpan(
                    text:
                        "Pergunta ${_questionController.questionNumber.value}",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: AppColors.Orange),
                    children: [
                      TextSpan(
                        text: "/${_questionController.questions.length}",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: AppColors.Orange),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(thickness: 1.5),
            SizedBox(height: 5),
            Expanded(
              child:
                 /*_questionController.dataSource.questionarioAtivo.questionarioDetails.modo != "questionario" ?*/
                PageView.builder(
                  // Block swipe to next qn
                  physics:  NeverScrollableScrollPhysics(),
                  controller: _questionController.pageController,
                  onPageChanged: _questionController.updateTheQnNum,
                  itemCount: _questionController.questions.length,
                  itemBuilder: (context, index) => QuestionCard(
                      pergunta: _questionController.questions[index]),
                ) /*:
                  PageView.builder(
                controller: _questionController.pageController,
                onPageChanged: _questionController.updateTheQnNum,
                itemCount: _questionController.questions.length,
                itemBuilder: (context, index) => QuestionCard(
                    pergunta: _questionController.questions[index]),
              ),*/
            )
          ],
        ),
      ),
    );
  }
}
