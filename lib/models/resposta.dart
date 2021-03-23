import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final Function selectHandler;
  final String textoResposta;

  Resposta(this.selectHandler, this.textoResposta);

  @override
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
  }
}
