// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionario_teste.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teste _$TesteFromJson(Map<String, dynamic> json) {
  return Teste(
    perguntas: (json['perguntasDoQuestionario'] as List)
        ?.map((e) =>
            e == null ? null : Pergunta.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TesteToJson(Teste instance) => <String, dynamic>{
      'perguntasDoQuestionario': instance.perguntas,
    };
