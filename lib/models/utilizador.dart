import 'package:json_annotation/json_annotation.dart';
import 'package:ubiquous_quizz_builder/models/resultado.dart';

part 'utilizador.g.dart';

@JsonSerializable()
class Utilizador {

  @JsonKey(name: 'id', fromJson:_stringToInt, toJson: _stringFromInt)
  final int id;
  @JsonKey(name: 'nome')
  final String nome;
  @JsonKey(ignore: true)
  List<Result> resultadosC = [];//Classico
  @JsonKey(ignore: true)
  List<Result> resultadosCR = [];//Contra relogio
  @JsonKey(ignore: true)
  List<Result> resultadosMS = []; //Morte subita

  Utilizador({this.id, this.nome});

  factory Utilizador.fromJson(Map<String, dynamic> json) => _$UtilizadorFromJson(json);

  Map<String, dynamic> toJson() => _$UtilizadorToJson(this);

  static int _stringToInt(String number) => number == null ? null : int.parse(number);
  static String _stringFromInt(int number) => number?.toString();

}