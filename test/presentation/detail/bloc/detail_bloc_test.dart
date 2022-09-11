import 'dart:developer';

import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/firebase/firebase_layer.dart';
import 'package:weather_app/data/weather/weather_data.dart';
import 'package:weather_app/domain/weather/weather_domain.dart';
import 'package:weather_app/presentation/detail/bloc/detail_bloc.dart';
import 'package:weather_app/utils/utils_layer.dart';

import '../../../data/firebase/favorites_db_services_mock.dart';
import '../../../domain/weather/use_cases/get_weather_use_cases_test.dart';
import '../../../utils/share_pref_manager_mock.dart';

void main() {
  final WeatherUseCases _useCase = WeatherUseCaseMock();
  final FavoritesDBServices _services = FavoritesDbServicesMock();
  final SharedPreferencesManager _sharedPreferencesManagerMock =
      SharePrefManagerMock();

  setUpAll(() async {
    GetIt.I.registerLazySingleton<SharedPreferencesManager>(
      () => _sharedPreferencesManagerMock,
    );
  });
  group('Test load event', () {
    blocTest<DetailBloc, DetailState>("Emit success state",
        build: () => DetailBloc(
              useCases: _useCase,
              services: _services,
              userId: '1',
            ),
        act: (DetailBloc bloc) async {
          when(() => _useCase.getDetail(unit: "metric", countryName: ""))
              .thenAnswer((_) async => const DetailModel());

          when(() => _services.getFav(uid: '1')).thenAnswer(
            (_) async => [const FavoritesModel()],
          );

          bloc.add(
            DetailLoadEvent(
              countryName: '',
            ),
          );
        },
        expect: () => <DetailState>[
              DetailLoadingState(),
              DetailLoadedState(
                detailModel: const DetailModel(),
                listFav: const [FavoritesModel()],
              ),
            ],
        verify: (DetailBloc bloc) {
          verify(() => _useCase.getDetail(unit: "metric", countryName: ""))
              .called(1);

          verify(() => _services.getFav(uid: '1')).called(1);
        });

    blocTest<DetailBloc, DetailState>(
      "Emit fail state",
      build: () => DetailBloc(
        useCases: _useCase,
        services: _services,
        userId: '',
      ),
      act: (DetailBloc bloc) async {
        when(() => _useCase.getDetail(unit: "metric", countryName: ""))
            .thenThrow(Exception());
        bloc.add(DetailLoadEvent(
          countryName: '',
        ));
      },
      expect: () => <DetailState>[
        DetailLoadingState(),
        DetailFailureState(message: ''),
      ],
    );
  });
  group('Test [DetailFavoriteButtonPressedEvent] event', () {
    blocTest<DetailBloc, DetailState>("Emit success state when favorite",
        build: () => DetailBloc(
              useCases: _useCase,
              services: _services,
              userId: '',
            ),
        act: (DetailBloc bloc) async {
          when(() => _services.favoriteAdd(
                uid: '',
                favoritesModel: const FavoritesModel(),
              )).thenAnswer((_) async => [const FavoritesModel()]);

          bloc.add(
            DetailFavoriteButtonPressedEvent(model: const FavoritesModel()),
          );
        },
        expect: () => <DetailState>[],
        verify: (DetailBloc bloc) {
          verify(() => _services.favoriteAdd(
              uid: '', favoritesModel: const FavoritesModel())).called(1);
        });

    blocTest<DetailBloc, DetailState>(
      "Emit fail state when favorite",
      build: () => DetailBloc(
        useCases: _useCase,
        services: _services,
        userId: '',
      ),
      act: (DetailBloc bloc) async {
        when(() => _services.favoriteAdd(
            uid: '',
            favoritesModel: const FavoritesModel())).thenThrow(Exception());
        bloc.add(
            DetailFavoriteButtonPressedEvent(model: const FavoritesModel()));
      },
      expect: () => <DetailState>[DetailFailureState(message: '')],
    );

    blocTest<DetailBloc, DetailState>("Emit success state when not favorite",
        build: () => DetailBloc(
              useCases: _useCase,
              services: _services,
              userId: '',
            ),
        act: (DetailBloc bloc) async {
          when(() => _services.deleteFav(
                uid: '',
                docId: '',
              )).thenAnswer((_) async => Future.value());

          bloc.add(
            DetailFavoriteButtonPressedEvent(
                model: const FavoritesModel(), isFavorite: false),
          );
        },
        expect: () => <DetailState>[],
        verify: (DetailBloc bloc) {
          verify(() => _services.deleteFav(
                uid: '',
                docId: '',
              )).called(1);
        });

    blocTest<DetailBloc, DetailState>(
      "Emit fail state when favorite",
      build: () => DetailBloc(
        useCases: _useCase,
        services: _services,
        userId: '',
      ),
      act: (DetailBloc bloc) async {
        when(() => _services.deleteFav(
              uid: '',
              docId: '',
            )).thenThrow(Exception());
        bloc.add(DetailFavoriteButtonPressedEvent(
            model: const FavoritesModel(), isFavorite: false));
      },
      expect: () => <DetailState>[DetailFailureState(message: '')],
    );
  });
}
