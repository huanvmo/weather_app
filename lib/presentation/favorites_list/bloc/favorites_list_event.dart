part of 'favorites_list_bloc.dart';

abstract class FavoritesListEvent {}

class FavoritesListLoadEvent extends FavoritesListEvent {}

class FavoritesListPressedEvent extends FavoritesListEvent {
  final String cityName;

  FavoritesListPressedEvent({required this.cityName});
}

class FavoritesListDeleteEvent extends FavoritesListEvent {
  final String countryName;

  FavoritesListDeleteEvent({
    required this.countryName,
  });
}
