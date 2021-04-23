import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/controllers/question_controller.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/models/pergunta.dart';
import 'package:ubiquous_quizz_builder/models/resposta.dart';

import '../../../constants.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key key,
    // it means we have to pass this
    @required this.question,
  }) : super(key: key);

  final Pergunta question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    final DataSource dataSource = DataSource();
    List<Resposta> respostas = dataSource.questionarioAtivo.respostas.where((resposta) => resposta.perguntaID == question.id).toList();
    int indexCorrectAnswer = respostas.indexWhere((resposta) => resposta.correta);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(

          margin: EdgeInsets.only(left: kDefaultPadding20,right: kDefaultPadding20,bottom: kDefaultPadding20),
          padding: EdgeInsets.all(kDefaultPadding20),
          decoration: BoxDecoration(
            color: AppColors.PrimaryLight,
            borderRadius: BorderRadius.circular(25),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  question.texto,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: AppColors.SecondaryLight),
                ),
                SizedBox(height: kDefaultPadding20 / 2),
                ...List.generate(
                  respostas.length,
                  (index) => Option(
                    index: index,
                    text: respostas[index].texto,
                    press: () => _controller.checkAns(question, index, indexCorrectAnswer),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}