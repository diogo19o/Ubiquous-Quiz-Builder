import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/models/pergunta.dart';
import 'package:ubiquous_quizz_builder/screens/quiz/score_screen.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Lets animated our progress bar

  QuestionController({this.quizMode});

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

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    int time;
    _timeMins = dataSource.questionarioAtivo.questionarioDetails.timerMinutos;
    _timeSecs = dataSource.questionarioAtivo.questionarioDetails.timerSegundos;

    if (_timeMins != 0 || _timeSecs != 0) {
      time = (_timeMins * 60 * 1000) + (_timeSecs * 1000);
    }

    // Encher progress bar em 30s
    _animationController = AnimationController(
        duration: Duration(minutes: _timeMins, seconds: _timeSecs), vsync: this);
    _animation = Tween<double>(begin: 1, end: 0).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });

    // Começar a animacao
    // No fim da animacao passa para a próxima pergunta
    _animationController.forward().whenComplete(nextQuestion);
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

  void checkAns(Pergunta question, int selectedIndex, int correctAnswer) {
    // because once user press any option then it will run
    _isAnswered = true;
    _correctAns = correctAnswer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) {
      _numOfCorrectAns++;
      int totalTime = (_timeMins * 60 + _timeSecs);
      int timeLeft =
      (totalTime - _animationController.value * totalTime).round();
      //Se nao for modo contra relogio
      if(quizMode != 1){
        _score += (timeLeft * 10).toInt();
      }else {
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
    update();

    // Once user select an ans after 3s it will go to the next qn
    Future.delayed(Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length && !_fail) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

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
    } else {



      List<dynamic> quizStatus = [
        "Ja te entalaste",
        _numOfCorrectAns,
        questions.length,
        _score
      ];
      // Get package provide us simple way to navigate another page
      Get.to(ScoreScreen(), arguments: quizStatus);
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
