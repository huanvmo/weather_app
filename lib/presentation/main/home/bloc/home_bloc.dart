import 'package:bloc/bloc.dart';
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

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeLoadEvent) {
      yield* _mapHomeLoadEventToState(
        homeLoadEvent: event,
      );
    } else if (event is HomeChangeEvent) {
      yield* _mapHomeChangeEventToState(
        homeChangeEvent: event,
      );
    }
  }

  Stream<HomeState> _mapHomeLoadEventToState(
      {required HomeLoadEvent homeLoadEvent}) async* {
    try {
      yield HomeLoadingState();
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final response = await useCases.getWeather(
        lat: position.latitude,
        lon: position.longitude,
        lang: SessionUtils.getLanguages == vi ? "vi" : 'en',
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

  Stream<HomeState> _mapHomeChangeEventToState(
      {required HomeChangeEvent homeChangeEvent}) async* {
    try {
      yield HomeLoadingState();
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final response = await useCases.getWeather(
        lat: position.latitude,
        lon: position.longitude,
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
