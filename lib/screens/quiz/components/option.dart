import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/controllers/question_controller.dart';

import '../../../constants.dart';

class Option extends StatelessWidget {
  const Option({
    Key key,
    this.text,
    this.index,
    this.press,
  }) : super(key: key);
  final String text;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (questionController) {
          Color getTheRightColor() {
            if (questionController.isAnswered) {
              if (questionController.quizMode != 3) {
                if (index == questionController.correctAns) {
                  return Color.fromRGBO(52, 112, 68, 1);
                } else if (index == questionController.selectedAns &&
                    questionController.selectedAns !=
                        questionController.correctAns) {
                  return Colors.red;
                }
              } else {
                if (index == questionController.selectedAns) {
                  return Colors.teal;
                }
              }
            }
            return AppColors.PrimaryDarkBlue;
          }

          IconData getTheRightIcon() {
            return getTheRightColor() == Colors.red
                ? Icons.close
                : getTheRightColor() == Colors.teal
                    ? MdiIcons.adjust
                    : Icons.done;
          }

          return InkWell(
            onTap: press,
            child: Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.all(kDefaultPadding10),
              decoration: BoxDecoration(
                border: Border.all(color: getTheRightColor()),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${index + 1}) $text",
                      overflow: TextOverflow.fade,
                      style: TextStyle(color: getTheRightColor(), fontSize: 16),
                    ),
                  ),
                  Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      color: getTheRightColor() == AppColors.PrimaryDarkBlue
                          ? Colors.transparent
                          : getTheRightColor(),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: getTheRightColor()),
                    ),
                    child: getTheRightColor() == AppColors.PrimaryDarkBlue
                        ? null
                        : Icon(getTheRightIcon(), size: 16),
                  )
                ],
              ),
            ),
          );
        });
  }
}
