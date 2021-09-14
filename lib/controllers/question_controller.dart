import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:ubiquous_quizz_builder/controllers/services_bloc.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/models/pergunta.dart';
import 'package:ubiquous_quizz_builder/models/resultado.dart';
import 'package:ubiquous_quizz_builder/models/utilizador.dart';
import 'package:ubiquous_quizz_builder/screens/quiz/score_screen.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Lets animated our progress bar

  QuestionController({this.quizMode}) {
    //cleanController();
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

  int totalTime = 0;

  int maxScorePossible = 0;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    int time;
    if (quizMode != 3) {
      _timeMins = dataSource.questionarioAtivo.questionarioDetails.timerMinutos;
      _timeSecs =
          dataSource.questionarioAtivo.questionarioDetails.timerSegundos;
    }else{
      _timeMins = 99; // Tempo demasiado alto para nao avançar de pagina
      _timeSecs = 99; // Garante que no final todo o controller seja destruido com sucesso

    }

    if (_timeMins != 0 || _timeSecs != 0) {
      time = (_timeMins * 60 * 1000) + (_timeSecs * 1000);
    }

    //if (quizMode != 3) {
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
    //}
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
        totalTime = (_timeMins * 60 + _timeSecs);
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

      _answerTimes.add(_animationController.lastElapsedDuration.inMilliseconds);
    }
      // Stop the counter
      _animationController.stop();
    //} ESTE AQUI

    update();

    // Assim que seleciona uma resposta espera X segundos ate avancar de pergunta
    Future.delayed(Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length && !_fail) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      //if (quizMode != 3) {
        if (quizMode == 1) { // Contra-Relógio
          _animationController.repeat();
        } else {// Classico / Morte subita
          // Reset counter
          _animationController.reset();
        }

        // Quando o timer acabar avanca para a proxima pergunta
        _animationController.forward().whenComplete(nextQuestion);
      //}
    } else { //Acabou as perguntas

      Map<String, String> mapResultado;
      Map<String, dynamic> quizStatus;

      maxScorePossible = (_timeMins * 60 + _timeSecs) * _questions.length;

      if (quizMode != 3) { //Status a enviar para o Score Screen no modo Classico, Morte Subita e Contra Relogio
        Utilizador user = dataSource.utilizadorAtivo;

        //-------- Verifica se bateu o recorde pessoal --------
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
          if (_score > tempResults[0].score && _score != 0) _newHighScore = true;
        } else if (tempResults.isEmpty && _score != 0) {
          _newHighScore = true;
        } else {
          _newHighScore = false;
        }

        //---------------------------------------------------

        //Status a enviar para o Score Screen
        quizStatus = {
          "mensagem": getRightMessageBasedInScore(),
          "certas": _numOfCorrectAns,
          "erradas": questions.length - _numOfCorrectAns,
          "total": questions.length,
          "score": _score,
          "maxScore": maxScorePossible,
          "recordePessoal": _newHighScore
        };

        //Dados para o servidor
        mapResultado = {
          "certas": _numOfCorrectAns.toString(),
          "erradas": (questions.length - _numOfCorrectAns).toString(),
          "modo": dataSource.questionarioAtivo.questionarioDetails.modo,
          "score": _score.toString(),
          "questionarioID":
          dataSource.questionarioAtivo.questionarioDetails.id.toString(),
          "nomeUtilizador": dataSource.utilizadorAtivo.nome
        };


      } else { //Status a enviar para o Score Screen no modo Questionario

        quizStatus = {
          "mensagem": getRightMessageBasedInScore(),
          "certas": questions.length.toString(),
          "erradas": "0",
          "total": questions.length,
          "score": "0",
          "maxScore": maxScorePossible,
          "recordePessoal": _newHighScore,
        };

        mapResultado = {
          "certas": questions.length.toString(),
          "erradas": "0",
          "modo": dataSource.questionarioAtivo.questionarioDetails.modo,
          "score": "0",
          "questionarioID":
          dataSource.questionarioAtivo.questionarioDetails.id.toString(),
          "nomeUtilizador": dataSource.utilizadorAtivo.nome
        };
      }

      _services.sendResultToServer(mapResultado);

      // Get package provide us simple way to navigate another page
      Get.off(() => ScoreScreen(), arguments: quizStatus);
    }
  }

  String getRightMessageBasedInScore(){
    if(quizMode != 3) {
      if (quizMode != 1) {
        maxScorePossible = (totalTime * 10);
        if (numOfCorrectAns == 0) {
          return "Este não correu muito bem, mas não desistas!";
        }
        if (numOfCorrectAns < questions.length / 2) {
          return "Vamos lá! Tu consegues melhor.";
        }
         if (numOfCorrectAns == questions.length &&
            _score < (maxScorePossible - (50 * questions.length))) {
          //Se acertou todas as perguntas porém demorou mais de 5 segundos (50 pontos perdidos por pergunta) por pergunta
          return "Muito bem! Conseguiste acertar todas as perguntas, agora tenta ser mais rápido.";
        }
         if (numOfCorrectAns == questions.length &&
            _score < (maxScorePossible - (30 * questions.length))) {
          //Se acertou todas as perguntas porém demorou mais de 2 segundos (20 pontos perdidos por pergunta) por pergunta
          return "Incrível! Estás mesmo quase a obter a pontuação máxima.";
        }
         if (numOfCorrectAns >
            questions.length / 2) { // Se acertou mais de metade
          return "Boa! Conseguiste acertar mais de metade do questionário.";
        }
         if (numOfCorrectAns ==
            questions.length / 2) { // Se acertou mais de metade
          return "Boa! Conseguiste acertar metade do questionário.";
        }
      } else {
        return "Fim do Contra Relogio";
      }
    }
      return "Fim do questionário!";
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
