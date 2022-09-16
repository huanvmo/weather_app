import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../data/firebase/firebase_layer.dart';
import '../../../../generated/l10n.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({required this.service})
      : super(
          SignupInitialState(),
        );

  final LoginSignupService service;

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignupPressedEvent) {
      yield* _mapSignupPressedEventToState(signupPressedEvent: event);
    }
  }

  Stream<SignupState> _mapSignupPressedEventToState(
      {required SignupPressedEvent signupPressedEvent}) async* {
    yield SignupLoadingState();
    try {
      await service.signup(
        email: signupPressedEvent.email,
        password: signupPressedEvent.password,
        name: signupPressedEvent.name,
      );

      yield SignupSuccessState();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        yield SignupFailureState(
          message: 'email-already-in-use',
        );
      } else if (e.code == 'network-request-failed') {
        yield SignupFailureState(
          message: 'network-request-failed',
        );
      }
    }
  }
}
