import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/weather/weather_domain.dart';
import '../../../utils/utils_layer.dart';
import 'bloc/home_bloc.dart';
import 'ui/home_screen.dart';

class HomeScreenRoute {
  static Widget get route => BlocProvider(
        create: (context) => HomeBloc(
          useCases: WeatherUseCases(
            getIt<WeatherRepo>(),
          ),
        )..add(
            HomeLoadEvent(),
          ),
        child: const HomeScreen(),
      );
}
