import 'package:bloc/bloc.dart';
import 'package:repositories/features/home_screen/logic/cubit/repository_state.dart';
import '../../data/model/get_all_repository_model.dart';
import '../../data/repo/repo.dart';

class GetAllRepositoryCubit extends Cubit<RepositoriesState<Repositories>> {
  final GetAllRepositoryRepo getAllRepositoryRepo;

  GetAllRepositoryCubit(this.getAllRepositoryRepo) : super(const RepositoriesState.initial());

  void emitGetAllRepository(
      {required String q, required String sort, required String order, required int page}) async {
    var data = await getAllRepositoryRepo.getAllRepository(
        q: q, sort: sort, order: order, page: page);

    data.when(success: (allUsers) {
      emit(RepositoriesState.success(allUsers));
    }, failure: (error) {
      emit(RepositoriesState.error(error: error.apiErrorModel.message ?? ''));
    });
  }



}