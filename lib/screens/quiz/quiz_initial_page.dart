import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/constants.dart';
import 'package:ubiquous_quizz_builder/controllers/services_bloc.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/models/questionario_details.dart';
import 'package:ubiquous_quizz_builder/screens/quiz/quiz_question.dart';

class QuizInitialPage extends StatelessWidget {

  DataSource _dataSource = DataSource();
  Services _services = Services();
  final scaffoldKey = GlobalKey<ScaffoldState>();

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

  void _navigateToQuiz(BuildContext context) {
    if(_dataSource.questionarioAtivo.questionarioDetails.modo == "questionario"){
      if(_services.jaRespondeuQuestionario()){
        scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Já respondeu a este questionário!")));
      }else{
        Get.to(() => QuizScreen());
      }
    }else{
      //Não é questionário
      Get.to(() => QuizScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    QuestionarioDetails detalhesQuestionario =
        DataSource().questionarioAtivo.questionarioDetails;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        // Flutter show the back button automatically
        backgroundColor: AppColors.PrimaryDarkBlue,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => Get.back(),),
        elevation: 0,
        title: Text(
          detalhesQuestionario.titulo,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: AppColors.backgroudFade),
        child: buildBody(context, detalhesQuestionario, size),
      ),
    );
  }

  Stack buildBody(BuildContext context, QuestionarioDetails detalhesQuestionario, Size size) {
    return Stack(
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
                  Center(
                    child: InkWell(
                      onTap: () => _navigateToQuiz(context),
                      child: Container(
                        width: size.width*0.6,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(kDefaultPadding20 * 0.75),
                        // 15
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [ AppColors.PrimaryMidBlue, AppColors.SecondaryMid, AppColors.SecondaryMid, AppColors.PrimaryMidBlue,],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Text(
                          "Começar",
                          style: TextStyle(color: AppColors.PrimaryDarkBlue, fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 2), // it will take 2/6 spaces
                ],
              ),
            ),
          ),
        ],
      );
  }
}
