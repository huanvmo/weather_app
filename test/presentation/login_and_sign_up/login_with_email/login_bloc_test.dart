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

import 'package:weather_app/data/firebase/firebase_layer.dart';

import 'package:weather_app/presentation/login_and_signup/index/bloc/index_bloc.dart';
import 'package:weather_app/presentation/login_and_signup/login_with_email/login_bloc/login_bloc.dart';
import '../../../utils/login_signup_service_mock.dart';
import '../../../utils/user_db_services.dart';

void main() {
  final LoginSignupService _loginServices = LoginSignupServiceMock();
  final UsersDBServices _userServices = UserDbServicesMock();

  group('Test login with email event', () {
    blocTest<LoginBloc, LoginState>("Emit success state",
        build: () => LoginBloc(
              loginSignupService: _loginServices,
              usersDBServices: _userServices,
              emailVerified: true,
              currentEmail: '',
            ),
        act: (LoginBloc bloc) async {
          when(() => _loginServices.login(email: '', password: '')).thenAnswer(
            (_) async => Future.value(),
          );

          when(() => _userServices.getUser(email: '')).thenAnswer(
            (_) async => const UsersModel(isActive: true),
          );
          bloc.add(
            LoginPressedEvent(),
          );
        },
        expect: () => <LoginState>[
              LoginLoadingState(),
              LoginSuccessState(),
            ],
        verify: (LoginBloc bloc) {
          verify(() => _loginServices.login(email: '', password: '')).called(1);
          verify(() => _userServices.getUser(
                email: '',
              )).called(1);
        });

    blocTest<LoginBloc, LoginState>("Emit false state user not active",
        build: () => LoginBloc(
              loginSignupService: _loginServices,
              usersDBServices: _userServices,
              emailVerified: true,
              currentEmail: '',
            ),
        act: (LoginBloc bloc) async {
          when(() => _loginServices.login(email: '', password: '')).thenAnswer(
            (_) async => Future.value(),
          );

          when(() => _userServices.getUser(email: '')).thenAnswer(
            (_) async => const UsersModel(),
          );
          bloc.add(
            LoginPressedEvent(),
          );
        },
        expect: () => <LoginState>[
              LoginLoadingState(),
              LoginFailureState(message: 'User not active'),
            ],
        verify: (LoginBloc bloc) {
          verify(() => _loginServices.login(email: '', password: '')).called(1);
          verify(() => _userServices.getUser(
                email: '',
              )).called(1);
        });

    blocTest<LoginBloc, LoginState>("Emit false state user not verify",
        build: () => LoginBloc(
              loginSignupService: _loginServices,
              usersDBServices: _userServices,
              emailVerified: false,
              currentEmail: '',
            ),
        act: (LoginBloc bloc) async {
          when(() => _loginServices.login(email: '', password: '')).thenAnswer(
            (_) async => Future.value(),
          );

          when(() => _userServices.getUser(email: '')).thenAnswer(
            (_) async => const UsersModel(),
          );
          bloc.add(
            LoginPressedEvent(),
          );
        },
        expect: () => <LoginState>[
              LoginLoadingState(),
              LoginFailureState(message: 'User not verify'),
            ],
        verify: (LoginBloc bloc) {
          verify(() => _loginServices.login(email: '', password: '')).called(1);
          verify(() => _userServices.getUser(
                email: '',
              )).called(1);
        });

    blocTest<LoginBloc, LoginState>("Emit false state user not found",
        build: () => LoginBloc(
              loginSignupService: _loginServices,
              usersDBServices: _userServices,
              emailVerified: false,
              currentEmail: '',
            ),
        act: (LoginBloc bloc) async {
          when(() => _loginServices.login(email: '', password: ''))
              .thenThrow(FirebaseAuthException(code: 'user-not-found'));

          bloc.add(
            LoginPressedEvent(),
          );
        },
        expect: () => <LoginState>[
              LoginLoadingState(),
              LoginFailureState(message: 'User not found'),
            ],
        verify: (LoginBloc bloc) {
          verify(() => _loginServices.login(email: '', password: '')).called(1);
        });

    blocTest<LoginBloc, LoginState>("Emit false state wrong password",
        build: () => LoginBloc(
              loginSignupService: _loginServices,
              usersDBServices: _userServices,
              emailVerified: false,
              currentEmail: '',
            ),
        act: (LoginBloc bloc) async {
          when(() => _loginServices.login(email: '', password: ''))
              .thenThrow(FirebaseAuthException(code: 'wrong-password'));

          bloc.add(
            LoginPressedEvent(),
          );
        },
        expect: () => <LoginState>[
              LoginLoadingState(),
              LoginFailureState(message: 'Wrong password'),
            ],
        verify: (LoginBloc bloc) {
          verify(() => _loginServices.login(email: '', password: '')).called(1);
        });

    blocTest<LoginBloc, LoginState>("Emit false state network fail",
        build: () => LoginBloc(
              loginSignupService: _loginServices,
              usersDBServices: _userServices,
              emailVerified: false,
              currentEmail: '',
            ),
        act: (LoginBloc bloc) async {
          when(() => _loginServices.login(email: '', password: ''))
              .thenThrow(FirebaseAuthException(code: 'Network-request-failed'));

          bloc.add(
            LoginPressedEvent(),
          );
        },
        expect: () => <LoginState>[
              LoginLoadingState(),
              LoginFailureState(message: 'Network request fail'),
            ],
        verify: (LoginBloc bloc) {
          verify(() => _loginServices.login(email: '', password: '')).called(1);
        });
  });
}
