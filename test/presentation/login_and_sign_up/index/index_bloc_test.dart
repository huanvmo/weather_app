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
import '../../../utils/login_signup_service_mock.dart';

void main() {
  final LoginSignupService _services = LoginSignupServiceMock();

  group('Test google login event', () {
    blocTest<IndexBloc, IndexState>("Emit success state",
        build: () => IndexBloc(service: _services),
        act: (IndexBloc bloc) async {
          when(() => _services.googleLogin()).thenAnswer(
            (_) async => Future.value(),
          );
          bloc.add(
            IndexGoogleLoginPressedEvent(),
          );
        },
        expect: () => <IndexState>[
              IndexLoadingState(),
              IndexLoginSuccessState(),
            ],
        verify: (IndexBloc bloc) {
          verify(() => _services.googleLogin()).called(1);
        });

    blocTest<IndexBloc, IndexState>("Emit fail state",
        build: () => IndexBloc(service: _services),
        act: (IndexBloc bloc) async {
          when(() => _services.googleLogin())
              .thenThrow(Exception());
          bloc.add(
            IndexGoogleLoginPressedEvent(),
          );
        },
        expect: () => <IndexState>[
              IndexLoadingState(),
              IndexFailureState(),
            ],
        verify: (IndexBloc bloc) {
          verify(() => _services.googleLogin()).called(1);
        });
  });
}
