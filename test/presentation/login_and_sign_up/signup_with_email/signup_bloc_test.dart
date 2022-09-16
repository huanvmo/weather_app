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
import 'package:weather_app/presentation/login_and_signup/signup_with_email/signup_bloc/signup_bloc.dart';
import '../../../utils/login_signup_service_mock.dart';
import '../../../utils/user_db_services.dart';

void main() {
  final LoginSignupService _services = LoginSignupServiceMock();

  group('Test signup with email event', () {
    blocTest<SignupBloc, SignupState>("Emit success state",
        build: () => SignupBloc(service: _services),
        act: (SignupBloc bloc) async {
          when(() => _services.signup(name: '', email: '', password: ''))
              .thenAnswer(
            (_) async => Future.value(),
          );

          bloc.add(
            SignupPressedEvent(email: '', password: '', name: ''),
          );
        },
        expect: () => <SignupState>[
              SignupLoadingState(),
              SignupSuccessState(),
            ],
        verify: (SignupBloc bloc) {
          verify(() => _services.signup(name: '', email: '', password: ''))
              .called(1);
        });

    blocTest<SignupBloc, SignupState>("Emit false state email in use",
        build: () => SignupBloc(service: _services),
        act: (SignupBloc bloc) async {
          when(() => _services.signup(email: '', password: '', name: ''))
              .thenThrow(FirebaseAuthException(message: 'email-already-in-use',code: 'email-already-in-use'));

          bloc.add(
            SignupPressedEvent(email: '', password: '', name: ''),
          );
        },
        expect: () => <SignupState>[
              SignupLoadingState(),
              SignupFailureState(
                message: 'email-already-in-use',
              ),
            ],
        verify: (SignupBloc bloc) {
          verify(() => _services.signup(email: '', password: '', name: ''))
              .called(1);
        });

    blocTest<SignupBloc, SignupState>("Emit false state network-request-failed",
        build: () => SignupBloc(service: _services),
        act: (SignupBloc bloc) async {
          when(() => _services.signup(email: '', password: '', name: ''))
              .thenThrow(FirebaseAuthException(message: 'network-request-failed',code: 'network-request-failed'));

          bloc.add(
            SignupPressedEvent(email: '', password: '', name: ''),
          );
        },
        expect: () => <SignupState>[
          SignupLoadingState(),
          SignupFailureState(
            message: 'network-request-failed',
          ),
        ],
        verify: (SignupBloc bloc) {
          verify(() => _services.signup(email: '', password: '', name: ''))
              .called(1);
        });
  });
}
