import 'package:mobx/mobx.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/controllers/services_bloc.dart';
import 'package:ubiquous_quizz_builder/models/ranking_user.dart';
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
  void changeIndex(int index) {
    selectedIndex = index;
    fillData(index);
  }

  @action
  fillData(int i) {
    //var response = await blocServices.fetchResultsList();

    List<Utilizador> novaLista = [];

    switch (i) {
      case 0:
        {
          for (var user in _dataSource.utilizadores) {
            if (user.resultadosCR.isNotEmpty) {
              novaLista.add(user);
            }
          }
          novaLista.sort((a, b) =>
              b.resultadosCR[0].score.compareTo(a.resultadosCR[0].score));
        }
        break;
      case 1:
        {
          for (var user in _dataSource.utilizadores) {
            if (user.resultadosC.isNotEmpty) {
              novaLista.add(user);
            }
            novaLista.sort((a, b) =>
                b.resultadosC[0].score.compareTo(a.resultadosC[0].score));
          }
          break;
        }
      case 2:
        {
          for (var user in _dataSource.utilizadores) {
            if (user.resultadosMS.isNotEmpty) {
              novaLista.add(user);
            }
          }
          novaLista.sort((a, b) =>
              a.resultadosMS[0].score.compareTo(b.resultadosMS[0].score));
        }
        break;
    }

    listaUsersRanking = novaLista;
  }
}
