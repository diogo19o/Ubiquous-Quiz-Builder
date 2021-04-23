import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pergunta.g.dart';

@JsonSerializable()
class Pergunta /*extends StatelessWidget*/ {

  @JsonKey(name: 'PerguntaID', fromJson:_stringToInt, toJson: _stringFromInt)
  int id;
  @JsonKey(name: 'Texto')
  final String texto;
  @JsonKey(name: 'Resposta', fromJson:_stringToInt, toJson: _stringFromInt)
  final int resposta;
  @JsonKey(name: 'QuestionarioID', fromJson:_stringToInt, toJson: _stringFromInt)
  final int questionarioID;

  //final int respostaID;

  Pergunta(
  {this.id, this.texto, this.resposta, this.questionarioID});

  factory Pergunta.fromJson(Map<String, dynamic> json) => _$PerguntaFromJson(json);

  Map<String, dynamic> toJson() => _$PerguntaToJson(this);

  static int _stringToInt(String number) => number == null ? null : int.parse(number);
  static String _stringFromInt(int number) => number?.toString();


  /*@override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Text(
          textoPergunta,
          style: TextStyle(fontSize: 28),
          textAlign: TextAlign.center,
        ));
  }*/
}
