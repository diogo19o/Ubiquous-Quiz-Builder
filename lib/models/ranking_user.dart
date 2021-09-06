import 'package:ubiquous_quizz_builder/models/resultado.dart';
import 'package:ubiquous_quizz_builder/models/utilizador.dart';

class UtilizadorRanking {

  Utilizador _utilizador;
  List<Result> resultadosC = []; //Classico
  List<Result> resultadosCR = []; //Contra relogio
  List<Result> resultadosMS = []; //Morte subita

  UtilizadorRanking(this._utilizador);

  set setUtilizador(Utilizador user) {
    this._utilizador = user;
  }

  Utilizador get utilizador => _utilizador;

  static int _stringToInt(String number) => number == null ? null : int.parse(number);
  static String _stringFromInt(int number) => number?.toString();

}