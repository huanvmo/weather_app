import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/search/search_bloc.dart';
import '../../../models/firebase/firebase_layer.dart';
import '../../utils/utils_layer.dart';
import 'search_screen.dart';

class SearchScreenRoute {
  static Widget get route => BlocProvider(
        create: (context) => SearchBloc(

          services: getIt<FavoritesDBServices>(),
        )..add(
            SearchLoadEvent(),
          ),
        child: SearchScreen(),
      );
}
