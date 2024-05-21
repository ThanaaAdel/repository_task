import 'package:dio/dio.dart';
import 'package:repositories/core/networking/api_constant.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/home_screen/data/model/get_all_repository_model.dart';
part 'api_services.g.dart';

@RestApi(baseUrl: ApiConstant.apiBaseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String baseUrl}) = _ApiServices;

  // get all repositories
  @GET(ApiConstant.repositories)
  Future<Repositories> getAllRepository(
      @Query("q") String q,
      @Query("sort") String sort,
      @Query("order") String order,
      @Query("page") int page,

      );
}