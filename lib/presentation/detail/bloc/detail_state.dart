part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailInitState extends DetailState {}

class DetailFavoriteButtonPressedState extends DetailState {}

class DetailLoadedState extends DetailState {
  final DetailModel detailModel;
  final List<FavoritesModel> listFav;

  DetailLoadedState({
    required this.detailModel,
    required this.listFav,
  });

  @override
  List<Object> get props => <Object>[
        detailModel,
        listFav,
      ];
}

class DetailLoadingState extends DetailState {}

class DetailFailureState extends DetailState {
  final String message;

  DetailFailureState({required this.message});
}
