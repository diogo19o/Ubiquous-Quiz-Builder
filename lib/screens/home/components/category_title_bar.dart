import 'package:flutter/material.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/screens/listQuestionarios/list.dart';

class QuizTypeBar extends StatelessWidget {
  const QuizTypeBar({
    this.title,
    Key key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10,left: 20,right: 20),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColors.SecondaryMid,
                fontWeight: FontWeight.w700,
                fontSize: 18
              ),
            ),

            Spacer(),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) {
                        if(title == "Modos de Jogo"){
                          return ListQuestionarios("all");
                        }else{
                          return ListQuestionarios("questionario");
                        }
                      }),
                );
              },
              child: Text(
                'Ver Todos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}