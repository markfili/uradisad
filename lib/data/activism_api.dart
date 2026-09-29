import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'activism_api.g.dart';

/// Returns raw JSON text so the repository can cache exactly what it received.
@RestApi()
abstract class ActivismApi {
  factory ActivismApi(Dio dio, {String baseUrl}) = _ActivismApi;

  @GET('/assets/manifest.json')
  @DioResponseType(ResponseType.plain)
  Future<String> getManifest();

  @GET('/assets/categories.json')
  @DioResponseType(ResponseType.plain)
  Future<String> getCategories();

  @GET('/assets/sources.json')
  @DioResponseType(ResponseType.plain)
  Future<String> getSources();
}
