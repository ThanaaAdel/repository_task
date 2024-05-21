
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:repositories/core/networking/api_services.dart';
import '../../features/home_screen/data/repo/repo.dart';
import '../../features/home_screen/logic/cubit/repository_cubit.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;
Future<void> setupGetIt () async{
//Dio & apiServices
  Dio dio =  await DioFactory.getDio();
  getIt.registerLazySingleton<ApiServices>(() => ApiServices(dio));

  // login page
  getIt.registerLazySingleton<GetAllRepositoryRepo>(() => GetAllRepositoryRepo(getIt()));
  getIt.registerFactory<GetAllRepositoryCubit>(() => GetAllRepositoryCubit(getIt()));

}