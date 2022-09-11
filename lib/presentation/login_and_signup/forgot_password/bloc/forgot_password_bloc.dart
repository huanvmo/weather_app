import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firebase/firebase_layer.dart';
import '../../../../generated/l10n.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({required this.services})
      : super(ForgotPasswordInitState());

  final UsersDBServices services;

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    if (event is ForgotPasswordPressedEvent) {
      yield* _mapForgotPasswordPressedEventToState(
        forgotPasswordPressedEvent: event,
      );
    }
  }

  Stream<ForgotPasswordState> _mapForgotPasswordPressedEventToState(
      {required ForgotPasswordPressedEvent forgotPasswordPressedEvent}) async* {
    try {
      yield ForgotPasswordLoadingState();

      await services.sendPasswordResetEmail(
        forgotPasswordPressedEvent.emailText,
      );

      yield ForgotPasswordLoadedState();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        yield ForgotPasswordFailureState(
          message: 'user-not-found',
        );
      } else if (e.code == 'Network-request-failed') {
        yield ForgotPasswordFailureState(
          message: 'Network-request-failed',
        );
      }
    }
  }
}
