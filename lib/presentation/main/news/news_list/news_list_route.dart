import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firebase/firebase_layer.dart';
import '../../../../utils/utils_layer.dart';
import 'bloc/news_list_bloc.dart';
import 'ui/news_list_screen.dart';

class NewsListScreenRoute {
  static Widget get route => BlocProvider(
        create: (context) => NewsListBloc(
          services: getIt<NewsDBServices>(),
        )..add(
            NewsListLoadEvent(),
          ),
        child: NewsListScreen(),
      );
}
