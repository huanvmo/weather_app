part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchLoadEvent extends SearchEvent {}

class SearchPressedLoadedEvent extends SearchEvent {
  final String? cityName;
  final List<FavoritesModel>? list;

  SearchPressedLoadedEvent({
    this.list,
    this.cityName,
  });
}

class SearchPressedEvent extends SearchEvent {
  final String cityName;

  SearchPressedEvent({
    required this.cityName,
  });
}

class SearchAddEvent extends SearchEvent {
  final FavoritesModel model;
  final String docId;

  SearchAddEvent({
    required this.model,
    required this.docId,
  });
}
