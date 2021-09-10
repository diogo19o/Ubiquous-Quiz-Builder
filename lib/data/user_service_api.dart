import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/io_client.dart' as http;

import '../Common.dart';

part 'user_service_api.chopper.dart';

@ChopperApi()
abstract class UserService extends ChopperService {

  @Get(path: 'teste.php/?action={action}')
  Future<Response> getAll(
    @Path('action') String action,
  );

  @Post(path: 'user.php', headers: {contentTypeKey: formEncodedHeaders})
  Future<Response> loginUser(
    @Body() Map<String, String> body,
  );

  @Post(path: 'user.php', headers: {contentTypeKey: formEncodedHeaders})
  Future<Response> registerUser(
      @Body() Map<String, String> body,
      );

  @Post(path: 'teste.php/?action=resultado', headers: {contentTypeKey: formEncodedHeaders})
  Future<Response> sendResults(
      @Body() Map<String, String> body,
      );

  static UserService create() {
    final client = ChopperClient(
      client: http.IOClient(
        HttpClient()..connectionTimeout = const Duration(seconds: 4),
      ),
      baseUrl: Common.URL_BASE_ADDRESS,
      interceptors: [HttpLoggingInterceptor()],
      services: [
        _$UserService(),
      ],
      converter: JsonConverter(),
    );
    return _$UserService(client);
  }
}