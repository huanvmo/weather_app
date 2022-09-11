import 'dart:developer';

import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/country/country_data.dart';
import 'package:weather_app/data/firebase/firebase_layer.dart';
import 'package:weather_app/data/weather/weather_data.dart';
import 'package:weather_app/domain/weather/weather_domain.dart';
import 'package:weather_app/presentation/account_management/account/bloc/account_bloc.dart';
import 'package:weather_app/presentation/detail/bloc/detail_bloc.dart';
import 'package:weather_app/presentation/favorites_list/bloc/favorites_list_bloc.dart';
import 'package:weather_app/utils/utils_layer.dart';

import '../../../data/firebase/favorites_db_services_mock.dart';
import '../../../data/firebase/users_db_services_mock.dart';
import '../../../domain/weather/use_cases/get_weather_use_cases_test.dart';
import '../../../utils/share_pref_manager_mock.dart';

void main() {
  final UsersDBServices _services = UsersDBServicesMock();

  group('Test load event', () {
    blocTest<AccountBloc, AccountState>("Emit success state",
        build: () => AccountBloc(
              services: _services,
              email: '',
            ),
        act: (AccountBloc bloc) async {
          when(() => _services.getUser(email: '')).thenAnswer(
            (_) async => const UsersModel(),
          );

          bloc.add(
            AccountLoadEvent(),
          );
        },
        expect: () => <AccountState>[
              AccountLoadedState(usersModel: const UsersModel()),
            ],
        verify: (AccountBloc bloc) {
          verify(() => _services.getUser(email: '')).called(1);
        });
  });

  group('Test change user name event', () {
    blocTest<AccountBloc, AccountState>("Emit success state",
        build: () => AccountBloc(
          services: _services,
          email: '',
        ),
        act: (AccountBloc bloc) async {
          when(() => _services.updateUserDisplayName(userName: '')).thenAnswer(
                (_) async => Future.value(),
          );
          when(() => _services.getUser(email: '')).thenAnswer(
                (_) async => const UsersModel(),
          );

          bloc.add(
            AccountChangeUserNameEvent(userName: ''),
          );
        },
        expect: () => <AccountState>[
          AccountLoadingState(),
          AccountLoadedState(usersModel: const UsersModel()),
        ],
        verify: (AccountBloc bloc) {
          verify(() => _services.getUser(email: '')).called(1);
          verify(() => _services.updateUserDisplayName(userName: '')).called(1);
        });

    blocTest<AccountBloc, AccountState>("Emit fail state",
        build: () => AccountBloc(
          services: _services,
          email: '',
        ),
        act: (AccountBloc bloc) async {
          when(() => _services.updateUserDisplayName(userName: ''))
              .thenThrow(Exception());

          bloc.add(
            AccountChangeUserNameEvent(userName: ''),
          );
        },
        expect: () => <AccountState>[
          AccountLoadingState(),
          AccountFailureState(message: ''),
        ],
        verify: (AccountBloc bloc) {
          verify(() => _services.updateUserDisplayName(userName: '')).called(1);
        });
  });
  group('Test change user photo event', () {
    blocTest<AccountBloc, AccountState>("Emit success state",
        build: () => AccountBloc(
          services: _services,
          email: '',
        ),
        act: (AccountBloc bloc) async {
          when(() => _services.updateUserAvatar(photoUrl: '')).thenAnswer(
                (_) async => Future.value(),
          );
          when(() => _services.getUser(email: '')).thenAnswer(
                (_) async => const UsersModel(),
          );

          bloc.add(
            AccountChangeUserPhotoEvent(photoURL: XFile('')),
          );
        },
        expect: () => <AccountState>[
          AccountLoadingState(),
          AccountLoadedState(usersModel: const UsersModel()),
        ],
        verify: (AccountBloc bloc) {
          verify(() => _services.getUser(email: '')).called(1);
          verify(() => _services.updateUserAvatar(photoUrl: '')).called(1);
        });

    blocTest<AccountBloc, AccountState>("Emit fail state",
        build: () => AccountBloc(
          services: _services,
          email: '',
        ),
        act: (AccountBloc bloc) async {
          when(() => _services.updateUserAvatar(photoUrl: ''))
              .thenThrow(Exception());

          bloc.add(
            AccountChangeUserPhotoEvent(photoURL: XFile('')),
          );
        },
        expect: () => <AccountState>[
          AccountLoadingState(),
          AccountFailureState(message: ''),
        ],
        verify: (AccountBloc bloc) {
          verify(() => _services.updateUserAvatar(photoUrl: '')).called(1);
        });
  });
}
