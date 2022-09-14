
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/data/firebase/firebase_layer.dart';
import 'package:weather_app/presentation/account_management/account/bloc/account_bloc.dart';

import '../../../data/firebase/users_db_services_mock.dart';

void main() {
  final UsersDBServices _services = UsersDBServicesMock();

  group('Test load event', () {
    blocTest<AccountBloc, AccountState>("Emit success state",
        build: () => AccountBloc(
              services: _services,
              email: '',
            ),
        act: (AccountBloc bloc) async {
          when(() => _services.getUser(email: '')).thenAnswer(
            (_) async => const UsersModel(),
          );

          bloc.add(
            AccountLoadEvent(),
          );
        },
        expect: () => <AccountState>[
              AccountLoadedState(usersModel: const UsersModel()),
            ],
        verify: (AccountBloc bloc) {
          verify(() => _services.getUser(email: '')).called(1);
        });
  });

  group('Test change user name event', () {
    blocTest<AccountBloc, AccountState>("Emit success state",
        build: () => AccountBloc(
              services: _services,
              email: '',
            ),
        act: (AccountBloc bloc) async {
          when(() => _services.updateUserDisplayName(userName: '')).thenAnswer(
            (_) async => Future.value(),
          );
          when(() => _services.getUser(email: '')).thenAnswer(
            (_) async => const UsersModel(),
          );

          bloc.add(
            AccountChangeUserNameEvent(userName: ''),
          );
        },
        expect: () => <AccountState>[
              AccountLoadingState(),
              AccountLoadedState(usersModel: const UsersModel()),
            ],
        verify: (AccountBloc bloc) {
          verify(() => _services.getUser(email: '')).called(1);
          verify(() => _services.updateUserDisplayName(userName: '')).called(1);
        });

    blocTest<AccountBloc, AccountState>("Emit fail state",
        build: () => AccountBloc(
              services: _services,
              email: '',
            ),
        act: (AccountBloc bloc) async {
          when(() => _services.updateUserDisplayName(userName: ''))
              .thenThrow(Exception());

          bloc.add(
            AccountChangeUserNameEvent(userName: ''),
          );
        },
        expect: () => <AccountState>[
              AccountLoadingState(),
              AccountFailureState(message: ''),
            ],
        verify: (AccountBloc bloc) {
          verify(() => _services.updateUserDisplayName(userName: '')).called(1);
        });
  });
  group('Test change user photo event', () {
    blocTest<AccountBloc, AccountState>("Emit success state",
        build: () => AccountBloc(
              services: _services,
              email: '',
            ),
        act: (AccountBloc bloc) async {
          when(() => _services.updateUserAvatar(photoUrl: '')).thenAnswer(
            (_) async => Future.value(),
          );
          when(() => _services.getUser(email: '')).thenAnswer(
            (_) async => const UsersModel(),
          );

          bloc.add(
            AccountChangeUserPhotoEvent(photoURL: XFile('')),
          );
        },
        expect: () => <AccountState>[
              AccountLoadingState(),
              AccountLoadedState(usersModel: const UsersModel()),
            ],
        verify: (AccountBloc bloc) {
          verify(() => _services.getUser(email: '')).called(1);
          verify(() => _services.updateUserAvatar(photoUrl: '')).called(1);
        });

    blocTest<AccountBloc, AccountState>("Emit fail state",
        build: () => AccountBloc(
              services: _services,
              email: '',
            ),
        act: (AccountBloc bloc) async {
          when(() => _services.updateUserAvatar(photoUrl: ''))
              .thenThrow(Exception());

          bloc.add(
            AccountChangeUserPhotoEvent(photoURL: XFile('')),
          );
        },
        expect: () => <AccountState>[
              AccountLoadingState(),
              AccountFailureState(message: ''),
            ],
        verify: (AccountBloc bloc) {
          verify(() => _services.updateUserAvatar(photoUrl: '')).called(1);
        });
  });
}
