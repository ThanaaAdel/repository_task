import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Add this import
import 'package:repositories/core/routing/routers.dart';
import '../../features/home_screen/logic/cubit/repository_cubit.dart';
import '../../features/home_screen/presentation/screens/get_all_repositories_screen.dart';
import '../dependacy_injection/injection.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<GetAllRepositoryCubit>(),
            child: const GetAllRepositoryScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text("No route defined ${settings.name}")),
          ),
        );
    }
  }
}
