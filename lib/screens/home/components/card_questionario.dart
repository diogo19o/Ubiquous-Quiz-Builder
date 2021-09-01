import 'package:flutter/material.dart';
import 'package:ubiquous_quizz_builder/models/questionario_details.dart';
import 'package:ubiquous_quizz_builder/util.dart';

class QuestionarioCard extends StatelessWidget {
  const QuestionarioCard({
    Key key,
    @required this.questionario,
    @required this.tapEvent,
    @required this.MainContext,
  }) : super(key: key);

  final BuildContext MainContext;
  final Function(String, BuildContext) tapEvent;
  final QuestionarioDetails questionario;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {tapEvent(questionario.id.toString(),MainContext);},
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(35),
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(15)),
              image: DecorationImage(
                  image: AssetImage('assets/images/place1.jpg'),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: cardInfoDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          questionario.titulo,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
