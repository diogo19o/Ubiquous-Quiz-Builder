// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pergunta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pergunta _$PerguntaFromJson(Map<String, dynamic> json) {
  return Pergunta(
    id: Pergunta._stringToInt(json['PerguntaID'] as String),
    texto: json['Texto'] as String,
    resposta: Pergunta._stringToInt(json['Resposta'] as String),
    questionarioID: Pergunta._stringToInt(json['QuestionarioID'] as String),
    nomeImagem: json['NomeImagem'] as String,
  );
}

Map<String, dynamic> _$PerguntaToJson(Pergunta instance) => <String, dynamic>{
      'PerguntaID': Pergunta._stringFromInt(instance.id),
      'Texto': instance.texto,
      'Resposta': Pergunta._stringFromInt(instance.resposta),
      'QuestionarioID': Pergunta._stringFromInt(instance.questionarioID),
      'NomeImagem': instance.nomeImagem,
    };
