import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firebase/firebase_layer.dart';

part 'account_list_event.dart';
part 'account_list_state.dart';

class AccountListBloc extends Bloc<AccountListEvent, AccountListState> {
  AccountListBloc({required this.services}) : super(AccountListInitState());

  final UsersDBServices services;

  @override
  Stream<AccountListState> mapEventToState(AccountListEvent event) async* {
    if (event is AccountListLoadEvent) {
      yield* _mapAccountListLoadEventToState();
    } else if (event is AccountListLoadedEvent) {
      yield* _mapAccountListLoadedEventToState(
        accountListLoadedEvent: event,
      );
    } else if (event is AccountListDeletePressedEvent) {
      yield* _mapAccountListDeletePressedEventToState(
        accountListDeletePressedEvent: event,
      );
    }
  }

  Stream<AccountListState> _mapAccountListLoadEventToState() async* {
    try {
      yield AccountListLoadingState();
      services.getListUsers().listen(
            (users) => add(
              AccountListLoadedEvent(list: users),
            ),
          );
    } catch (e) {
      yield AccountListFailureState(
        message: e.toString(),
      );
    }
  }

  Stream<AccountListState> _mapAccountListLoadedEventToState(
      {required AccountListLoadedEvent accountListLoadedEvent}) async* {
    try {
      yield AccountListLoadedState(
        listUsers: accountListLoadedEvent.list,
      );
    } catch (e) {
      yield AccountListFailureState(
        message: e.toString(),
      );
    }
  }

  Stream<AccountListState> _mapAccountListDeletePressedEventToState(
      {required AccountListDeletePressedEvent
          accountListDeletePressedEvent}) async* {
    yield AccountListLoadingState();
    try {
      await services.deleteUser(
        email: accountListDeletePressedEvent.email,
      );
    } catch (error) {
      yield AccountListFailureState(
        message: error.toString(),
      );
    }
  }
}
