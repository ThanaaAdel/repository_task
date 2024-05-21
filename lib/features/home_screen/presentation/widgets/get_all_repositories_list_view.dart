import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repositories/core/helper/media_query_helper.dart';
import 'package:repositories/features/home_screen/data/model/get_all_repository_model.dart';
import 'package:repositories/features/home_screen/logic/cubit/repository_cubit.dart';
import 'package:repositories/features/home_screen/presentation/widgets/setup_error.dart';
import '../../../../../core/shared_widgets/search_text_form_field.dart';
import '../../../../../core/theming/colors.dart';
import '../../logic/cubit/repository_state.dart';
import 'card_information.dart';
import 'circle_indicator.dart';

class GetAllRepositoryScreenListView extends StatefulWidget {
  const GetAllRepositoryScreenListView({Key? key}) : super(key: key);

  @override
  State<GetAllRepositoryScreenListView> createState() =>
      _GetAllRepositoryScreenListViewState();
}

class _GetAllRepositoryScreenListViewState
    extends State<GetAllRepositoryScreenListView> {
  final TextEditingController _searchController = TextEditingController();
  List<Items> _searchedRepositories = [];
  DateTime? _selectedDate;

  @override
  void initState() {
    context.read<GetAllRepositoryCubit>().emitGetAllRepository(
      q: "created:>2019-01-10",
      sort: "stars",
      order: "desc",
      page: 1,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllRepositoryCubit, RepositoriesState>(
      builder: (context, state) {
        return state.when(
          initial: () {
            return const CircleIndicator();
          },
          loading: () {
            return const CircleIndicator();
          },
          success: (data) {
            final Repositories repositories = data;
            final List<Items> getAllRepositoryModel =
                repositories.items ?? [];
            return successWidget(context, getAllRepositoryModel);
          },
          error: (error) {
            return setupErrorState(context, error);
          },
        );
      },
    );
  }


  SizedBox successWidget(
      BuildContext context, List<Items> getAllRepositoryModel) {
    return SizedBox(
      height: context.screenHeight * 0.9,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: SearchTextFormField(
                    validator: (value) {
                      return null;
                    },
                    controller: _searchController,
                    contentPadding: const EdgeInsets.all(0),
                    fillColorFromBackground: ColorsManager.mainWhite,
                    borderRadius: 16.sp,
                    prefixIcon: const Icon(Icons.search),
                    onChange: (value) {
                      setState(() {
                        _searchedRepositories = getAllRepositoryModel
                            .where((repository) =>
                            repository.name!
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                    hintText: "Search",
                  ),
                ),
                IconButton(
                  onPressed: _selectDate,
                  icon: const Icon(Icons.calendar_today),
                ),
              ],
            ),
          ),
          Expanded(
            child: _searchedRepositories.isEmpty
                ? repositoriesListView(getAllRepositoryModel)
                : searchedRepositoriesListView(),
          ),
        ],
      ),
    );
  }

  ListView searchedRepositoriesListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _searchedRepositories.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: CardInformation(
          name: _searchedRepositories[index].name.toString(),
          image: _searchedRepositories[index].owner!.avatarUrl.toString(),
        ),
      ),
    );
  }

  ListView repositoriesListView(List<Items> getAllRepositoryModel) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: getAllRepositoryModel.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: CardInformation(
          name: getAllRepositoryModel[index].name.toString(),
          image: getAllRepositoryModel[index].owner!.avatarUrl.toString(),
        ),
      ),
    );
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      final DateTime startDate = DateTime(picked.year, picked.month, picked.day);
      final DateTime endDate = DateTime(picked.year, picked.month, picked.day + 1); // Include next day to cover the entire selected day

      setState(() {
        _selectedDate = picked;
        // Trigger a rebuild of the widget when the date is selected
        context.read<GetAllRepositoryCubit>().emitGetAllRepository(
          q: "created:${startDate.toIso8601String()}..${endDate.toIso8601String()}", // Specify a range covering the entire selected day
          sort: "stars",
          order: "desc",
          page: 1,
        );
      });
    }
  }

}
