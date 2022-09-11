part of 'account_update_bloc.dart';

abstract class AccountUpdateState extends Equatable{

  @override
  List<Object?> get props => [];
}

class AccountUpdateInitState extends AccountUpdateState {}

class AccountUpdateLoadedState extends AccountUpdateState {}

class AccountUpdateLoadingState extends AccountUpdateState {}

class AccountUpdateFailureState extends AccountUpdateState {
 final String message;
  AccountUpdateFailureState({required this.message});
}
