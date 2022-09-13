import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/firebase/firebase_layer.dart';
import '../../../data/weather/weather_data.dart';

part 'favorites_list_event.dart';

part 'favorites_list_state.dart';

class FavoritesListBloc extends Bloc<FavoritesListEvent, FavoritesListState> {
  FavoritesListBloc({
    required this.services,
    required this.userId,
  }) : super(
          FavoritesListInitState(),
        );

  final FavoritesDBServices services;
  final String userId;

  @override
  Stream<FavoritesListState> mapEventToState(FavoritesListEvent event) async* {
    if (event is FavoritesListLoadEvent) {
      yield* _mapFavoritesListLoadedEventToState(event);
    } else if (event is FavoritesListDeleteEvent) {
      yield* _mapFavoritesListDeleteEventToState(event);
    }
  }

  Stream<FavoritesListState> _mapFavoritesListLoadedEventToState(
      FavoritesListLoadEvent event) async* {
    final List<FavoritesModel> _listModel = await services.getFav(uid: userId);

    yield (FavoritesListLoadedState(favoritesModel: _listModel));
  }

  Stream<FavoritesListState> _mapFavoritesListDeleteEventToState(
      FavoritesListDeleteEvent event) async* {
    try {
      await services.deleteFav(
        docId: event.countryName,
        uid: userId,
      );
      final List<FavoritesModel> _listModel =
          await services.getFav(uid: userId);
      yield (FavoritesListLoadedState(
        favoritesModel: _listModel,
      ));
    } on Exception catch (e) {
      yield FavoritesListFailureState(
        message: e.toString(),
      );
    }
  }
}
