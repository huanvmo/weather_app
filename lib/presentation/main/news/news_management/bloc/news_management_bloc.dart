import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/firebase/firebase_layer.dart';

part 'news_management_event.dart';
part 'news_management_state.dart';

class NewsManagementBloc
    extends Bloc<NewsManagementEvent, NewsManagementState> {
  NewsManagementBloc({required this.services})
      : super(NewsManagementInitState());

  final NewsDBServices services;

  @override
  Stream<NewsManagementState> mapEventToState(
      NewsManagementEvent event) async* {
    if (event is NewsManagementLoadEvent) {
      yield* _mapNewsManagementLoadEventToState();
    } else if (event is NewsManagementLoadedEvent) {
      yield* _mapNewsManagementLoadedEventToState(
        newsManagementLoadedEvent: event,
      );
    } else if (event is NewsManagementDeletePressedEvent) {
      yield* _mapNewsManagementDeletePressedEventToState(
        newsManagementDeletePressedEvent: event,
      );
    }
  }

  Stream<NewsManagementState> _mapNewsManagementLoadEventToState() async* {
    try {
      yield NewsManagementLoadingState();
      services.getListNews().listen(
            (news) => add(
              NewsManagementLoadedEvent(
                listNews: news,
              ),
            ),
          );
    } catch (e) {
      yield NewsManagementFailureState(
        message: e.toString(),
      );
    }
  }

  Stream<NewsManagementState> _mapNewsManagementLoadedEventToState(
      {required NewsManagementLoadedEvent newsManagementLoadedEvent}) async* {
    try {
      yield NewsManagementLoadingState();
      yield NewsManagementLoadedState(
        listNews: newsManagementLoadedEvent.listNews,
      );
    } catch (e) {
      yield NewsManagementFailureState(
        message: e.toString(),
      );
    }
  }

  Stream<NewsManagementState> _mapNewsManagementDeletePressedEventToState(
      {required NewsManagementDeletePressedEvent
          newsManagementDeletePressedEvent}) async* {
    try {
      yield NewsManagementLoadingState();
      await services.deleteNews(
        docID: newsManagementDeletePressedEvent.docID,
      );
    } catch (e) {
      yield NewsManagementFailureState(
        message: e.toString(),
      );
    }
  }
}
