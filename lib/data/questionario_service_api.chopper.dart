// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionario_service_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$QuestionarioService extends QuestionarioService {
  _$QuestionarioService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = QuestionarioService;

  @override
  Future<Response<dynamic>> getQuestionario(String id) {
    final $url = 'teste.php/?action=questionario&QuestionarioID=$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
