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

import 'package:weather_app/data/firebase/firebase_layer.dart';
import 'package:weather_app/data/weather/model/weather/weather_model.dart';
import 'package:weather_app/domain/weather/weather_domain.dart';

import 'package:weather_app/presentation/login_and_signup/index/bloc/index_bloc.dart';
import 'package:weather_app/presentation/main/home/bloc/home_bloc.dart';
import 'package:weather_app/utils/utils_layer.dart';
import '../../../domain/weather/use_cases/get_weather_use_cases_test.dart';
import '../../../utils/login_signup_service_mock.dart';
import '../../../utils/share_pref_manager_mock.dart';

void main() {
  final WeatherUseCases _useCase = WeatherUseCaseMock();
  final SharedPreferencesManager _sharedPreferencesManagerMock =
      SharePrefManagerMock();

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    GetIt.I.registerLazySingleton<SharedPreferencesManager>(
      () => _sharedPreferencesManagerMock,
    );
  });
  group('Test home load event', () {
    blocTest<HomeBloc, HomeState>("Emit success state",
        build: () => HomeBloc(useCases: _useCase),
        act: (HomeBloc bloc) async {
          bloc.testing();
          when(() => _useCase.getWeather(lat: 0, lon: 0, lang: '')).thenAnswer(
            (_) async => const WeatherModel(),
          );
          bloc.add(
            HomeLoadEvent(),
          );
        },
        expect: () => <HomeState>[
              HomeLoadingState(),
              HomeLoadedState(weatherModel: const WeatherModel()),
            ],
        verify: (HomeBloc bloc) {
          verify(() => _useCase.getWeather(lat: 0, lon: 0, lang: '')).called(1);
        });

    blocTest<HomeBloc, HomeState>("Emit fail state",
        build: () => HomeBloc(useCases: _useCase),
        act: (HomeBloc bloc) async {
          bloc.testing();
          when(() => _useCase.getWeather(lat: 0, lon: 0, lang: ''))
              .thenThrow(Exception());
          bloc.add(
            HomeLoadEvent(),
          );
        },
        expect: () => <HomeState>[
              HomeLoadingState(),
              HomeFailureState(message: ''),
            ],
        verify: (HomeBloc bloc) {
          verify(() => _useCase.getWeather(lat: 0, lon: 0, lang: '')).called(1);
        });
  });
  group('Test home change event', () {
    blocTest<HomeBloc, HomeState>("Emit success state",
        build: () => HomeBloc(useCases: _useCase),
        act: (HomeBloc bloc) async {
          bloc.testing();
          when(() => _useCase.getWeather(lat: 0, lon: 0, lang: '')).thenAnswer(
            (_) async => const WeatherModel(),
          );
          bloc.add(
            HomeChangeEvent(lang: ''),
          );
        },
        expect: () => <HomeState>[
              HomeLoadingState(),
              HomeLoadedState(weatherModel: const WeatherModel()),
            ],
        verify: (HomeBloc bloc) {
          verify(() => _useCase.getWeather(lat: 0, lon: 0, lang: '')).called(1);
        });

    blocTest<HomeBloc, HomeState>("Emit fail state",
        build: () => HomeBloc(useCases: _useCase),
        act: (HomeBloc bloc) async {
          bloc.testing();
          when(() => _useCase.getWeather(lat: 0, lon: 0, lang: ''))
              .thenThrow(Exception());
          bloc.add(
            HomeChangeEvent(lang: ''),
          );
        },
        expect: () => <HomeState>[
              HomeLoadingState(),
              HomeFailureState(message: ''),
            ],
        verify: (HomeBloc bloc) {
          verify(() => _useCase.getWeather(lat: 0, lon: 0, lang: '')).called(1);
        });
  });
}
