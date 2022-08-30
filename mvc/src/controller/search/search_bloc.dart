import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/country/country_model.dart';
import '../../models/favorites/favorites_model.dart';
import '../../models/firebase/firebase_layer.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required this.services,
  }) : super(
          SearchInitState(),
        );

  final FavoritesDBServices services;

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchPressedEvent) {
      yield* _mapSearchPressedEventToState(
        searchPressedEvent: event,
      );
    } else if (event is SearchPressedLoadedEvent) {
      yield* _mapPressedSearchLoadedEvent(
        searchPressedLoadedEvent: event,
      );
    } else if (event is SearchAddEvent) {
      yield* _mapSearchAddEventToState(
        searchAddEvent: event,
      );
    }
  }

  Stream<SearchState> _mapSearchPressedEventToState(
      {required SearchPressedEvent searchPressedEvent}) async* {
    try {
      final response = await Dio().get(
          'https://restcountries.com/v3.1/name/${searchPressedEvent.cityName}');

      final List<CountryModel> listModel =
          (response.data as List).map((e) => CountryModel.fromJson(e)).toList();

      yield SearchResultState(
        countryModel: listModel,
      );
    } catch (e) {
      yield SearchFailureState(
        message: "Not found",
      );
    }
  }

  Stream<SearchState> _mapPressedSearchLoadedEvent(
      {required SearchPressedLoadedEvent searchPressedLoadedEvent}) async* {
    final response = await Dio().get(
        'https://restcountries.com/v3.1/name/${searchPressedLoadedEvent.cityName}');

    final List<CountryModel> listModel =
        (response.data as List).map((e) => CountryModel.fromJson(e)).toList();

    yield SearchResultState(
      countryModel: listModel,
      favoritesModel: searchPressedLoadedEvent.list,
    );
  }

  Stream<SearchState> _mapSearchAddEventToState(
      {required SearchAddEvent searchAddEvent}) async* {
    await services.favoriteAdd(
      favoritesModel: searchAddEvent.model,
      uid: FirebaseAuth.instance.currentUser!.uid,
    );
  }
}
