import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

part 'resultado.g.dart';

@JsonSerializable()
class Result /*extends StatelessWidget*/ {

  @JsonKey(name: 'ResultadoID', fromJson:_stringToInt, toJson: _stringFromInt)
  final int id;
  @JsonKey(name: 'UtilizasdorID', fromJson:_stringToInt, toJson: _stringFromInt)
  final int utilizadorID;
  @JsonKey(name: 'QuestionarioID', fromJson:_stringToInt, toJson: _stringFromInt)
  final int questionarioID;
  @JsonKey(name: 'RespostasCertas', fromJson:_stringToInt, toJson: _stringFromInt)
  final int respostasCorretas;
  @JsonKey(name: 'RespostasErradas', fromJson:_stringToInt, toJson: _stringFromInt)
  final int respostasErradas;
  @JsonKey(name: 'Score', fromJson:_stringToInt, toJson: _stringFromInt)
  final int score;
  @JsonKey(name: 'DataDeCriacao')
  final String dataDeCriacao;
  @JsonKey(name: 'Modo')
  final String modo;

  Result({this.id, this.utilizadorID, this.questionarioID, this.respostasCorretas,
      this.respostasErradas, this.score, this.dataDeCriacao, this.modo});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$ResultToJson(this);


  static int _stringToInt(String number) => number == null ? null : int.parse(number);
  static String _stringFromInt(int number) => number?.toString();


/*final int resultScore;
  final Function resetQuizHandler;

  Result(this.resultScore, this.resetQuizHandler);

  String get resultPhrase {
    var resultText;
    if (resultScore <= 8) {
      resultText = 'És uma máquina mas humilde!';
    } else if (resultScore <= 12) {
      resultText = 'Nada mau!';
    } else if (resultScore <= 16) {
      resultText = 'Mehhh!';
    } else {
      resultText = 'És péssimo!';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: Text('Restart Quiz!'),
            onPressed: resetQuizHandler,
          )
        ],
      ),
    );
  }*/
}
