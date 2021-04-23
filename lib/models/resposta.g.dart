// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resposta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Resposta _$RespostaFromJson(Map<String, dynamic> json) {
  return Resposta(
    id: Resposta._stringToInt(json['RespostaID'] as String),
    texto: json['Texto'] as String,
    correta: Resposta._stringToBool(json['Correta'] as String),
    perguntaID: Resposta._stringToInt(json['PerguntaID'] as String),
  );
}

Map<String, dynamic> _$RespostaToJson(Resposta instance) => <String, dynamic>{
      'RespostaID': Resposta._stringFromInt(instance.id),
      'Texto': instance.texto,
      'Correta': Resposta._stringFromBool(instance.correta),
      'PerguntaID': Resposta._stringFromInt(instance.perguntaID),
    };
