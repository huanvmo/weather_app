import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/firebase/firebase_layer.dart';
import '../../../data/weather/weather_data.dart';

part 'favorites_list_event.dart';

part 'favorites_list_state.dart';

class FavoritesListBloc extends Bloc<FavoritesListEvent, FavoritesListState> {
  FavoritesListBloc({required this.services})
      : super(
          FavoritesListInitState(),
        );

  final FavoritesDBServices services;

  final String _uid = FirebaseAuth.instance.currentUser?.uid ?? '';

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
    final List<FavoritesModel> _listModel = await services.getFav(uid: _uid);
    yield (FavoritesListLoadedState(favoritesModel: _listModel));
  }

  Stream<FavoritesListState> _mapFavoritesListDeleteEventToState(
      FavoritesListDeleteEvent event) async* {
    try {
      await services.deleteFav(
        docId: event.countryModel,
        uid: _uid,
      );
      final List<FavoritesModel> _listModel = await services.getFav(uid: _uid);
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
