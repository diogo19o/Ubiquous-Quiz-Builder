import 'package:json_annotation/json_annotation.dart';

part 'questionario_details.g.dart';

@JsonSerializable()
class QuestionarioDetails {
  @JsonKey(
      name: 'QuestionarioID', fromJson: _stringToInt, toJson: _stringFromInt)
  final int id;
  @JsonKey(name: 'Modo')
  final String modo;
  @JsonKey(name: 'Titulo')
  final String titulo;
  @JsonKey(name: 'Descricao')
  final String descricao;
  @JsonKey(name: 'DataDeCriacao')
  final String dataDeCriacao;
  @JsonKey(name: 'UserCriacao')
  final String IDuserCriador;
  @JsonKey(name: 'Dificuldade')
  final String dificuldade;
  @JsonKey(name: 'TimerMinutos', fromJson: _stringToInt, toJson: _stringFromInt)
  int timerMinutos;
  @JsonKey(
      name: 'TimerSegundos', fromJson: _stringToInt, toJson: _stringFromInt)
  int timerSegundos;
  @JsonKey(name: 'Acesso')
  final String acesso;

  String estado;

  QuestionarioDetails(
      {this.id,
      this.modo,
      this.titulo,
      this.descricao,
      this.dataDeCriacao,
      this.IDuserCriador,
      this.dificuldade,
      this.timerMinutos,
      this.timerSegundos,
      this.acesso});

  factory QuestionarioDetails.fromJson(Map<String, dynamic> json) =>
      _$QuestionarioDetailsFromJson(json);

  // 8
  Map<String, dynamic> toJson() => _$QuestionarioDetailsToJson(this);

  static int _stringToInt(String number) =>
      number == null ? null : int.parse(number);

  static String _stringFromInt(int number) => number?.toString();
}
