// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionario_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionarioDetails _$QuestionarioDetailsFromJson(Map<String, dynamic> json) {
  return QuestionarioDetails(
    id: QuestionarioDetails._stringToInt(json['QuestionarioID'] as String),
    modo: json['Modo'] as String,
    titulo: json['Titulo'] as String,
    descricao: json['Descricao'] as String,
    dataDeCriacao: json['DataDeCriacao'] as String,
    IDuserCriador: json['UserCriacao'] as String,
    dificuldade: json['Dificuldade'] as String,
    timerMinutos:
        QuestionarioDetails._stringToInt(json['TimerMinutos'] as String),
    timerSegundos:
        QuestionarioDetails._stringToInt(json['TimerSegundos'] as String),
    acesso: json['Acesso'] as String,
  )..estado = json['estado'] as String;
}

Map<String, dynamic> _$QuestionarioDetailsToJson(
        QuestionarioDetails instance) =>
    <String, dynamic>{
      'QuestionarioID': QuestionarioDetails._stringFromInt(instance.id),
      'Modo': instance.modo,
      'Titulo': instance.titulo,
      'Descricao': instance.descricao,
      'DataDeCriacao': instance.dataDeCriacao,
      'UserCriacao': instance.IDuserCriador,
      'Dificuldade': instance.dificuldade,
      'TimerMinutos': QuestionarioDetails._stringFromInt(instance.timerMinutos),
      'TimerSegundos':
          QuestionarioDetails._stringFromInt(instance.timerSegundos),
      'Acesso': instance.acesso,
      'estado': instance.estado,
    };
