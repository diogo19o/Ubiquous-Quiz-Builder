import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/data/access_service_api.dart';
import 'package:ubiquous_quizz_builder/models/questionario_details.dart';
import 'package:ubiquous_quizz_builder/screens/home/components/bottom_nav_bar.dart';
import 'package:ubiquous_quizz_builder/screens/quiz/quiz_initial_page.dart';

import '../single_post_test.dart';

class ListQuestionarios extends StatefulWidget {
  String category;

  ListQuestionarios(this.category);

  @override
  _ListQuestionariosState createState() =>
      _ListQuestionariosState(this.category);
}

class _ListQuestionariosState extends State<ListQuestionarios> {
  _ListQuestionariosState(this.category);

  String category;

  Widget setPageTitle() {
    switch (category) {
      case "all":
        return Text("Todos os modos de jogo");
        break;
      case "questionario":
        return Text("Modo Questionário");
        break;
      case "classico":
        return Text("Modo Clássico");
        break;
      case "contra_relogio":
        return Text("Modo Contra-Relógio");
        break;
      case "morte_subita":
        return Text("Modo Morte Súbita");
        break;
      default:
        return Text("Modo Morte-Súbita");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PrimaryDarkBlue,
        elevation: 0,
        title: setPageTitle(),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.backgroudFade),
        child: /*Stack(children: [*/_buildBody(context)/*, CurvedBottomNavBar()])*/,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(MdiIcons.sortVariant),
        onPressed: () async {
          final response = await Provider.of<Services>(context, listen: false)
              .userService
              .loginUser({
            "action": "login",
            "username": "diogo",
            "password": "47da36337c9140e2e9f1517a0ddeb0025e0c3310",
          });

          print(response.runtimeType);

          print(
              "Resultado do Login (0=sucesso): ${json.decode(response.bodyString)['result']}");
        },
      ),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    // FutureBuilder is perfect for easily building UI when awaiting a Future
    // Response is the type currently returned by all the methods of PostApiService
    return FutureBuilder<Response>(
      future: Provider.of<Services>(context, listen: false)
          .userService
          .getAll("questionarios"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Snapshot's data is the Response
          // You can see there's no type safety here (only List<dynamic>)
          print(snapshot.data);
          final List questionarios =
              json.decode(snapshot.data.bodyString)['questionarios'];
          return _buildQuestionarios(context, questionarios);
        } else {
          // Show a loading indicator while waiting for the posts
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildQuestionarios(BuildContext context, List posts) {
    List<QuestionarioDetails> questionarios =
        Provider.of<Services>(context, listen: false).dataSource.questionarios;

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
        return Card(
          elevation: 4,
          child: ListTile(
            contentPadding: EdgeInsets.all(5),
            title: Text(
              questionarios[index].titulo,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Dificuldade: ${questionarios[index].dificuldade}\nData de criação: ${questionarios[index].dataDeCriacao}"),
            onTap: () =>
                _navigateToPost(context, questionarios[index].id.toString()),
          ),
        );
      },
    );
  }

  void _navigateToPost(BuildContext context, String id) {
    Provider.of<Services>(context, listen: false).loadActiveQuiz(int.parse(id));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
    );
  }
}
