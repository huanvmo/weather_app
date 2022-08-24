// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/data/weather/weather_data.dart';
import 'package:weather_app/domain/weather/weather_domain.dart';

import '../repository/weather_repo_mock.dart';

class WeatherUseCaseMock extends Mock implements WeatherUseCases {}

void main() {
  final WeatherRepo _repo = WeatherRepoMock();

  late WeatherUseCases _useCase;
  setUpAll(() {
    _useCase = WeatherUseCases(_repo);
  });

  group("Test get detail use cases", () {
    test('Return response when success', () async {
      when(
        (() => _repo.getDetail(countryName: "", unit: "")),
      ).thenAnswer(
        (_) async => Future<DetailModel>.value(
          DetailModel(),
        ),
      );

      expect(
          _useCase.getDetail(
            countryName: "",
            unit: "",
          ),
          isNotNull);
      verify(() => _repo.getDetail(countryName: "", unit: "")).called(1);
    });

    test('Return error when fail', () async {
      when(
        () => _repo.getDetail(countryName: "", unit: ""),
      ).thenThrow(Exception());

      try {
        final void _ = await _useCase.getDetail(countryName: "", unit: "");
      } catch (_) {
        throwsA(isA<Exception>());
      }
    });
  });

  group("Test get weather use cases", () {
    test('Return response when success', () async {
      when(
        (() => _repo.getWeather(lat: 1, lon: 1, lang: "")),
      ).thenAnswer(
        (_) async => Future<WeatherModel>.value(
          WeatherModel(),
        ),
      );

      expect(_useCase.getWeather(lat: 1, lon: 1, lang: ""), isNotNull);
      verify(() => _repo.getWeather(lat: 1, lon: 1, lang: "")).called(1);
    });

    test('Return error when fail', () async {
      when(
        () => _repo.getWeather(lat: 1, lon: 1, lang: ""),
      ).thenThrow(Exception());

      try {
        final void _ = await _useCase.getWeather(lat: 1, lon: 1, lang: "");
      } catch (_) {
        throwsA(isA<Exception>());
      }
    });
  });
}
