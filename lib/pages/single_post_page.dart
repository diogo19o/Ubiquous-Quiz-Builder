import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ubiquous_quizz_builder/data/questionario_service_api.dart';


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
      body: FutureBuilder<Response>(
        future: Provider.of<ChopperClient>(context).getService<QuestionarioService>().getQuestionario(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final Map post = json.decode(snapshot.data.bodyString);
            print(post.toString());
            return _buildPost(post);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
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
