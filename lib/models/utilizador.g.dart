// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utilizador.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Utilizador _$UtilizadorFromJson(Map<String, dynamic> json) {
  return Utilizador(
    id: Utilizador._stringToInt(json['id'] as String),
    nome: json['nome'] as String,
  );
}

Map<String, dynamic> _$UtilizadorToJson(Utilizador instance) =>
    <String, dynamic>{
      'id': Utilizador._stringFromInt(instance.id),
      'nome': instance.nome,
    };
