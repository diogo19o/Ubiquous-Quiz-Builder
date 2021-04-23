import 'package:chopper/chopper.dart';
import 'file:///C:/Users/diogo/AndroidStudioProjects/ubiquous_quizz_builder/lib/data/model_converter.dart';
import 'package:ubiquous_quizz_builder/models/questionario_teste.dart';

import 'Common.dart';

part 'questionario_service_api.chopper.dart';

@ChopperApi(baseUrl: 'teste.php')
abstract class QuestionarioService extends ChopperService {

  @Get(path: '?action=questionario&QuestionarioID={id}')
  Future<Response<Teste>> getQuestionario(
      @Path('id') String id,
      );

  // static QuestionarioService create([ChopperClient client]) =>
  //     _$QuestionarioService(client);

  static QuestionarioService create() {
    final client = ChopperClient(
      baseUrl: Common.URL_BASE_ADDRESS,
      interceptors: [HttpLoggingInterceptor()],
      services: [
        _$QuestionarioService(),
      ],
      converter: ModelConverter(),
    );
    return _$QuestionarioService(client);
  }
}
