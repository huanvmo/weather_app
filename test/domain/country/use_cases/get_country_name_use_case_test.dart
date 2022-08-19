// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/data/country/country_data.dart';
import 'package:weather_app/domain/country/country_domain.dart';

import '../repository/country_repository_mock.dart';

void main() {
  final CountryRepo _repo = CountryRepositoryMock();

  late GetCountryNameUseCase _useCase;
  setUpAll(() {
    _useCase = GetCountryNameUseCase(repo: _repo);
  });

  test('Return response when success', () async {
    when(
      (() => _repo.getCountryName(countryName: "")),
    ).thenAnswer(
      (_) async => Future<List<CountryModel>>.value(
        [
          const CountryModel(),
        ],
      ),
    );

    expect(_useCase(countryName: ""),
        isNotNull);
    verify(() => _repo.getCountryName(
        countryName: "")).called(1);
  });

  test('Return error when fail', () async {
    when(
      () => _repo.getCountryName(
          countryName: ""),
    ).thenThrow(Exception());

    try {
      final void _ =
          await _useCase(countryName: "");
    } catch (_) {
      throwsA(isA<Exception>());
    }
  });
}
