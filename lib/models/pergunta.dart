import 'package:flutter/material.dart';

class Pergunta extends StatelessWidget {
  final String textoPergunta;

  Pergunta(this.textoPergunta);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Text(
          textoPergunta,
          style: TextStyle(fontSize: 28),
          textAlign: TextAlign.center,
        ));
  }
}
