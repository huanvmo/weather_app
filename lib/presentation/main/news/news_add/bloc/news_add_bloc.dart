import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/firebase/firebase_layer.dart';

part 'news_add_event.dart';

part 'news_add_state.dart';

class NewsAddBloc extends Bloc<NewsAddEvent, NewsAddState> {
  NewsAddBloc({
    required this.usersDBServices,
    required this.newsDBServices,
  }) : super(NewsAddInitState());

  final UsersDBServices usersDBServices;
  final NewsDBServices newsDBServices;
  UsersModel? _usersModel;

  @override
  Stream<NewsAddState> mapEventToState(NewsAddEvent event) async* {
    _usersModel = await usersDBServices.getUser(
        email: FirebaseAuth.instance.currentUser!.email!);
    if (event is NewsAddLoadEvent) {
      yield* _mapNewsAddLoadEventToState();
    } else if (event is NewsAddPressedEvent) {
      yield* _mapNewsAddPressedEventToState(
        newsAddPressedEvent: event,
      );
    }
  }

  Stream<NewsAddState> _mapNewsAddLoadEventToState() async* {
    try {
      yield NewsAddLoadingState();
      yield NewsAddLoadedState();
    } catch (e) {
      yield NewsAddFailureState(
        message: e.toString(),
      );
    }
  }

  Stream<NewsAddState> _mapNewsAddPressedEventToState(
      {required NewsAddPressedEvent newsAddPressedEvent}) async* {
    yield NewsAddLoadingState();
    try {
      await newsDBServices.newsAdd(
        images: newsAddPressedEvent.images,
        title: newsAddPressedEvent.title,
        content: newsAddPressedEvent.content,
        thumbnails: newsAddPressedEvent.thumbnails,
        author: _usersModel?.name ?? '',
        brief: newsAddPressedEvent.brief,
        docID: newsDBServices.news.doc().id,
      );
      yield NewsAddLoadedState();
    } catch (error) {
      yield NewsAddFailureState(
        message: error.toString(),
      );
    }
  }
}
