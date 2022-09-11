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
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/account_management/account/bloc/account_bloc.dart';
import 'package:weather_app/presentation/account_management/account_list/bloc/account_list_bloc.dart';
import 'package:weather_app/presentation/detail/bloc/detail_bloc.dart';
import 'package:weather_app/presentation/favorites_list/bloc/favorites_list_bloc.dart';
import 'package:weather_app/presentation/login_and_signup/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:weather_app/utils/utils_layer.dart';

import '../../../data/firebase/favorites_db_services_mock.dart';
import '../../../data/firebase/users_db_services_mock.dart';
import '../../../domain/weather/use_cases/get_weather_use_cases_test.dart';
import '../../../utils/share_pref_manager_mock.dart';

void main() {
  final UsersDBServices _services = UsersDBServicesMock();

  group('Test forgot pass event', () {
    blocTest<ForgotPasswordBloc, ForgotPasswordState>("Emit success state",
        build: () => ForgotPasswordBloc(services: _services),
        act: (ForgotPasswordBloc bloc) async {
          when(() => _services.sendPasswordResetEmail('')).thenAnswer(
            (_) async => Future.value(),
          );
          bloc.add(
            ForgotPasswordPressedEvent(emailText: ''),
          );
        },
        expect: () => <ForgotPasswordState>[
              ForgotPasswordLoadingState(),
              ForgotPasswordLoadedState(),
            ],
        verify: (ForgotPasswordBloc bloc) {
          verify(() => _services.sendPasswordResetEmail('')).called(1);
        });

    blocTest<ForgotPasswordBloc, ForgotPasswordState>(
        "Emit fail state throw user-not-found",
        build: () => ForgotPasswordBloc(services: _services),
        act: (ForgotPasswordBloc bloc) async {
          when(() => _services.sendPasswordResetEmail(''))
              .thenThrow(FirebaseAuthException(code: 'user-not-found'));
          bloc.add(
            ForgotPasswordPressedEvent(emailText: ''),
          );
        },
        expect: () => <ForgotPasswordState>[
              ForgotPasswordLoadingState(),
              ForgotPasswordFailureState(message: 'user-not-found'),
            ],
        verify: (ForgotPasswordBloc bloc) {
          verify(() => _services.sendPasswordResetEmail('')).called(1);
        });

    blocTest<ForgotPasswordBloc, ForgotPasswordState>(
        "Emit fail state throw Network-request-failed",
        build: () => ForgotPasswordBloc(services: _services),
        act: (ForgotPasswordBloc bloc) async {
          when(() => _services.sendPasswordResetEmail(''))
              .thenThrow(FirebaseAuthException(code: 'Network-request-failed'));
          bloc.add(
            ForgotPasswordPressedEvent(emailText: ''),
          );
        },
        expect: () => <ForgotPasswordState>[
              ForgotPasswordLoadingState(),
              ForgotPasswordFailureState(message: 'Network-request-failed'),
            ],
        verify: (ForgotPasswordBloc bloc) {
          verify(() => _services.sendPasswordResetEmail('')).called(1);
        });
  });
}
