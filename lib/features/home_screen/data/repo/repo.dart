

import 'package:repositories/core/networking/api_error_handler.dart';

import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_services.dart';
import '../../data/model/get_all_repository_model.dart';


class GetAllRepositoryRepo {
  final ApiServices apiServices;

  GetAllRepositoryRepo(this.apiServices);

  Future<ApiResult<Repositories>> getAllRepository({required String q,required String sort, required String order,required int page}) async {
    try {
      var response = await apiServices.getAllRepository(q,sort,order,page);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}