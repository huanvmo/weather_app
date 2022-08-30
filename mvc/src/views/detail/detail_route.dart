import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/detail/detail_bloc.dart';
import '../../models/firebase/firebase_layer.dart';
import '../utils/utils_layer.dart';
import 'detail_screen.dart';

class DetailScreenRoute {
  static Widget route({
    required DetailArgument argument,
  }) =>
      BlocProvider(
        create: (context) => DetailBloc(

          services: getIt<FavoritesDBServices>(),
        )..add(
            DetailLoadEvent(countryName: argument.countryName),
          ),
        child: DetailScreen(
          countryName: argument.countryName,
          cityName: argument.cityName,
        ),
      );
}
