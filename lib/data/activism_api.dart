import 'package:aktivizam/data/activism_source.dart';
import 'package:aktivizam/data/activitsm_categories.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'activism_api.g.dart';

@RestApi()
abstract class ActivismApi {
  factory ActivismApi(Dio dio, {String baseUrl}) = _ActivismApi;

  @GET('/assets/categories.json')
  Future<List<ActivismCategory>> getCategories();

  @GET('/assets/sources.json')
  Future<List<ActivismSource>> getSources();
}
