// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resultado.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    id: Result._stringToInt(json['ResultadoID'] as String),
    utilizadorID: Result._stringToInt(json['UtilizasdorID'] as String),
    questionarioID: Result._stringToInt(json['QuestionarioID'] as String),
    respostasCorretas: Result._stringToInt(json['RespostasCertas'] as String),
    respostasErradas: Result._stringToInt(json['RespostasErradas'] as String),
    score: Result._stringToInt(json['Score'] as String),
    dataDeCriacao: json['DataDeCriacao'] as String,
    modo: json['Modo'] as String,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'ResultadoID': Result._stringFromInt(instance.id),
      'UtilizasdorID': Result._stringFromInt(instance.utilizadorID),
      'QuestionarioID': Result._stringFromInt(instance.questionarioID),
      'RespostasCertas': Result._stringFromInt(instance.respostasCorretas),
      'RespostasErradas': Result._stringFromInt(instance.respostasErradas),
      'Score': Result._stringFromInt(instance.score),
      'DataDeCriacao': instance.dataDeCriacao,
      'Modo': instance.modo,
    };
