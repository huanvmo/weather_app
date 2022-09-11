import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/firebase/firebase_layer.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({
    required this.services,
    required this.email,
  }) : super(AccountInitState());

  final UsersDBServices services;
  final String email;
  UsersModel? _usersModel;

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is AccountLoadEvent) {
      yield AccountLoadedState(
        usersModel: await services.getUser(email: email),
      );
    } else if (event is AccountChangeUserNameEvent) {
      yield* _mapChangeUserNameEventToState(
        accountChangeUserNameEvent: event,
      );
    } else if (event is AccountChangeUserPhotoEvent) {
      yield* _mapChangeUserPhotoEventToState(
        accountChangeUserPhotoEvent: event,
      );
    }
  }

  Stream<AccountState> _mapChangeUserNameEventToState(
      {required AccountChangeUserNameEvent accountChangeUserNameEvent}) async* {
    try {
      yield AccountLoadingState();

      await services.updateUserDisplayName(
        userName: accountChangeUserNameEvent.userName,
      );
      final UsersModel _model = await services.getUser(email: email);

      yield AccountLoadedState(usersModel: _model);
    } catch (e) {
      print(e);
      yield AccountFailureState(
        message: e.toString(),
      );
    }
  }

  Stream<AccountState> _mapChangeUserPhotoEventToState(
      {required AccountChangeUserPhotoEvent
          accountChangeUserPhotoEvent}) async* {
    yield AccountLoadingState();
    try {
      await services.updateUserAvatar(
        photoUrl: accountChangeUserPhotoEvent.photoURL.path,
      );

      _usersModel = await services.getUser(email: email);

      yield AccountLoadedState(usersModel: _usersModel!);
    } on Exception catch (error) {
      yield AccountFailureState(
        message: error.toString(),
      );
    }
  }

}
