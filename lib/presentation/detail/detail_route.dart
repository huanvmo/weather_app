import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/firebase/firebase_layer.dart';
import '../../domain/weather/weather_domain.dart';
import '../../utils/utils_layer.dart';
import 'bloc/detail_bloc.dart';
import 'ui/detail_screen.dart';

class DetailScreenRoute {
  static Widget route({
    required DetailArgument argument,
  }) =>
      BlocProvider(
        create: (context) => DetailBloc(
          useCases: WeatherUseCases(
            getIt<WeatherRepo>(),
          ),
          services: getIt<FavoritesDBServices>(),
          userId: FirebaseAuth.instance.currentUser?.uid ?? '',
        )..add(
            DetailLoadEvent(countryName: argument.countryName),
          ),
        child: DetailScreen(
          countryName: argument.countryName,
          cityName: argument.cityName,
        ),
      );
}
