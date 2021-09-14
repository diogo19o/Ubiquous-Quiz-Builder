import 'package:mobx/mobx.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/controllers/services_bloc.dart';
import 'package:ubiquous_quizz_builder/models/utilizador.dart';

part 'ranking_controller.g.dart';

class RankingController = _RankingController with _$RankingController;

abstract class _RankingController with Store {
  final DataSource _dataSource = DataSource();
  Services blocServices = Services();

  _RankingController() {
    fillData(1);
  }

  @observable
  int selectedIndex = 1;

  @observable
  List<Utilizador> listaUsersRanking = [];

  @action
  Future<void> changeIndex(int index) async {
    selectedIndex = index;
    await fillData(index);
  }

  @action
  fillData(int i) async {
    await blocServices.fetchResultsList();

    List<Utilizador> novaLista = [];

    switch (i) {
      case 0:
        {
          for (var user in _dataSource.utilizadores) {
            if (user.resultadosCR.isNotEmpty) {
              novaLista.add(user);
              novaLista.sort((a, b) =>
                  b.resultadosCR[0].score.compareTo(a.resultadosCR[0].score));
            }
          }
        }
        break;
      case 1:
        {
          for (var user in _dataSource.utilizadores) {
            if (user.resultadosC.isNotEmpty) {
              novaLista.add(user);
              novaLista.sort((a, b) =>
                  b.resultadosC[0].score.compareTo(a.resultadosC[0].score));
            }
          }
          break;
        }
      case 2:
        {
          for (var user in _dataSource.utilizadores) {
            if (user.resultadosMS.isNotEmpty) {
              novaLista.add(user);
              novaLista.sort((a, b) =>
                  b.resultadosMS[0].score.compareTo(a.resultadosMS[0].score));
            }
          }
        }
        break;
    }

    for(Utilizador user in novaLista){
      print("--------USER-------");
      print(user.nome);
      print(user.resultadosC.length);
      print(user.resultadosCR.length);
      print(user.resultadosMS.length);
      print("-------------------");
      print("C");
      if(user.resultadosC.length == 1){
        print(user.resultadosC[0].score);
      }else if(user.resultadosC.length == 2){
        print(user.resultadosC[0].score);
        print(user.resultadosC[1].score);
      }
      print("CR");
      if(user.resultadosCR.length == 1){
        print(user.resultadosCR[0].score);
      }else if(user.resultadosCR.length == 2){
        print(user.resultadosC[0].score);
        print(user.resultadosCR[1].score);
      }
      print("MS");
      if(user.resultadosMS.length == 1){
        print(user.resultadosMS[0].score);
      }else if(user.resultadosMS.length == 2){
        print(user.resultadosC[0].score);
        print(user.resultadosMS[1].score);
      }
      print("/|/|/|/|//|/|/|/|/|/|/|/");
    }


    listaUsersRanking = novaLista;
  }
}
