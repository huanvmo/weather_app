part of 'account_list_bloc.dart';

abstract class AccountListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccountListInitState extends AccountListState {}

class AccountListLoadedState extends AccountListState {
  final List<UsersModel> listUsers;

  AccountListLoadedState({
    required this.listUsers,
  });
}

class AccountListLoadingState extends AccountListState {}

class AccountListFailureState extends AccountListState {
  final String message;

  AccountListFailureState({
    required this.message,
  });
}
