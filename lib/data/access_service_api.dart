import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/data/questionario_service_api.dart';
import 'package:ubiquous_quizz_builder/data/user_service_api.dart';
import 'package:ubiquous_quizz_builder/models/Questions.dart';
import 'package:ubiquous_quizz_builder/models/pergunta.dart';
import 'package:ubiquous_quizz_builder/models/questionario_details.dart';
import 'package:ubiquous_quizz_builder/models/resposta.dart';
import 'package:ubiquous_quizz_builder/models/resultado.dart';
import 'package:ubiquous_quizz_builder/models/utilizador.dart';

class Services {
  static final Services _services = Services._internal();

  DataSource dataSource = DataSource();

  UserService userService = UserService.create();
  QuestionarioService questionarioService = QuestionarioService.create();

  Future<void> fetchData(String dataType) async {
    var mapData;

    if (dataType != "all") {
      var response = await userService.getAll(dataType);
      mapData = json.decode(response.bodyString);
    }

    switch (dataType) {
      case "questionarios":
        {
          dataSource.setQuestionarios = List<QuestionarioDetails>.from(
              mapData[dataType].map((questionarioJSON) =>
                  QuestionarioDetails.fromJson(questionarioJSON)));
        }
        break;

      case "perguntas":
        {
          dataSource.setPerguntas = List<Pergunta>.from(mapData[dataType]
              .map((perguntaJSON) => Pergunta.fromJson(perguntaJSON)));
        }
        break;

      case "respostas":
        {
          dataSource.setRespostas = List<Resposta>.from(mapData[dataType]
              .map((respostaJSON) => Resposta.fromJson(respostaJSON)));
        }
        break;

      case "resultados":
        {
          dataSource.setResultados = List<Result>.from(mapData[dataType]
              .map((resultadosJSON) => Result.fromJson(resultadosJSON)));
        }
        break;

      case "utilizadores":
        {
          dataSource.setUtilizadores = List<Utilizador>.from(mapData[dataType]
              .map((utilizadorJSON) => Utilizador.fromJson(utilizadorJSON)));
        }
        break;

      case "all":
        {
          await fetchData("questionarios");
          await fetchData("perguntas");
          await fetchData("respostas");
          await fetchData("resultados");
          await fetchData("utilizadores");
        }
        break;

      default:
        {
          print("Opção de data inválida!");
        }
        break;
    }
  }

  void loadActiveQuiz(int id) {
    List<int> idsPerguntas = [];

    QuestionarioDetails questionarioDetails =
        dataSource.questionarios.where((element) => element.id == id).single;

    List<Pergunta> perguntas = dataSource.perguntas.where((pergunta) {
      if (pergunta.questionarioID == id) {
        idsPerguntas.add(pergunta.id);
        return true;
      }
      return false;
    }).toList();

    List<Resposta> respostas = dataSource.respostas.where((resposta) {
      if (idsPerguntas.contains(resposta.perguntaID)) {
        return true;
      }
      return false;
    }).toList();

    dataSource.questionarioAtivo = Questionario(
        id: id,
        questionarioDetails: questionarioDetails,
        perguntas: perguntas,
        respostas: respostas);
  }

  void loadActiveUser(String username) {
    dataSource.setUtilizadorAtivo = dataSource.utilizadores
        .where((element) => element.nome == username)
        .single;
  }

  Future<Response> login(String username, String password) {
    return userService.loginUser({
      "action": "login",
      "username": username,
      "password": password,
    });
  }

  Future<Response> register(String username, String email, String password) {
    return userService.registerUser({
      "action": "add",
      "username": username,
      "email": email,
      "password": password,
    });
  }

  factory Services() {
    return _services;
  }

  Services._internal();
}
