import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/controllers/question_controller.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';

import '../../../constants.dart';

class ProgressBar extends StatelessWidget {
  ProgressBar({
    Key key,
  }) : super(key: key);

  final DataSource dataSource = DataSource();

  String getTime(int minutos, int segundos, var controller) {
    int tempoRestante = (controller.animation.value *
        (minutos * 60 + segundos))
        .round();
    return ((tempoRestante) / 60).toInt() < 1
        ? "${((tempoRestante) % 60)} seg"
        : "${((tempoRestante) % 60) < 10 ? "${((tempoRestante) / 60)
        .toInt()}:0${((tempoRestante) % 60)}" : "${((tempoRestante) / 60)
        .toInt()}:${((tempoRestante) % 60)}"}";
  }

  @override
  Widget build(BuildContext context) {
    int minutos = dataSource.questionarioAtivo.questionarioDetails.timerMinutos;
    int segundos =
        dataSource.questionarioAtivo.questionarioDetails.timerSegundos;

    var tempoRestante;

    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (controller) {
          return Stack(
            children: [
              // LayoutBuilder provide us the available space for the conatiner
              // constraints.maxWidth needed for our animation
              LayoutBuilder(
                builder: (context, constraints) =>
                    Container(
                      // from 0 to 1 it takes 30s
                      width: constraints.maxWidth * controller.animation.value,
                      decoration: BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding20 / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /*Text(
                        "${(controller.animation.value * (minutos * 60 + segundos)).round()} sec",
                        style: TextStyle(color: AppColors.SecondaryLight),
                      ),*/
                      Text(getTime(minutos,segundos,controller),
                        style: TextStyle(color: AppColors.SecondaryLight),
                      ),
                      Icon(
                        MdiIcons.clock,
                        color: AppColors.SecondaryLight,
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
