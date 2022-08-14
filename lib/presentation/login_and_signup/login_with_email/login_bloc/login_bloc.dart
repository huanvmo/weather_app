import 'dart:async';

import 'package:bloc/bloc.dart';
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
  }) : super(
          LoginInitialState(),
        );

  final LoginSignupService loginSignupService;
  final UsersDBServices usersDBServices;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginLoadEvent) {
      yield* _mapLoginLoadEventToState();
    } else if (event is LoginPressedEvent) {
      yield* _mapLoginPressedEventToState(loginPressedEvent: event);
    }
  }

  Stream<LoginState> _mapLoginLoadEventToState() async* {
    try {
      yield LoginLoadingState();
    } catch (e) {
      yield LoginFailureState(
        message: e.toString(),
      );
    }
  }

  Stream<LoginState> _mapLoginPressedEventToState(
      {required LoginPressedEvent loginPressedEvent}) async* {
    yield LoginLoadingState();
    try {
      await loginSignupService.login(
        email: loginPressedEvent.email!,
        password: loginPressedEvent.password!,
      );

      final UsersModel usersModel = await usersDBServices.getUser(
        email: FirebaseAuth.instance.currentUser!.email!,
      );

      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        if (usersModel.isActive == true) {
          yield LoginSuccessState();
        } else {
          yield LoginFailureState(message: S.current.userNotActive);
        }
      } else {
        yield LoginFailureState(
          message: S.current.userNotVerify,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        yield LoginFailureState(
          message: S.current.userNotFound,
        );
      } else if (e.code == 'wrong-password') {
        yield LoginFailureState(
          message: S.current.wrongPassword,
        );
      } else if (e.code == 'Network-request-failed') {
        yield LoginFailureState(
          message: S.current.networkError,
        );
      }
    }
  }
}
