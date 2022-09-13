import 'dart:developer';

import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/data/country/country_data.dart';

import 'package:weather_app/data/firebase/firebase_layer.dart';
import 'package:weather_app/data/weather/model/weather/weather_model.dart';
import 'package:weather_app/domain/country/country_domain.dart';
import 'package:weather_app/domain/weather/weather_domain.dart';

import 'package:weather_app/presentation/login_and_signup/index/bloc/index_bloc.dart';
import 'package:weather_app/presentation/main/home/bloc/home_bloc.dart';
import 'package:weather_app/presentation/main/search/bloc/search_bloc.dart';
import 'package:weather_app/utils/utils_layer.dart';
import '../../../data/firebase/favorites_db_services_mock.dart';
import '../../../domain/weather/use_cases/get_country_name_use_case_mock.dart';
import '../../../domain/weather/use_cases/get_weather_use_cases_test.dart';
import '../../../utils/login_signup_service_mock.dart';
import '../../../utils/share_pref_manager_mock.dart';

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
