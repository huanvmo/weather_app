import 'dart:developer';

import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/country/country_data.dart';
import 'package:weather_app/data/firebase/firebase_layer.dart';
import 'package:weather_app/data/weather/weather_data.dart';
import 'package:weather_app/domain/weather/weather_domain.dart';
import 'package:weather_app/presentation/detail/bloc/detail_bloc.dart';
import 'package:weather_app/presentation/favorites_list/bloc/favorites_list_bloc.dart';
import 'package:weather_app/utils/utils_layer.dart';

import '../../../data/firebase/favorites_db_services_mock.dart';
import '../../../domain/weather/use_cases/get_weather_use_cases_test.dart';
import '../../../utils/share_pref_manager_mock.dart';

void main() {
  final FavoritesDBServices _services = FavoritesDbServicesMock();

  group('Test load event', () {
    blocTest<FavoritesListBloc, FavoritesListState>("Emit success state",
        build: () => FavoritesListBloc(
              services: _services,
              userId: '',
            ),
        act: (FavoritesListBloc bloc) async {
          when(() => _services.getFav(uid: '')).thenAnswer(
            (_) async => [const FavoritesModel()],
          );

          bloc.add(
            FavoritesListLoadEvent(),
          );
        },
        expect: () => <FavoritesListState>[
              FavoritesListLoadedState(
                favoritesModel: const [FavoritesModel()],
              ),
            ],
        verify: (FavoritesListBloc bloc) {
          verify(() => _services.getFav(uid: '')).called(1);
        });
  });
  group('Test delete event', () {
    blocTest<FavoritesListBloc, FavoritesListState>("Emit success state",
        build: () => FavoritesListBloc(
              services: _services,
              userId: '',
            ),
        act: (FavoritesListBloc bloc) async {
          when(() => _services.deleteFav(uid: '', docId: '')).thenAnswer(
            (_) async => Future.value(),
          );

          when(() => _services.getFav(uid: '')).thenAnswer(
            (_) async => [const FavoritesModel()],
          );

          bloc.add(
            FavoritesListDeleteEvent(countryName: ''),
          );
        },
        expect: () => <FavoritesListState>[
              FavoritesListLoadedState(
                favoritesModel: const [FavoritesModel()],
              ),
            ],
        verify: (FavoritesListBloc bloc) {
          verify(() => _services.deleteFav(uid: '', docId: '')).called(1);
          verify(() => _services.getFav(uid: '')).called(1);
        });

    blocTest<FavoritesListBloc, FavoritesListState>(
      "Emit fail state",
      build: () => FavoritesListBloc(
        services: _services,
        userId: '',
      ),
      act: (FavoritesListBloc bloc) async {
        when(() => _services.deleteFav(uid: '', docId: ''))
            .thenThrow(Exception());

        bloc.add(
          FavoritesListDeleteEvent(countryName: ''),
        );
      },
      expect: () =>
          <FavoritesListState>[FavoritesListFailureState(message: '')],
    );
  });
}
