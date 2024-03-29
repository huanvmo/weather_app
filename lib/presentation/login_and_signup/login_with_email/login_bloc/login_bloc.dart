import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../data/firebase/firebase_layer.dart';
import '../../../../generated/l10n.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.loginSignupService,
    required this.usersDBServices,
    required this.currentEmail,
    required this.emailVerified,
  }) : super(
          LoginInitialState(),
        );

  final LoginSignupService loginSignupService;
  final UsersDBServices usersDBServices;
  final String currentEmail;
  final bool emailVerified;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginPressedEvent) {
      yield* _mapLoginPressedEventToState(loginPressedEvent: event);
    }
  }

  Stream<LoginState> _mapLoginPressedEventToState(
      {required LoginPressedEvent loginPressedEvent}) async* {
    yield LoginLoadingState();
    try {
      await loginSignupService.login(
        email: loginPressedEvent.email ?? '',
        password: loginPressedEvent.password ?? '',
      );

      final UsersModel usersModel = await usersDBServices.getUser(
        email: currentEmail,
      );

      if (emailVerified) {
        if (usersModel.isActive ?? false) {
          yield LoginSuccessState();
        } else {
          yield LoginFailureState(message: 'User not active');
        }
      } else {
        yield LoginFailureState(
          message: 'User not verify',
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        yield LoginFailureState(
          message: 'User not found',
        );
      } else if (e.code == 'wrong-password') {
        yield LoginFailureState(
          message: 'Wrong password',
        );
      } else if (e.code == 'Network-request-failed') {
        yield LoginFailureState(
          message: 'Network request failed',
        );
      }
    }
  }
}
