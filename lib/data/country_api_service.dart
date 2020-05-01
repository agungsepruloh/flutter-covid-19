import 'package:chopper/chopper.dart';

part 'country_api_service.chopper.dart';

@ChopperApi(baseUrl: '/v2/countries')
abstract class CountryApiService extends ChopperService {
  @Get(path: '?sort=country')
  Future<Response> getCountries();

  @Get(path: '/{country}')
  Future<Response> getCountry(@Path('country') String country);

  static CountryApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://corona.lmao.ninja',
      services: [_$CountryApiService()],
      converter: JsonConverter(),
    );

    return _$CountryApiService(client);
  }
}
