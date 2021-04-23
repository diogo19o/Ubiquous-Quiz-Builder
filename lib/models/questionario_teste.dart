import 'package:json_annotation/json_annotation.dart';
import 'package:ubiquous_quizz_builder/models/pergunta.dart';

part 'questionario_teste.g.dart';

@JsonSerializable()
class Teste {

  @JsonKey(name: 'perguntasDoQuestionario')
  List<Pergunta> perguntas;

  Teste({this.perguntas});

  factory Teste.fromJson(Map<String, dynamic> json) => _$TesteFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$TesteToJson(this);
}