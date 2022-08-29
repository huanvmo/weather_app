part of 'search_bloc.dart';

abstract class SearchState {}

class SearchInitState extends SearchState {}

class SearchResultState extends SearchState {
  final List<CountryModel> countryModel;
  final List<FavoritesModel>? favoritesModel;

  SearchResultState({
    required this.countryModel,
    this.favoritesModel,
  });
}

class SearchLoadingState extends SearchState {}

class SearchFailureState extends SearchState {
  String message;

  SearchFailureState({required this.message});
}
