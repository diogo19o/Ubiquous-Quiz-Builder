// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_service_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$UserService extends UserService {
  _$UserService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = UserService;

  @override
  Future<Response<dynamic>> getAll(String action) {
    final $url = 'teste.php/?action=$action';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> loginUser(Map<String, String> body) {
    final $url = 'user.php';
    final $headers = {'content-type': 'application/x-www-form-urlencoded'};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> registerUser(Map<String, String> body) {
    final $url = 'user.php';
    final $headers = {'content-type': 'application/x-www-form-urlencoded'};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> sendResults(Map<String, String> body) {
    final $url = 'teste.php/?action=resultado';
    final $headers = {'content-type': 'application/x-www-form-urlencoded'};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
