import 'package:modak/rest/ResponseGetCampings.dart';
import 'package:modak/rest/ResponseGetCampingsRegions.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'RestClient.g.dart';

@RestApi(baseUrl: "http://localhost:8080/modak")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/campings")
  Future<ResponseGetCampings> getCampings(
      @Query("page") int page,
      @Query("size") int size,
      @Query("environmentName") String environmentName,
      @Query("operationType") String operationType,
      @Query("regionContains") String regionContains);

  @GET("/campings/regions")
  Future<ResponseGetCampingsRegions> getCampingsRegions();
}
