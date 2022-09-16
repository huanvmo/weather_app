part of 'signup_bloc.dart';

@immutable
abstract class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupInitialState extends SignupState {}

class SignupSuccessState extends SignupState {}

class SignupFailureState extends SignupState {
  final String message;

  SignupFailureState({required this.message});
}

class SignupLoadingState extends SignupState {}
