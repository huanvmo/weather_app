import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firebase/firebase_layer.dart';
import '../../../../utils/utils_layer.dart';
import 'bloc/news_update_bloc.dart';
import 'ui/news_update_screen.dart';

class NewsUpdateScreenRoute {
  static Widget route({required NewsModel newsModel}) => BlocProvider(
        create: (context) => NewsUpdateBloc(
          services: getIt<NewsDBServices>(),
        )..add(
            NewsUpdateLoadEvent(),
          ),
        child: NewsUpdateScreen(
          newsModel: newsModel,
        ),
      );
}
