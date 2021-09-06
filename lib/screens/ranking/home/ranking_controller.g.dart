// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RankingController on _RankingController, Store {
  final _$selectedIndexAtom = Atom(name: '_RankingController.selectedIndex');

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  final _$listaUsersRankingAtom =
      Atom(name: '_RankingController.listaUsersRanking');

  @override
  List<Utilizador> get listaUsersRanking {
    _$listaUsersRankingAtom.reportRead();
    return super.listaUsersRanking;
  }

  @override
  set listaUsersRanking(List<Utilizador> value) {
    _$listaUsersRankingAtom.reportWrite(value, super.listaUsersRanking, () {
      super.listaUsersRanking = value;
    });
  }

  final _$_RankingControllerActionController =
      ActionController(name: '_RankingController');

  @override
  void changeIndex(int index) {
    final _$actionInfo = _$_RankingControllerActionController.startAction(
        name: '_RankingController.changeIndex');
    try {
      return super.changeIndex(index);
    } finally {
      _$_RankingControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic fillData(int i) {
    final _$actionInfo = _$_RankingControllerActionController.startAction(
        name: '_RankingController.fillData');
    try {
      return super.fillData(i);
    } finally {
      _$_RankingControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedIndex: ${selectedIndex},
listaUsersRanking: ${listaUsersRanking}
    ''';
  }
}
