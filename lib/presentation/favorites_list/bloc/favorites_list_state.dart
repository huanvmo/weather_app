part of 'favorites_list_bloc.dart';

abstract class FavoritesListState extends Equatable {
  @override
  List<Object> get props => <Object>[];
}

class FavoritesListInitState extends FavoritesListState {}

class FavoritesListLoadedState extends FavoritesListState {
  final List<FavoritesModel> favoritesModel;

  FavoritesListLoadedState({
    required this.favoritesModel,
  });

  @override
  List<Object> get props => <Object>[favoritesModel];
}

class FavoritesListLoadingState extends FavoritesListState {}

class FavoritesListFailureState extends FavoritesListState {
  final String message;

  FavoritesListFailureState({required this.message});
}
