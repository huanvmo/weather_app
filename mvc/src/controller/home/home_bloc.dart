import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/presentation/common/common_variable.dart';

import '../../models/weather/weather_model.dart';
import '../../views/utils/utils_layer.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeLoadEvent) {
      try {
        yield HomeLoadingState();
        final position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        final response = await Dio().get(
            "http://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=4a80de72b34df28b6fa20967cf626513&lang=${SessionUtils.getLanguages == vi ? "vi" : 'en'}&units=metric");
        final WeatherModel model = WeatherModel.fromJson(response.data);
        yield HomeLoadedState(weatherModel: model);
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
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final response = await Dio().get(
          "http://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=4a80de72b34df28b6fa20967cf626513&lang=${SessionUtils.getLanguages == vi ? "vi" : 'en'}&units=metric");
      final WeatherModel model = WeatherModel.fromJson(response.data);
      yield HomeLoadedState(weatherModel: model);
    } catch (e) {
      yield HomeFailureState(
        message: e.toString(),
      );
    }
  }
}
