import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/firebase/firebase_layer.dart';
import '../../../data/weather/weather_data.dart';
import '../../../domain/weather/weather_domain.dart';
import '../../../utils/utils_layer.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc({
    required this.useCases,
    required this.services,
  }) : super(DetailInitState());

  final WeatherUseCases useCases;
  final FavoritesDBServices services;

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is DetailLoadEvent) {
      yield* _mapDetailLoadEventToState(
        detailLoadEvent: event,
      );
    } else if (event is DetailFavoriteButtonPressedEvent) {
      yield* _mapDetailFavoriteButtonPressedEventToState(
        detailFavoriteButtonPressedEvent: event,
      );
    }
  }

  Stream<DetailState> _mapDetailLoadEventToState({
    required DetailLoadEvent detailLoadEvent,
  }) async* {
    yield DetailLoadingState();
    try {
      final response = await useCases.getDetail(
        countryName: detailLoadEvent.countryName,
        unit: !SessionUtils.getMetric! ? 'metric' : 'us',
      );

      final DetailModel detailModel = response;

      yield DetailLoadedState(
        detailModel: detailModel,
      );
    } catch (error) {
      yield DetailFailureState(
        message: error.toString(),
      );
    }
  }

  Stream<DetailState> _mapDetailFavoriteButtonPressedEventToState({
    required DetailFavoriteButtonPressedEvent detailFavoriteButtonPressedEvent,
  }) async* {
    try {
      await services.favoriteUpdate(
        uid: FirebaseAuth.instance.currentUser!.uid,
        locationName: detailFavoriteButtonPressedEvent.locationName!,
        favorite: detailFavoriteButtonPressedEvent.favorite!,
        woeid: detailFavoriteButtonPressedEvent.woeid!,
        docID: detailFavoriteButtonPressedEvent.docID!,
      );
    } catch (e) {
      yield DetailFailureState(
        message: e.toString(),
      );
    }
  }
}
