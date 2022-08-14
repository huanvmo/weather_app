import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/firebase/firebase_layer.dart';

part 'news_list_event.dart';
part 'news_list_state.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  NewsListBloc({required this.services}) : super(NewsListInitState());

  final NewsDBServices services;

  @override
  Stream<NewsListState> mapEventToState(NewsListEvent event) async* {
    if (event is NewsListLoadEvent) {
      yield* _mapNewsListLoadEventToState();
    } else if (event is NewsListLoadedEvent) {
      yield* _mapNewsListLoadedEventToState(newsLoadedEvent: event);
    }
  }

  Stream<NewsListState> _mapNewsListLoadEventToState() async* {
    try {
      yield NewsListLoadingState();
      services.getListNews().listen(
            (news) => add(
              NewsListLoadedEvent(listNews: news),
            ),
          );
    } catch (e) {
      yield NewsListFailureState(
        message: e.toString(),
      );
    }
  }

  Stream<NewsListState> _mapNewsListLoadedEventToState(
      {required NewsListLoadedEvent newsLoadedEvent}) async* {
    try {
      yield NewsListLoadingState();

      yield NewsListLoadedState(
        listNews: newsLoadedEvent.listNews,
      );
    } catch (e) {
      yield NewsListFailureState(
        message: e.toString(),
      );
    }
  }
}
