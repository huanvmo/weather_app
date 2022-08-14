import 'package:flutter/material.dart';

import '../../../../data/firebase/firebase_layer.dart';
import 'ui/news_detail_screen.dart';

class NewsDetailScreenRoute {
  static Widget route({required NewsModel newsModel}) => NewsDetailScreen(
        newsModel: newsModel,
      );
}
