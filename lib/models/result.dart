import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
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
  }
}
