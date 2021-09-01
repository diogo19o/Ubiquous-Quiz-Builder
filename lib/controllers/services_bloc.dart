import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:chopper/chopper.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/data/user_service_api.dart';
import 'package:ubiquous_quizz_builder/models/Questions.dart';
import 'package:ubiquous_quizz_builder/models/imagem.dart';
import 'package:ubiquous_quizz_builder/models/pergunta.dart';
import 'package:ubiquous_quizz_builder/models/questionario_details.dart';
import 'package:ubiquous_quizz_builder/models/ranking_user.dart';
import 'package:ubiquous_quizz_builder/models/resposta.dart';
import 'package:ubiquous_quizz_builder/models/resultado.dart';
import 'package:ubiquous_quizz_builder/models/utilizador.dart';

import '../data/api_response.dart';
import 'app_exceptions.dart';

class Services {
  static final Services _services = Services._internal();

  factory Services() {
    return _services;
  }

  Services._internal();

  DataSource dataSource = DataSource();
  UserService userService = UserService.create();

  StreamController _quizListController =
      BehaviorSubject<ApiResponse<List<QuestionarioDetails>>>();

  StreamController _quizResultsController =
      BehaviorSubject<ApiResponse<List<UtilizadorRanking>>>();

  StreamSink<ApiResponse<List<QuestionarioDetails>>> get quizListSink =>
      _quizListController.sink;

  Stream<ApiResponse<List<QuestionarioDetails>>> get quizListStream =>
      _quizListController.stream;

  StreamSink<ApiResponse<List<UtilizadorRanking>>> get quizResultsSink =>
      _quizResultsController.sink;

  Stream<ApiResponse<List<UtilizadorRanking>>> get quizResultsStream =>
      _quizResultsController.stream;

  dispose() {
    _quizListController?.close();
    _quizResultsController?.close();
  }

  sendResultToServer(Map<String, dynamic> data) async {
    try {
      final response = await userService.sendResults(data);
    } on SocketException {
      throw FetchDataException('No Internet connection to the Server');
    } catch (e) {
      throw e;
    }
  }

  bool jaRespondeuQuestionario() {
    for (Result res in dataSource.resultados) {
      if (res.questionarioID == dataSource.questionarioAtivo.id &&
          res.utilizadorID == dataSource.utilizadorAtivo.id) {
        return true;
      }
    }
    return false;
  }

