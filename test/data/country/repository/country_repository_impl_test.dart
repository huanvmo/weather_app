import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/data/country/country_data.dart';

import '../data_sources/get_country_name_api_mock.dart';

void main() {
  final GetCountryNameApi _api = GetCountryNameApiMock();
  late CountryRepoImpl _repo;
  setUpAll(() {
    _repo = CountryRepoImpl(api: _api);
  });
  test(
    "Return data when api call success",
    () {
      when(
        () => _api.getCountryName(''),
      ).thenAnswer(
        (_) => Future.value(
          [
            const CountryModel(),
          ],
        ),
      );
      expect(_repo.getCountryName(countryName: ''), isNotNull);
      verify(() => _api.getCountryName('')).called(1);
    },
  );

  test(
    "Return exception when api call fail",
    () {
      when(
        () => _api.getCountryName(''),
      ).thenAnswer(
        (_) => Future.error(
          Exception(),
        ),
      );

      expect(
        () => _repo.getCountryName(countryName: ''),
        throwsA(
          predicate((dynamic e) => e is Exception),
        ),
      );
      verify(() => _api.getCountryName('')).called(1);
    },
  );
}
