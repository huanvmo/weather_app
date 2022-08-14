part of 'detail_bloc.dart';

abstract class DetailEvent {}

class DetailLoadEvent extends DetailEvent {
  final String countryName;

  DetailLoadEvent({required this.countryName});
}

class DetailFavoriteButtonPressedEvent extends DetailEvent {
  final bool? favorite;
  final String? locationName;
  final int? woeid;
  final String? docID;

  DetailFavoriteButtonPressedEvent({
    required this.woeid,
    required this.favorite,
    required this.locationName,
    required this.docID,
  });
}