  fetchQuizList() async {
    quizListSink.add(ApiResponse.loading('Fetching Questionários'));
    try {
      await fetchData("questionarios");
      List<QuestionarioDetails> quizzes = dataSource.questionarios;
      quizListSink.add(ApiResponse.completed(quizzes));
    } catch (e) {
      quizListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchLocalQuizList() {
    if (dataSource.questionarios.isNotEmpty) {
      quizListSink.add(ApiResponse.completed(dataSource.questionarios));
    } else {
      quizListSink
          .add(ApiResponse.error("Não existe nenhum questionário carregado!"));
    }
  }

  fetchResultsList() async {
    print("Dentro do fetchResults");
    quizResultsSink.add(ApiResponse.loading('Fetching Resultados'));
    try {
      await fetchData("resultados");
      quizResultsSink
          .add(ApiResponse.completed(dataSource.utilizadoresRanking));
    } catch (e) {
      quizResultsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchLocalResultsList() {
    if (dataSource.questionarios.isNotEmpty) {
      quizResultsSink
          .add(ApiResponse.completed(dataSource.utilizadoresRanking));
    } else {
      quizResultsSink
          .add(ApiResponse.error("Não existe nenhum resultado carregado!"));
    }
  }

  Future<dynamic> checkForImages() async {
    for (var pergunta in dataSource.questionarioAtivo.perguntas) {
      if (pergunta.nomeImagem != null) {
        pergunta.imagem = await getImage(pergunta.nomeImagem, pergunta.id);
      }
    }
  }

  Future<Imagem> getImage(String imageName, int idPergunta) async {
    var responseJson;
    try {
      final response = await userService.getImage(imageName);
      responseJson = _returnResponse(response);
      print(responseJson["imagem"]);
      const Base64Codec base64 = Base64Codec();
      Uint8List imageBytes = base64.decode(responseJson["imagem"]);
      dataSource.imageBytes = imageBytes;
      dataSource.connected = true;
      Imagem imagem = Imagem(idPergunta, imageBytes);
      return imagem;
    } on SocketException {
      dataSource.connected = false;
      throw FetchDataException('No Internet connection to the Server');
    } catch (e) {
      dataSource.connected = false;
      throw e;
    }
  }

  Future<dynamic> fetchData(String dataType) async {
    var responseJson;

    try {
      if (dataType != "all") {
        final response = await userService.getAll(dataType);
        responseJson = _returnResponse(response);
      }
      await computeRequest(dataType, responseJson);
    } on SocketException {
      throw FetchDataException('No Internet connection to the Server');
    } catch (e) {
      throw e;
    }
    return responseJson;
  }

  Future computeRequest(String dataType, mapData) async {
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
          joinUsersResults();
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
          try {
            await fetchData("questionarios");
            await fetchData("perguntas");
            await fetchData("respostas");
            await fetchData("resultados");
            await fetchData("utilizadores");
          } catch (e) {
            throw e;
          }
        }
        break;

      default:
        {
          print("Opção de data inválida!");
        }
        break;
    }
  }

  void joinUsersResults() {
    for (var result in dataSource.resultados) {
      UtilizadorRanking userRankExistente = dataSource.utilizadoresRanking
          .singleWhere(
              (element)=> element.utilizador.id == result.utilizadorID,
              orElse: () => null);

      if (userRankExistente != null) {
        //Ja existe um utilizador na lista de ranking com o id do user

        List<Result> resultados = userRankExistente.resultadosC +
            userRankExistente.resultadosMS +
            userRankExistente.resultadosCR;

        if (!resultados.contains(result)) {
          addResultToRightList(result, userRankExistente);
          /*
          print(
              "Ja existe id: ${userRankExistente.utilizador.id}, nome: ${userRankExistente.utilizador.nome}, Questionarios: ");
          userRankExistente.resultadosC.forEach((element) {
            print(
                "ID - Questinario Class do ${userRankExistente.utilizador.nome}, idQues ${element.questionarioID}, score: ${element.score}");
          });
          userRankExistente.resultadosMS.forEach((element) {
            print(
                "ID - Questinario Morte do ${userRankExistente.utilizador.nome}, idQues ${element.questionarioID}, score: ${element.score}");
          });
          userRankExistente.resultadosCR.forEach((element) {
            print(
                "ID - Questinario Relo do ${userRankExistente.utilizador.nome}, idQues ${element.questionarioID}, score: ${element.score}");
          });*/
        }
      } else if (userRankExistente == null) {
        //Ainda nao existe nenhum dado do utilizador que respondeu a este questionario na lista para o ranking
        Utilizador userTemp = dataSource.utilizadores
            .where((element) => element.id == result.utilizadorID)
            .single;
        UtilizadorRanking userRankTemp = UtilizadorRanking(userTemp);

        addResultToRightList(result, userRankTemp);
        dataSource.utilizadoresRanking.add(userRankTemp);
        /*
        print(
            "Adicionado user id: ${userRankTemp.utilizador.id}, nome: ${userRankTemp.utilizador.nome}");

        userRankTemp.resultadosC.forEach((element) {
          print(
              "ID - Questinario Class, score: ${element.score}");
        });
        userRankTemp.resultadosMS.forEach((element) {
          print(
              "ID - Questinario Morte, score: ${element.score}");
        });
        userRankTemp.resultadosCR.forEach((element) {
          print(
              "ID - Questinario Relo, score: ${element.score}");
        });*/
      }
      //Senao quer dizer que o resultado ja foi registado
    }
  }

  void addResultToRightList(Result result, UtilizadorRanking user) {
    switch (result.modo) {
      case "classico":
        user.resultadosC.add(result);
        user.resultadosC.sort((a, b) => b.score.compareTo(a.score));
        break;
      case "morte_subita":
        user.resultadosMS.add(result);
        user.resultadosMS.sort((a, b) => b.score.compareTo(a.score));
        break;
      case "contra_relogio":
        user.resultadosCR.add(result);
        user.resultadosCR.sort((a, b) => b.score.compareTo(a.score));
        break;
    }
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.bodyString);
        return responseJson;
      case 400:
        throw BadRequestException(response.bodyString);
      case 401:
      case 403:
        throw UnauthorisedException(response.bodyString);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<dynamic> login(String username, String password) async {
    try {
      final response = await userService.loginUser({
        "action": "login",
        "username": username,
        "password": password,
      });
      var responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet connection to the Server');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> register(
      String username, String email, String password) async {
    try {
      final response = await userService.registerUser({
        "action": "add",
        "username": username,
        "email": email,
        "password": password,
      });
      var responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet connection to the Server');
    } catch (e) {
      print(e.toString());
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

  Future<void> loadActiveUser(String username) async {
    if (dataSource.utilizadores.isEmpty) {
      try {
        await fetchData("utilizadores");
      } on SocketException {
        throw FetchDataException('No Internet connection to the Server');
      } catch (e) {
        throw e;
      }
    }
    dataSource.setUtilizadorAtivo = dataSource.utilizadores
        .where((element) => element.nome == username)
        .single;
  }

  Map<String, double> calcTotalPoints() {
    double totalClassico = 0;
    double totalMorteSubita = 0;
    double totalContraRelogio = 0;

    UtilizadorRanking user = dataSource.utilizadoresRanking.firstWhere(
        (element) => element.utilizador.id == dataSource.utilizadorAtivo.id);

    for (Result res in user.resultadosC) {
      totalClassico += res.score;
    }
    for (Result res in user.resultadosCR) {
      totalContraRelogio += res.score;
    }
    for (Result res in user.resultadosMS) {
      totalMorteSubita += res.score;
    }

    return {
      "Clássico": totalClassico,
      "Morte Súbita": totalMorteSubita,
      "Contra Relógio": totalContraRelogio
    };
  }

  List<dynamic> calcProfileData() {
    int totalJogos = 0;
    int respostasCertas = 0;
    int respostasErradas = 0;
    double percentagemAcerto = 0;

    UtilizadorRanking user = dataSource.utilizadoresRanking.firstWhere(
        (element) => element.utilizador.id == dataSource.utilizadorAtivo.id);

    totalJogos = user.resultadosMS.length +
        user.resultadosCR.length +
        user.resultadosC.length;

    for (Result res in user.resultadosC) {
      respostasCertas += res.respostasCorretas;
      respostasErradas += res.respostasErradas;
    }
    for (Result res in user.resultadosCR) {
      respostasCertas += res.respostasCorretas;
      respostasErradas += res.respostasErradas;
    }
    for (Result res in user.resultadosMS) {
      respostasCertas += res.respostasCorretas;
      respostasErradas += res.respostasErradas;
    }

    percentagemAcerto =
        respostasCertas / (respostasCertas + respostasErradas) * 100;

    return [totalJogos, respostasCertas, respostasErradas, percentagemAcerto];
  }
}
