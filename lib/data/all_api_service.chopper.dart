// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$AllApiService extends AllApiService {
  _$AllApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AllApiService;

  @override
  Future<Response<dynamic>> getAll() {
    final $url = '/v2/all';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
