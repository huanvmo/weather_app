import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/firebase/firebase_layer.dart';
import '../../utils/utils_layer.dart';
import 'bloc/favorites_list_bloc.dart';
import 'ui/favorites_list_screen.dart';

class FavoritesListScreenRoute {
  static Widget get route => BlocProvider(
        create: (context) => FavoritesListBloc(
          services: getIt<FavoritesDBServices>(),
        )..add(
            FavoritesListLoadEvent(),
          ),
        child:  const FavoritesListScreen(),
      );
}
