import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

part 'resposta.g.dart';

@JsonSerializable()
class Resposta /*extends StatelessWidget*/ {
  //final Function selectHandler;

  @JsonKey(name: 'RespostaID', fromJson:_stringToInt, toJson: _stringFromInt)
  final int id;
  @JsonKey(name: 'Texto')
  final String texto;
  @JsonKey(name: 'Correta', fromJson:_stringToBool, toJson: _stringFromBool)
  final bool correta;
  @JsonKey(name: 'PerguntaID', fromJson:_stringToInt, toJson: _stringFromInt)
  final int perguntaID;

  Resposta({this.id, this.texto, this.correta, this.perguntaID});

  factory Resposta.fromJson(Map<String, dynamic> json) => _$RespostaFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$RespostaToJson(this);


  static bool _stringToBool(String number) => number == "1" ? true : false;
  static String _stringFromBool(bool number) => number ? "1" : "0";

  static int _stringToInt(String number) => number == null ? null : int.parse(number);
  static String _stringFromInt(int number) => number?.toString();

/*@override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(textoResposta),
        onPressed: selectHandler,
      ),
    );
  }*/
}
