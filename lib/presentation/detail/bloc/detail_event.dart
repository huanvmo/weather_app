part of 'detail_bloc.dart';

abstract class DetailEvent {}

class DetailLoadEvent extends DetailEvent {
  final String countryName;

  DetailLoadEvent({required this.countryName});
}

class DetailFavoriteButtonPressedEvent extends DetailEvent {
  final FavoritesModel model;
  final bool isFavorite;

  DetailFavoriteButtonPressedEvent({
    required this.model,
    this.isFavorite = true,
  });
}
