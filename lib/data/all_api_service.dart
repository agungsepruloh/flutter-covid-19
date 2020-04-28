import 'package:chopper/chopper.dart';

part 'all_api_service.chopper.dart';

@ChopperApi(baseUrl: '/v2/all')
abstract class AllApiService extends ChopperService {
  @Get()
  Future<Response> getAll();

  static AllApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://corona.lmao.ninja',
      services: [_$AllApiService()],
      converter: JsonConverter(),
    );

    return _$AllApiService(client);
  }
}
