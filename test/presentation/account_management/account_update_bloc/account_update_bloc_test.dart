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
import 'package:weather_app/presentation/account_management/account_list/bloc/account_list_bloc.dart';
import 'package:weather_app/presentation/account_management/account_update/bloc/account_update_bloc.dart';
import 'package:weather_app/presentation/detail/bloc/detail_bloc.dart';
import 'package:weather_app/presentation/favorites_list/bloc/favorites_list_bloc.dart';
import 'package:weather_app/utils/utils_layer.dart';

import '../../../data/firebase/favorites_db_services_mock.dart';
import '../../../data/firebase/users_db_services_mock.dart';
import '../../../domain/weather/use_cases/get_weather_use_cases_test.dart';
import '../../../utils/share_pref_manager_mock.dart';

void main() {
  final UsersDBServices _services = UsersDBServicesMock();

  group('Test update event', () {
    blocTest<AccountUpdateBloc, AccountUpdateState>("Emit success state",
        build: () => AccountUpdateBloc(
              services: _services,
            ),
        act: (AccountUpdateBloc bloc) async {
          when(() => _services.updateUser(
              email: '',
              usersModel: const UsersModel(
                email: '',
                uid: '',
                isActive: false,
                isAdmin: false,
                name: '',
              ))).thenAnswer(
            (_) async => Future.value(),
          );
          bloc.add(
            AccountUpdatePressedEvent(
              email: '',
              uid: '',
              isActive: false,
              isAdmin: false,
              name: '',
            ),
          );
        },
        expect: () => <AccountUpdateState>[
              AccountUpdateLoadedState(),
            ],
        verify: (AccountUpdateBloc bloc) {
          verify(() => _services.updateUser(
              email: '',
              usersModel: const UsersModel(
                email: '',
                uid: '',
                isActive: false,
                isAdmin: false,
                name: '',
              ))).called(1);
        });

    blocTest<AccountUpdateBloc, AccountUpdateState>("Emit fail state",
        build: () => AccountUpdateBloc(
              services: _services,
            ),
        act: (AccountUpdateBloc bloc) async {
          when(() => _services.updateUser(
              email: '',
              usersModel: const UsersModel(
                email: '',
                uid: '',
                isActive: false,
                isAdmin: false,
                name: '',
              ))).thenThrow(Exception());
          bloc.add(
            AccountUpdatePressedEvent(
              email: '',
              uid: '',
              isActive: false,
              isAdmin: false,
              name: '',
            ),
          );
        },
        expect: () => <AccountUpdateState>[
              AccountUpdateFailureState(message: ''),
            ],
        verify: (AccountUpdateBloc bloc) {
          verify(() => _services.updateUser(
              email: '',
              usersModel: const UsersModel(
                email: '',
                uid: '',
                isActive: false,
                isAdmin: false,
                name: '',
              ))).called(1);
        });
  });
}
