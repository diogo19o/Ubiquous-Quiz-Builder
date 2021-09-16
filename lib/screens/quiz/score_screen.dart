import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/controllers/question_controller.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/screens/home/home_page.dart';
import 'package:ubiquous_quizz_builder/screens/quiz/components/NewRecordDialog.dart';

class ScoreScreen extends StatelessWidget {
  showNewRecordDialog(BuildContext context, Map<String, dynamic> status) {
    print(status["recordePessoal"]);
    if (status["recordePessoal"]) {
      showDialog(
          context: context,
          builder: (context) => NewRecordDialog(
                title: "Novo Recorde Pessoal",
                description:
                    "Parabéns! Bateste o teu recorde pessoal neste questionário com uma pontuação de ${status["score"]} pontos",
                buttonText: "Ok",
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    Map<String, dynamic> status = Get.arguments;
    DataSource _dataSource = DataSource();
    final Size size = MediaQuery.of(context).size;

    Future.delayed(Duration.zero, () => showNewRecordDialog(context, status));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PrimaryDarkBlue,
        elevation: 0,
        title: Text("Resultado"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.backgroudFade),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      width: 3,
                      color: AppColors.SecondaryLight,
                    ),
                    boxShadow: true
                        ? [
                            BoxShadow(
                              color: AppColors.PrimaryLight,
                              blurRadius: 20,
                            )
                          ]
                        : [],
                    image: DecorationImage(
                        image:
                            ExactAssetImage('assets/images/trophy-1-no-bg.png'),
                        fit: BoxFit.fill)),
              ),
              Spacer(flex: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  status["mensagem"],
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: AppColors.Orange),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(flex: 1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: _dataSource.questionarioAtivo.questionarioDetails.modo !=
                        "questionario"
                    ? Text(
                        "Acabaste de completar o questionário ${_dataSource.questionarioAtivo.questionarioDetails.titulo}",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: AppColors.SecondaryLight),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        "Obrigado por responderes ao questionário: ${_dataSource.questionarioAtivo.questionarioDetails.titulo}",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: AppColors.SecondaryLight),
                        textAlign: TextAlign.center,
                      ),
              ),
              Spacer(flex: 1),
              _dataSource.questionarioAtivo.questionarioDetails.modo !=
                      "questionario"
                  ? Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  MdiIcons.check,
                                  color: Colors.lightGreenAccent,
                                  size: 30,
                                ),
                                Text(
                                  " Certas: ${status["certas"]} ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(color: AppColors.Orange),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  MdiIcons.close,
                                  color: Colors.redAccent,
                                  size: 30,
                                ),
                                Text(
                                  " Erradas: ${status["erradas"]} ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(color: AppColors.Orange),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : SizedBox(),
              Spacer(),
              _dataSource.questionarioAtivo.questionarioDetails.modo !=
                      "questionario"
                  ? /*Text(
                "Score - ${status["score"]} pts",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: AppColors.Orange),
              )*/
                  Text.rich(
                      TextSpan(
                        text: "Score: ${status["score"]}",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: AppColors.Orange),
                        children: [
                          /*TextSpan(
                            text: "/${status["maxScore"]}",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: AppColors.SecondaryLight),
                          ),*/
                        ],
                      ),
                    )
                  : SizedBox(),
              Spacer(),
              RaisedGradientButton(
                  child: Text(
                    'Início',
                    style: TextStyle(
                        color: AppColors.PrimaryDarkBlue, fontSize: 25),
                  ),
                  width: size.width * .5,
                  gradient: LinearGradient(
                    colors: <Color>[
                      AppColors.PrimaryMidBlue,
                      AppColors.SecondaryMid,
                      AppColors.SecondaryMid,
                      AppColors.PrimaryMidBlue,
                    ],
                  ),
                  onPressed: () {
                    Get.off(HomeScreen());
                  }),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 60.0,
      decoration: BoxDecoration(
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.PrimaryDarkBlue,
              offset: Offset(0.0, 0.5),
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(50)),
      child: FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              MdiIcons.home,
              color: AppColors.PrimaryDarkBlue,
            ),
            SizedBox(
              width: 10,
            ),
            child,
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
