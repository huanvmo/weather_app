part of 'account_bloc.dart';

abstract class AccountState extends Equatable{
  @override
  List<Object?> get props => [];
}

class AccountInitState extends AccountState {}

class AccountLoadedState extends AccountState {
  final UsersModel usersModel;

  AccountLoadedState({
    required this.usersModel,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    usersModel,
  ];
}

class AccountLoadingState extends AccountState {}

class AccountFailureState extends AccountState {
  AccountFailureState({required this.message});

  final String message;
}
