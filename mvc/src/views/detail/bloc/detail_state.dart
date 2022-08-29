part of 'detail_bloc.dart';

abstract class DetailState {}

class DetailInitState extends DetailState {}

class DetailFavoriteButtonPressedState extends DetailState {}

class DetailLoadedState extends DetailState {
  final DetailModel detailModel;
  final List<FavoritesModel> listFav;

  DetailLoadedState({
    required this.detailModel,
    required this.listFav,
  });
}

class DetailLoadingState extends DetailState {}

class DetailFailureState extends DetailState {
  String message;
  DetailFailureState({required this.message});
}
