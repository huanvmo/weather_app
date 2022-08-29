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
        event: event,
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

      List<FavoritesModel> _listModel = [];
      if (_uid.isNotEmpty) {
        _listModel = await services.getFav(uid: _uid);
      }

      final DetailModel detailModel = response;

      yield DetailLoadedState(
        detailModel: detailModel,
        listFav: _listModel,
      );
    } catch (error) {
      yield DetailFailureState(
        message: error.toString(),
      );
    }
  }

  Stream<DetailState> _mapDetailFavoriteButtonPressedEventToState({
    required DetailFavoriteButtonPressedEvent event,
  }) async* {
    try {
      if (event.isFavorite) {
        await services.favoriteAdd(
          uid: _uid,
          favoritesModel: event.model,
        );
      } else {
        await services.deleteFav(
            uid: _uid, docId: event.model.countryName ?? '');
      }
    } catch (e) {
      yield DetailFailureState(
        message: e.toString(),
      );
    }
  }

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';
}
