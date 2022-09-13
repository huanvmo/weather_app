part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordInitState extends ForgotPasswordState {}

class ForgotPasswordLoadedState extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}

class ForgotPasswordFailureState extends ForgotPasswordState {
  final String message;
  ForgotPasswordFailureState({required this.message});
}
