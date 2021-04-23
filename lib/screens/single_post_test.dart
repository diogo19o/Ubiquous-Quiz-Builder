import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ubiquous_quizz_builder/data/access_service_api.dart';
import 'package:ubiquous_quizz_builder/data/questionario_service_api.dart';
import 'package:ubiquous_quizz_builder/models/questionario_teste.dart';


class SinglePostPage extends StatelessWidget {
  final String postId;

  const SinglePostPage({
    Key key,
    this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chopper Blog'),
      ),
      body: FutureBuilder<Response<Teste>>(
        future: Provider.of<Services>(context, listen: false).questionarioService.getQuestionario(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.3,
                ),
              );
            }

            print("Type: ${snapshot.data.body.runtimeType}");
            final Map post = json.decode(snapshot.data.bodyString);
            print(post.toString());
            final testeQuestionario = snapshot.data.body;
            return _buildMovieList(context,testeQuestionario);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  ListView _buildMovieList(BuildContext context, Teste questionario) {
    return ListView.builder(
      itemCount: questionario.perguntas.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 200,
                    child: Column(
                      children: <Widget>[
                        Text(questionario.perguntas[index].texto,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                            child: Container(
                                child: Text(
                                  "${questionario.perguntas[index].texto} ${questionario.perguntas[index].questionarioID}",
                                  style: TextStyle(fontSize: 12),
                                ))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Text _buildPost(Map post) {
    return /*Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            post['perguntasDoQuestionario'][0]['Texto'],
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(post['perguntasDoQuestionario'][0]['1']),
        ],
      ),
    );*/ Text(post['perguntasDoQuestionario'][0]['Texto']);
  }
}
