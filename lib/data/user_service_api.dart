import 'package:chopper/chopper.dart';

part 'user_service_api.chopper.dart';

@ChopperApi(/*baseUrl: '/teste.php'*/)
abstract class UserService extends ChopperService {

  @Get(path: 'teste.php/?action={action}')
  Future<Response> getAll(
    @Path('action') String action,
  );

  @Post(path: 'user.php', headers: {contentTypeKey: formEncodedHeaders})
  Future<Response> postPost(
    @Body() Map<String, String> body,
  );

  static UserService create([ChopperClient client]) =>
      _$UserService(client);

  // static UserServiceApi create() {
  //   final client = ChopperClient(
  //     baseUrl: Common.URL_ADRESS_ALL,
  //     interceptors: [HttpLoggingInterceptor()],
  //     services: [
  //       _$UserServiceApi(),
  //     ],
  //     converter: JsonConverter(),
  //   );
  //   return _$UserServiceApi(client);
  // }
}
