part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

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
  final String message;

  SearchFailureState({required this.message});
}
