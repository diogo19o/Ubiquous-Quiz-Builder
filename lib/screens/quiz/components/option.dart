import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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
              if (index == questionController.correctAns) {
                return Colors.greenAccent;
              } else if (index == questionController.selectedAns &&
                  questionController.selectedAns != questionController.correctAns) {
                return Colors.red;
              }
            }
            return Colors.white;
          }

          IconData getTheRightIcon() {
            return getTheRightColor() == Colors.red ? Icons.close : Icons.done;
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
                      color: getTheRightColor() == Colors.white
                          ? Colors.transparent
                          : getTheRightColor(),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: getTheRightColor()),
                    ),
                    child: getTheRightColor() == Colors.white
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
