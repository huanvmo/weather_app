import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firebase/firebase_layer.dart';
import '../../../../utils/utils_layer.dart';
import 'bloc/news_management_bloc.dart';
import 'ui/news_management_screen.dart';

class NewsManagementScreenRoute {
  static Widget get route => BlocProvider(
        create: (context) => NewsManagementBloc(
          services: getIt<NewsDBServices>(),
        )..add(
            NewsManagementLoadEvent(),
          ),
        child: const NewsManagementScreen(),
      );
}
