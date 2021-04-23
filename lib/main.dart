/*
import 'package:flutter/material.dart';
import 'package:ubiquous_quizz_builder/models/quiz.dart';
import 'package:ubiquous_quizz_builder/models/resultado.dart';
import 'package:ubiquous_quizz_builder/models/album.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _perguntaIndex = 0;
  var _totalScore = 0;
  final _perguntas = const [
    {
      'textoPergunta': 'Qual é a tua cor favorita?',
      'respostas': [
        {'text': 'Preto', 'score': 10},
        {'text': 'Vermelho', 'score': 6},
        {'text': 'Verde', 'score': 3},
        {'text': 'Branco', 'score': 1}
      ]
    },
    {
      'textoPergunta': 'Qual é o teu animal favorito?',
      'respostas': [
        {'text': 'Gato', 'score': 10},
        {'text': 'Cão', 'score': 6},
        {'text': 'Cavalo', 'score': 3},
        {'text': 'Coelho', 'score': 1}
      ]
    },
    {
      'textoPergunta': 'Qual é a tua linguagem favorita?',
      'respostas': [
        {'text': 'Java', 'score': 10},
        {'text': 'C', 'score': 6},
        {'text': 'Dart', 'score': 3},
        {'text': 'Kotlin', 'score': 1}
      ]
    }
  ];

  void _responderPergunta(int score) {
    setState(() {
      _perguntaIndex++;
      _totalScore += score;
    });
    print(_perguntaIndex);
  }

  void _resetQuiz() {
    setState(() {
      _perguntaIndex = 0;
      _totalScore = 0;
    });
  }

  Future<Album> futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('My First App'),
      ),
      body: _perguntaIndex < _perguntas.length
          ? Quiz(
              responderPergunta: _responderPergunta,
              perguntaIndex: _perguntaIndex,
              perguntas: _perguntas,
            )
          : Result(_totalScore, _resetQuiz),
      /*Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.id);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),*/
    ));
  }

  Future<Album> getDataTest() async {
    //192.168.1.70
    print('ola teste!\n');
    /*var url =
        'http://192.168.1.70/TFC/AndroidQuizBuilder-master/php/www/teste.php?action=pergunta&PerguntaID=6';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    print("text: " + data.toString());
    print("value: " + data['respostasDaPergunta'][0]['RespostaID']);*/
    var url =
    'http://192.168.1.70/TFC/AndroidQuizBuilder-master/php/www/teste.php?action=questionarios';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    print("text: " + data.toString());
    print("Size: ${data.toString().length}");

    return Album.fromJson(data);
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = getDataTest();
  }
}
*/

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:ubiquous_quizz_builder/data/access_service_api.dart';
import 'package:ubiquous_quizz_builder/screens/login/login_page.dart';

void main() {

  Services services = Services();
  services.fetchData("all")/*.then((value) {
    DataSource dataSource = DataSource();
    print(dataSource.questionarios[0].titulo);
    print(dataSource.perguntas.toString());
    print(dataSource.respostas.toString());
    print(dataSource.resultados.toString());
    print(dataSource.utilizadores.toString());
  })*/;

  _setupLogging();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Services services = Services();

  @override
  Widget build(BuildContext context) {
    var bytes = utf8.encode("diogo"); // data being hashed

    var digest = sha1.convert(bytes);

    print("Digest as bytes: ${digest.bytes}");
    print("Digest as hex string: $digest");

    return Provider(
      create: (_) => services,
      child: GetMaterialApp(
        title: "Material App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF2661FA),
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
      ),
    );
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
