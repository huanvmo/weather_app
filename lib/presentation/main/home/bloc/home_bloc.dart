import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../data/weather/weather_data.dart';
import '../../../../domain/weather/weather_domain.dart';
import '../../../../utils/utils_layer.dart';
import '../../../common/common_variable.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.useCases}) : super(HomeInitState());
  final WeatherUseCases useCases;

  @visibleForTesting
  bool isTesting = false;
  double latitude = 0;
  double longitude = 0;
  String languages = '';

  void testing() {
    isTesting = true;
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeLoadEvent) {
      try {
        yield HomeLoadingState();

        if (!isTesting) {
          final position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          latitude = position.latitude;
          longitude = position.longitude;
          languages = SessionUtils.getLanguages == vi ? "vi" : 'en';
        }

        final response = await useCases.getWeather(
          lat: latitude,
          lon: longitude,
          lang: languages,
        );

        yield HomeLoadedState(weatherModel: response);
      } catch (e) {
        yield HomeFailureState(message: e.toString());
      }
    } else if (event is HomeChangeEvent) {
      yield* _mapHomeChangeEventToState(homeChangeEvent: event);
    }
  }

  Stream<HomeState> _mapHomeChangeEventToState(
      {required HomeChangeEvent homeChangeEvent}) async* {
    try {
      yield HomeLoadingState();

      if (!isTesting) {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        latitude = position.latitude;
        longitude = position.longitude;
      }

      final response = await useCases.getWeather(
        lat: latitude,
        lon: longitude,
        lang: homeChangeEvent.lang.toString(),
      );

      yield HomeLoadedState(
        weatherModel: response,
      );
    } catch (e) {
      yield HomeFailureState(
        message: e.toString(),
      );
    }
  }
}
