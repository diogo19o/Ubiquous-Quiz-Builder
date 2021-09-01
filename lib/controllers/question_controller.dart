import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:ubiquous_quizz_builder/controllers/services_bloc.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/models/pergunta.dart';
import 'package:ubiquous_quizz_builder/models/questionario_details.dart';
import 'package:ubiquous_quizz_builder/models/ranking_user.dart';
import 'package:ubiquous_quizz_builder/models/resultado.dart';
import 'package:ubiquous_quizz_builder/screens/quiz/score_screen.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Lets animated our progress bar

  QuestionController({this.quizMode}) {
    cleanController();
  }

  //Modo do questionario
  // 0 -> Classico
  // 1 -> Contra-Relogio
  // 2 -> Morte Subita
  // 3 -> Questionario
  int quizMode;

  bool _fail = false;

  int _score = 0, _timeMins, _timeSecs;

  AnimationController _animationController;
  Animation _animation;

  // so that we can access our animation outside
  Animation get animation => this._animation;

  PageController _pageController;

  PageController get pageController => this._pageController;

  DataSource dataSource = DataSource();

  Services _services = Services();

  List<Pergunta> _questions;

  List<Pergunta> get questions => this._questions;

  List<int> _answerTimes = [];

  bool _isAnswered = false;

  bool get isAnswered => this._isAnswered;

  int _correctAns;

  int get correctAns => this._correctAns;

  int _selectedAns;

  int get selectedAns => this._selectedAns;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;

  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;

  int get numOfCorrectAns => this._numOfCorrectAns;

  bool _newHighScore = false;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    int time;
    _timeMins = dataSource.questionarioAtivo.questionarioDetails.timerMinutos;
    _timeSecs = dataSource.questionarioAtivo.questionarioDetails.timerSegundos;

    if (_timeMins != 0 || _timeSecs != 0) {
      time = (_timeMins * 60 * 1000) + (_timeSecs * 1000);
    }

    if (quizMode != 3) {
      // Encher progress bar com o tempo de cada questionário
      _animationController = AnimationController(
          duration: Duration(minutes: _timeMins, seconds: _timeSecs),
          vsync: this);
      _animation = Tween<double>(begin: 1, end: 0).animate(_animationController)
        ..addListener(() {
          // update like setState
          update();
        });

      // Começar a animacao
      // No fim da animacao passa para a próxima pergunta
      _animationController.forward().whenComplete(nextQuestion);
    }
    _pageController = PageController();

    _questions = dataSource.questionarioAtivo.perguntas;

    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void resetQuestionNumber() => _questionNumber.value = 1;

  void cleanController() {
    super.onClose();
    super.onInit();
  }

  void checkAns(Pergunta question, int selectedIndex, int correctAnswer) {
    // because once user press any option then it will run
    _isAnswered = true;
    _correctAns = correctAnswer;
    _selectedAns = selectedIndex;

    if (quizMode != 3) {
      if (_correctAns == _selectedAns) {
        _numOfCorrectAns++;
        int totalTime = (_timeMins * 60 + _timeSecs);
        int timeLeft =
            (totalTime - _animationController.value * totalTime).round();
        //Se nao for modo contra relogio
        if (quizMode != 1) {
          _score += (timeLeft * 10).toInt();
        } else {
          _score = (timeLeft * 10).toInt();
        }
      } else if (quizMode == 2) {
        //Modo morte subita entao parar o questionario
        _fail = true;
      }

      //print("Duration: ${_animationController.lastElapsedDuration.inMilliseconds}");
      _answerTimes.add(_animationController.lastElapsedDuration.inMilliseconds);

      // It will stop the counter
      _animationController.stop();
    }

    update();

    // Once user select an ans after 3s it will go to the next qn
    Future.delayed(Duration(seconds: 5), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length && !_fail) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      if (quizMode != 3) {
        if (quizMode == 1) {
          // Contra-Relógio
          _animationController.repeat();
        } else {
          // Classico
          // Morte subita
          // Reset the counter
          _animationController.reset();
        }

        // Once timer is finish go to the next qn
        _animationController.forward().whenComplete(nextQuestion);
      }
    } else {

      Map<String, String> mapResultado;
      Map<String, dynamic> quizStatus;

      //Se nao for modo questionario verifica se bateu o recorde pessoal
      if (quizMode != 3) {
        UtilizadorRanking user = dataSource.utilizadoresRanking
            .singleWhere((element) =>
                element.utilizador.id == dataSource.utilizadorAtivo.id,
            orElse: () => UtilizadorRanking(dataSource.utilizadorAtivo));
        List<Result> tempResults;
        switch (quizMode) {
          case 0:
            {
              tempResults = user.resultadosC
                  .where((element) =>
                      element.questionarioID == dataSource.questionarioAtivo.id)
                  .toList();
              break;
            }
          case 1:
            {
              tempResults = user.resultadosCR
                  .where((element) =>
                      element.questionarioID == dataSource.questionarioAtivo.id)
                  .toList();
              break;
            }
          case 2:
            {
              tempResults = user.resultadosMS
                  .where((element) =>
                      element.questionarioID == dataSource.questionarioAtivo.id)
                  .toList();
              break;
            }
        }

        if (tempResults.isNotEmpty) {
          tempResults.sort((a, b) => b.score.compareTo(a.score));
          if (_score > tempResults[0].score) _newHighScore = true;
        } else if (tempResults.isEmpty) {
          _newHighScore = true;
        } else {
          _newHighScore = false;
        }
        quizStatus = {
          "mensagem": "Ja te entalaste",
          "certas": _numOfCorrectAns,
          "erradas": questions.length - _numOfCorrectAns,
          "total": questions.length,
          "score": _score,
          "recordePessoal": _newHighScore
        };

        mapResultado = {
          "certas": _numOfCorrectAns.toString(),
          "erradas": (questions.length - _numOfCorrectAns).toString(),
          "modo": dataSource.questionarioAtivo.questionarioDetails.modo,
          "score": _score.toString(),
          "questionarioID":
          dataSource.questionarioAtivo.questionarioDetails.id.toString(),
          "nomeUtilizador": dataSource.utilizadorAtivo.nome
        };
      } else {
        mapResultado = {
          "certas": questions.length.toString(),
          "erradas": "0",
          "modo": dataSource.questionarioAtivo.questionarioDetails.modo,
          "score": "0",
          "questionarioID":
          dataSource.questionarioAtivo.questionarioDetails.id.toString(),
          "nomeUtilizador": dataSource.utilizadorAtivo.nome
        };

        quizStatus = {
          "mensagem": "Respondeste ao questionário",
          "certas": questions.length.toString(),
          "erradas": "0",
          "total": questions.length,
          "score": "0",
          "recordePessoal": _newHighScore,
        };
      }

      _services.sendResultToServer(mapResultado);

      // Get package provide us simple way to navigate another page
      Get.off(() => ScoreScreen(), arguments: quizStatus);
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
