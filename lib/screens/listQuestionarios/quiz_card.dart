import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ubiquous_quizz_builder/controllers/services_bloc.dart';
import 'package:ubiquous_quizz_builder/models/questionario_details.dart';
import 'package:ubiquous_quizz_builder/screens/quiz/quiz_initial_page.dart';

class QuizCard extends StatelessWidget {
  final QuestionarioDetails questionario;
  final Function onTap;

  const QuizCard({Key key, @required this.questionario, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Provider.of<Services>(context, listen: false)
            .loadActiveQuiz(questionario.id),
        Get.to(() => QuizInitialPage())
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
          child: Row(
            children: [
              questionario.modo == "classico"
                  ? Icon(
                      MdiIcons.gamepad,
                      color: Colors.lightGreen,
                      size: 50,
                    )
                  : questionario.modo == "contra_relogio"
                      ? Icon(
                          MdiIcons.alarm,
                          color: Colors.orangeAccent,
                          size: 50,
                        )
                      : questionario.modo == "questionario"
                          ? Icon(
                              MdiIcons.headQuestionOutline,
                              color: Colors.orangeAccent,
                              size: 50,
                            )
                          : Icon(
                              MdiIcons.skull,
                              color: Colors.deepOrange,
                              size: 50,
                            ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      questionario.titulo,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Divider(
                      height: 10,
                      color: Colors.blueGrey,
                    ),
                    Text(
                      "Dificuldade: ${questionario.dificuldade}\nData de criação: ${questionario.dataDeCriacao}",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    /*
    ListTile(
        contentPadding: EdgeInsets.all(5),

        leading: questionario.modo == "classico" ? Icon(
          MdiIcons.gamepad,
          color: Colors.lightGreen,
          size: 50,
        ): questionario.modo == "contra_relogio" ? Icon(
          MdiIcons.alarm,
          color: Colors.orangeAccent,
          size: 50,
        ) : Icon(
          MdiIcons.skull,
          color: Colors.deepOrange,
          size: 50,
        ),
        title: Text(
          questionario.titulo,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Dificuldade: ${questionario.dificuldade}\nData de criação: ${questionario.dataDeCriacao}"),
        onTap: () => {
          Provider.of<Services>(context, listen: false)
              .loadActiveQuiz(questionario.id),
          Get.to(() => QuizInitialPage())
        },
      )
    */
    /*Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              MdiIcons.gamepad,
              color: Colors.white,
              size: 50,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: questionario.titulo,
                  subtitle: questionario.descricao,
                  author: questionario.dificuldade,
                  publishDate: questionario.dataDeCriacao,
                  readDuration: "5 mins",
                ),
              ),
            )
          ],
        ),
      ),
    );*/
  }
}

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.author,
    @required this.publishDate,
    @required this.readDuration,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                author,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$publishDate - $readDuration',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
