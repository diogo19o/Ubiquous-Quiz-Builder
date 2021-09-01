import 'dart:typed_data';

import 'package:ubiquous_quizz_builder/models/Questions.dart';
import 'package:ubiquous_quizz_builder/models/pergunta.dart';
import 'package:ubiquous_quizz_builder/models/questionario_details.dart';
import 'package:ubiquous_quizz_builder/models/ranking_user.dart';
import 'package:ubiquous_quizz_builder/models/resposta.dart';
import 'package:ubiquous_quizz_builder/models/resultado.dart';
import 'package:ubiquous_quizz_builder/models/utilizador.dart';

class DataSource {
  static final DataSource _dataSource = DataSource._internal();

  bool initialDataFetched = false;
  bool connected = false;

  List<QuestionarioDetails> _questionarios = [];
  List<QuestionarioDetails> get questionarios => _questionarios;

  List<Pergunta> _perguntas = [];
  List<Pergunta> get perguntas => _perguntas;

  List<Resposta> _respostas = [];
  List<Resposta> get respostas => _respostas;

  List<Result> _resultados = [];
  List<Result> get resultados => _resultados;

  List<Utilizador> _utilizadores = [];
  List<Utilizador> get utilizadores => _utilizadores;

  List<UtilizadorRanking> _utilizadoresRanking = [];
  List<UtilizadorRanking> get utilizadoresRanking => _utilizadoresRanking;

  Questionario _questionarioAtivo;

  Questionario get questionarioAtivo => _questionarioAtivo;

  Utilizador _utilizadorAtivo;
  Utilizador get utilizadorAtivo => _utilizadorAtivo;

  Uint8List imageBytes;

  set questionarioAtivo(Questionario questionario) {
    this._questionarioAtivo = questionario;
  }

  set setQuestionarios(List<QuestionarioDetails> questionarioDetails) {
    this._questionarios = questionarioDetails;
  }

  set setPerguntas(List<Pergunta> perguntas) {
    this._perguntas = perguntas;
  }

  set setRespostas(List<Resposta> respostas) {
    this._respostas = respostas;
  }

  set setResultados(List<Result> resultados) {
    this._resultados = resultados;
  }

  set setUtilizadores(List<Utilizador> utilizadores) {
    this._utilizadores = utilizadores;
  }
  set setUtilizadoresRanking(List<UtilizadorRanking> utilizadores) {
    this._utilizadoresRanking = utilizadores;
  }

  set setUtilizadorAtivo(Utilizador utilizador) {
    this._utilizadorAtivo = utilizador;
  }

  factory DataSource() {
    return _dataSource;
  }

  DataSource._internal();

}
