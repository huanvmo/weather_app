import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firebase/firebase_layer.dart';

part 'account_update_event.dart';

part 'account_update_state.dart';

class AccountUpdateBloc extends Bloc<AccountUpdateEvent, AccountUpdateState> {
  AccountUpdateBloc({required this.services}) : super(AccountUpdateInitState());

  final UsersDBServices services;

  @override
  Stream<AccountUpdateState> mapEventToState(AccountUpdateEvent event) async* {
    if (event is AccountUpdatePressedEvent) {
      yield* _mapAccountUpdatePressedEventToState(
        accountUpdatePressedEvent: event,
      );
    }
  }

  Stream<AccountUpdateState> _mapAccountUpdatePressedEventToState(
      {required AccountUpdatePressedEvent accountUpdatePressedEvent}) async* {
    try {
      final UsersModel _model = UsersModel(
        email: accountUpdatePressedEvent.email,
        name: accountUpdatePressedEvent.name,
        uid: accountUpdatePressedEvent.uid,
        isAdmin: accountUpdatePressedEvent.isAdmin,
        isActive: accountUpdatePressedEvent.isActive,
      );
      await services.updateUser(
        email: accountUpdatePressedEvent.email,
        usersModel: _model,
      );
      yield AccountUpdateLoadedState();
    } catch (e) {
      yield AccountUpdateFailureState(
        message: e.toString(),
      );
    }
  }
}
