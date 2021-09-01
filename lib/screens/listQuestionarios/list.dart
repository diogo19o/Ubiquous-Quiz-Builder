import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/controllers/services_bloc.dart';
import 'package:ubiquous_quizz_builder/data/api_response.dart';
import 'package:ubiquous_quizz_builder/models/questionario_details.dart';
import 'package:ubiquous_quizz_builder/screens/listQuestionarios/quiz_card.dart';
import 'package:ubiquous_quizz_builder/screens/quiz/quiz_initial_page.dart';

class ListQuestionarios extends StatefulWidget {
  String category;

  ListQuestionarios(this.category);

  @override
  _ListQuestionariosState createState() =>
      _ListQuestionariosState(this.category);
}

class _ListQuestionariosState extends State<ListQuestionarios> {
  _ListQuestionariosState(this.category);

  DataSource _dataSource = DataSource();
  Services _bloc;

  List<QuestionarioDetails> questionarios;

  bool date_asc = false, title_asc = false, dif_asc = false, ordenado = false;

  String category;

  Widget setPageTitle() {
    switch (category) {
      case "all":
        return Text(
          "Todos os modos de jogo",
          style: TextStyle(color: Colors.white, fontSize: 25),
        );
        break;
      case "questionario":
        return Text(
          "Modo Questionário",
          style: TextStyle(color: Colors.white, fontSize: 25),
        );
        break;
      case "classico":
        return Text(
          "Modo Clássico",
          style: TextStyle(color: Colors.white, fontSize: 25),
        );
        break;
      case "contra_relogio":
        return Text(
          "Modo Contra-Relógio",
          style: TextStyle(color: Colors.white, fontSize: 25),
        );
        break;
      case "morte_subita":
        return Text(
          "Modo Morte Súbita",
          style: TextStyle(color: Colors.white, fontSize: 25),
        );
        break;
      default:
        return Text("Modo de Jogo");
    }
  }

  @override
  void initState() {
    super.initState();
    _bloc = Services();
    _bloc.fetchQuizList();
    ordenado = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.PrimaryDarkBlue,
          elevation: 0,
          title: setPageTitle(),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(gradient: AppColors.backgroudFade),
          child: _buildBody(context),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          //animatedIconTheme: IconThemeData.fallback(),
          children: [
            SpeedDialChild(
                child: dif_asc
                    ? Icon(MdiIcons.sortNumericDescending)
                    : Icon(MdiIcons.sortNumericAscending),
                label: "Dificuldade",
                onTap: () =>
                    {dif_asc ? _orderBy("dif_dsc") : _orderBy("dif_asc")}),
            SpeedDialChild(
                child: title_asc
                    ? Icon(MdiIcons.sortAlphabeticalDescending)
                    : Icon(MdiIcons.sortAlphabeticalAscending),
                label: "Titulo",
                onTap: () => {
                      title_asc ? _orderBy("title_dsc") : _orderBy("title_asc")
                    }),
            SpeedDialChild(
                child: date_asc
                    ? Icon(MdiIcons.sortCalendarDescending)
                    : Icon(MdiIcons.sortCalendarAscending),
                label: "Data",
                onTap: () =>
                    {date_asc ? _orderBy("date_dsc") : _orderBy("date_asc")}),
          ],
        ));
  }

  RefreshIndicator _buildBody(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _bloc.fetchQuizList(),
      child: StreamBuilder<ApiResponse<List<QuestionarioDetails>>>(
        stream: _bloc.quizListStream.asBroadcastStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                ordenado = false;
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case Status.COMPLETED:
                return _buildQuestionarios();
                break;
              case Status.ERROR:
                return AlertDialog(
                  title: Text("Não foi possivel atualizar a lista"),
                  actions: [
                    TextButton(
                        onPressed: () =>
                            _bloc.fetchLocalQuizList() /*Get.back()*/,
                        child: Text("Usar dados offline")),
                    TextButton(
                        onPressed: () => {_bloc.fetchQuizList()},
                        child: Text("Tentar de novo")),
                  ],
                );
                break;
            }
          }
          return Container();
        },
      ),
    );
  }

  ListView _buildQuestionarios() {
    if (!ordenado) {
      questionarios = _dataSource.questionarios;
    }

    if (category != "all") {
      List<QuestionarioDetails> questionariosFiltered = questionarios
          .where((questionario) => questionario.modo == category)
          .toList();
      questionarios = questionariosFiltered;
    } else {
      List<QuestionarioDetails> questionariosFiltered = questionarios
          .where((questionario) => questionario.modo != "questionario")
          .toList();
      questionarios = questionariosFiltered;
    }

    return ListView.builder(
      itemCount: questionarios.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return QuizCard(
          questionario:questionarios[index],
            onTap: () => _navigateToQuiz(context, questionarios[index].id.toString()));
      },
    );
  }

  void _navigateToQuiz(BuildContext context, String id) {
    Provider.of<Services>(context, listen: false).loadActiveQuiz(int.parse(id));
    Get.to(() => QuizInitialPage());
  }

  void _orderBy(String type) {
    switch (type) {
      case "date_asc":
        {
          setState(() {
            questionarios
                .sort((x, y) => x.dataDeCriacao.compareTo(y.dataDeCriacao));
            questionarios.forEach((element) {
              print(element.titulo);
            });
          });
          date_asc = true;
        }
        break;
      case "date_dsc":
        {
          setState(() {
            questionarios
                .sort((x, y) => y.dataDeCriacao.compareTo(x.dataDeCriacao));
            questionarios.forEach((element) {
              print(element.titulo);
            });
          });
          date_asc = false;
        }
        break;
      case "dif_asc":
        {
          setState(() {
            questionarios
                .sort((x, y) => y.dificuldade.compareTo(x.dificuldade));
          });
          dif_asc = true;
        }
        break;
      case "dif_dsc":
        {
          setState(() {
            questionarios
                .sort((x, y) => x.dificuldade.compareTo(y.dificuldade));
          });
          dif_asc = false;
        }
        break;
      case "title_asc":
        {
          setState(() {
            questionarios.sort((x, y) => x.titulo.compareTo(y.titulo));
          });
          title_asc = true;
        }
        break;
      case "title_dsc":
        {
          setState(() {
            questionarios.sort((x, y) => y.titulo.compareTo(x.titulo));
          });
          title_asc = false;
        }
        break;
    }
    ordenado = true;
  }
}
