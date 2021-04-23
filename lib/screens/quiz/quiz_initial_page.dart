import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/constants.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/models/questionario_details.dart';
import 'package:ubiquous_quizz_builder/screens/quiz/quiz_question.dart';

class WelcomeScreen extends StatelessWidget {
  Widget _buildTextDetalhe(
      BuildContext context, String tituloDetalhe, String valorDetalhe) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '$tituloDetalhe: ',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: AppColors.SecondaryMid),
          ),
          TextSpan(
              text: valorDetalhe,
              style:
                  TextStyle(color: AppColors.SecondaryLight, fontSize: 20)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    QuestionarioDetails detalhesQuestionario =
        DataSource().questionarioAtivo.questionarioDetails;

    return Scaffold(
      appBar: AppBar(
        // Flutter show the back button automatically
        backgroundColor: AppColors.PrimaryDarkBlue,
        iconTheme: IconThemeData(color: AppColors.Orange),
        elevation: 0,
        title: Text(
          detalhesQuestionario.titulo,
          style: TextStyle(
              color: AppColors.PrimaryLight,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        centerTitle: true,
        /*actions: [
          FlatButton(onPressed: _controller.nextQuestion, child: Text("Skip")),
        ],*/
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: AppColors.backgroudFade),
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 50),
                          Text(
                            "Vamos responder,",
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(
                                color: Colors.orangeAccent,
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 50),
                          Text("${detalhesQuestionario.titulo}:",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(color: AppColors.SecondaryMid)),
                          SizedBox(height: 20),
                          !(detalhesQuestionario.modo == "questionario") ? _buildTextDetalhe(context, "Dificuldade",
                              detalhesQuestionario.dificuldade) : SizedBox(height: 0),
                          _buildTextDetalhe(context, "Descrição",
                              detalhesQuestionario.descricao),
                          _buildTextDetalhe(context, "Data de criação",
                              detalhesQuestionario.dataDeCriacao),
                        ],
                      ),
                    ),
                    Spacer(), // 1/6
                    InkWell(
                      onTap: () => Get.to(QuizScreen()),
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(kDefaultPadding20 * 0.75),
                        // 15
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [ AppColors.PrimaryMidBlue, AppColors.SecondaryMid, AppColors.PrimaryMidBlue,],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Text(
                          "Começar",
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: AppColors.PrimaryDarkBlue),
                        ),
                      ),
                    ),
                    Spacer(flex: 2), // it will take 2/6 spaces
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
