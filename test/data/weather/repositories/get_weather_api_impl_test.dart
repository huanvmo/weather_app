import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/data/weather/weather_data.dart';

import '../data_sources/get_detail_api.dart';
import '../data_sources/get_weather_api.dart';

void main() {
  final GetDetailApi _getDetailApi = GetDetailApiMock();
  final GetWeatherApi _getWeatherApi = GetWeatherApiMock();

  late WeatherRepoImpl _repo;
  setUpAll(() {
    _repo = WeatherRepoImpl(
      getWeatherApi: _getWeatherApi,
      getDetailApi: _getDetailApi,
    );
  });
  group("Get detail api test", () {
    test(
      "Return data when api call success",
      () {
        when(
          () => _getDetailApi.getDetail("", ""),
        ).thenAnswer(
          (_) => Future.value(
            DetailModel(),
          ),
        );
        expect(
            _repo.getDetail(
              countryName: '',
              unit: '',
            ),
            isNotNull);
        verify(
          () => _getDetailApi.getDetail('', ''),
        ).called(1);
      },
    );

    test(
      "Return exception when api call fail",
      () {
        when(
          () => _getDetailApi.getDetail('', ''),
        ).thenAnswer(
          (_) => Future.error(
            Exception(),
          ),
        );

        expect(
          () => _repo.getDetail(countryName: '', unit: ''),
          throwsA(
            predicate((dynamic e) => e is Exception),
          ),
        );
        verify(
          () => _getDetailApi.getDetail('', ''),
        ).called(1);
      },
    );
  });
  group("Get weather api test", () {
    test(
      "Return data when api call success",
      () {
        when(
          () => _getWeatherApi.getWeather(1, 1, ""),
        ).thenAnswer(
          (_) => Future.value(
            WeatherModel(),
          ),
        );
        expect(
            _repo.getWeather(
              lang: '',
              lat: 1,
              lon: 1,
            ),
            isNotNull);
        verify(
          () => _getWeatherApi.getWeather(1, 1, ""),
        ).called(1);
      },
    );

    test(
      "Return exception when api call fail",
      () {
        when(
          () => _getWeatherApi.getWeather(1, 1, ""),
        ).thenAnswer(
          (_) => Future.error(
            Exception(),
          ),
        );

        expect(
          () => _repo.getWeather(
            lon: 1,
            lat: 1,
            lang: '',
          ),
          throwsA(
            predicate((dynamic e) => e is Exception),
          ),
        );
        verify(
          () => _getWeatherApi.getWeather(1,1,''),
        ).called(1);
      },
    );
  });
}
