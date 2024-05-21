import '../../../../../core/theming/colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/shared_widgets/appBar_widget.dart';
import '../widgets/get_all_repositories_list_view.dart';

class GetAllRepositoryScreen extends StatelessWidget {
  const GetAllRepositoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.moreLightGrey,
      body: ListView(
        children: const [
          AppBarWidget(pageName: "Repositories"),
          GetAllRepositoryScreenListView(),
        ],
      ),
    );
  }
}
