import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/country/country_data.dart';
import '../../../../data/firebase/firebase_layer.dart';
import '../../../../data/weather/weather_data.dart';
import '../../../../domain/country/country_domain.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required this.useCases,
    required this.services,
  }) : super(
          SearchInitState(),
        );

  final FavoritesDBServices services;

  final GetCountryNameUseCase useCases;

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
      final response = await useCases(
        countryName: searchPressedEvent.cityName,
      );

      yield SearchResultState(
        countryModel: response,
      );
    } catch (e) {
      yield SearchFailureState(
        message: "Not found",
      );
    }
  }

  Stream<SearchState> _mapPressedSearchLoadedEvent(
      {required SearchPressedLoadedEvent searchPressedLoadedEvent}) async* {
    final response = await useCases(
      countryName: searchPressedLoadedEvent.cityName.toString(),
    );
    yield SearchResultState(
      countryModel: response,
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
