import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/firebase/firebase_layer.dart';
import '../../../domain/country/country_domain.dart';
import '../../../utils/utils_layer.dart';
import 'bloc/search_bloc.dart';
import 'ui/search_screen.dart';

class SearchScreenRoute {
  static Widget get route => BlocProvider(
        create: (context) => SearchBloc(
          useCases: GetCountryNameUseCase(
            repo: getIt<CountryRepo>(),
          ),
          services: getIt<FavoritesDBServices>(),
        )..add(
            SearchLoadEvent(),
          ),
        child: SearchScreen(),
      );
}
