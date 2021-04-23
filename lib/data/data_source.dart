import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:ubiquous_quizz_builder/data/questionario_service_api.dart';
import 'package:ubiquous_quizz_builder/data/user_service_api.dart';
import 'package:ubiquous_quizz_builder/models/Questions.dart';
import 'package:ubiquous_quizz_builder/models/pergunta.dart';
import 'package:ubiquous_quizz_builder/models/questionario_details.dart';
import 'package:ubiquous_quizz_builder/models/resposta.dart';
import 'package:ubiquous_quizz_builder/models/resultado.dart';
import 'package:ubiquous_quizz_builder/models/utilizador.dart';

class DataSource {
  static final DataSource _dataSource = DataSource._internal();

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

  Questionario _questionarioAtivo;

  Questionario get questionarioAtivo => _questionarioAtivo;

  Utilizador _utilizadorAtivo;
  Utilizador get utilizadorAtivo => _utilizadorAtivo;

  void set questionarioAtivo(Questionario questionario) {
    this._questionarioAtivo = questionario;
  }

  void set setQuestionarios(List<QuestionarioDetails> questionarioDetails) {
    this._questionarios = questionarioDetails;
  }

  void set setPerguntas(List<Pergunta> perguntas) {
    this._perguntas = perguntas;
  }

  void set setRespostas(List<Resposta> respostas) {
    this._respostas = respostas;
  }

  void set setResultados(List<Result> resultados) {
    this._resultados = resultados;
  }

  void set setUtilizadores(List<Utilizador> utilizadores) {
    this._utilizadores = utilizadores;
  }

  set setUtilizadorAtivo(Utilizador utilizador) {
    this._utilizadorAtivo = utilizador;
  }

  factory DataSource() {
    return _dataSource;
  }

  DataSource._internal();

}
