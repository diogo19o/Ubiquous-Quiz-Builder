import 'package:chopper/chopper.dart';

import 'Common.dart';

part 'questionario_service_api.chopper.dart';

@ChopperApi(baseUrl: 'teste.php')
abstract class QuestionarioService extends ChopperService {

  @Get(path: '?action=questionario&QuestionarioID={id}')
  Future<Response> getQuestionario(
      @Path('id') String id,
      );

  static QuestionarioService create([ChopperClient client]) =>
      _$QuestionarioService(client);
}
