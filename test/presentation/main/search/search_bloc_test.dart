
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:weather_app/data/firebase/firebase_layer.dart';
import 'package:weather_app/domain/country/country_domain.dart';

import 'package:weather_app/presentation/main/search/bloc/search_bloc.dart';
import '../../../data/firebase/favorites_db_services_mock.dart';
import '../../../domain/weather/use_cases/get_country_name_use_case_mock.dart';

void main() {
  final GetCountryNameUseCase _useCase = GetCountryNameUseCaseMock();
  final FavoritesDBServices _service = FavoritesDbServicesMock();

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
  });
  group('Test search press event', () {
    blocTest<SearchBloc, SearchState>("Emit success state",
        build: () => SearchBloc(useCases: _useCase, services: _service),
        act: (SearchBloc bloc) async {
          when(() => _useCase(countryName: '')).thenAnswer(
            (_) async => [],
          );
          bloc.add(
            SearchPressedEvent(cityName: ''),
          );
        },
        expect: () => <SearchState>[
              SearchResultState(
                countryModel: const [],
                favoritesModel: const [],
              ),
            ],
        verify: (SearchBloc bloc) {
          verify(() => _useCase(countryName: '')).called(1);
        });

    blocTest<SearchBloc, SearchState>("Emit fail state",
        build: () => SearchBloc(useCases: _useCase, services: _service),
        act: (SearchBloc bloc) async {
          when(() => _useCase(countryName: '')).thenThrow(Exception());
          bloc.add(
            SearchPressedEvent(cityName: ''),
          );
        },
        expect: () => <SearchState>[SearchFailureState(message: '')],
        verify: (SearchBloc bloc) {
          verify(() => _useCase(countryName: '')).called(1);
        });
  });
}
