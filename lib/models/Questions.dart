import 'package:flutter/cupertino.dart';
import 'package:ubiquous_quizz_builder/models/pergunta.dart';
import 'package:ubiquous_quizz_builder/models/questionario_details.dart';
import 'package:ubiquous_quizz_builder/models/resposta.dart';

class Questionario {
  final int id;
  final QuestionarioDetails questionarioDetails;
  final List<Pergunta> perguntas;
  final List<Resposta> respostas;

  Questionario({@required this.id,@required this.questionarioDetails,@required this.perguntas,@required this.respostas});
}