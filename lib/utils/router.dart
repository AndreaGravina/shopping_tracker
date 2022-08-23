import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/data/repository.dart';
import 'package:flutter_template/presentation/screens/landing_screen.dart';
import 'package:flutter_template/utils/service_locator.dart';

abstract class CustomRouter {
  static final _repository = locator.get<Repository>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const LandingScreen(),
          settings: settings,
        );
      //example cubit screen
      /*case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext ctx) => TestCubit(repository: _repository),
            child: const LandingScreen(),
          ),
          settings: settings,
        );*/
      default:
        return MaterialPageRoute(
          builder: (ctx) => const Center(
            child: Text('Errore!'),
          ),
          settings: settings,
        );
    }
  }
}
