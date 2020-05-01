// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$CountryApiService extends CountryApiService {
  _$CountryApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CountryApiService;

  @override
  Future<Response<dynamic>> getCountries() {
    final $url = '/v2/countries/?sort=country';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCountry(String country) {
    final $url = '/v2/countries/$country';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
