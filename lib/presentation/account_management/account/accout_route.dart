import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/firebase/firebase_layer.dart';
import '../../../utils/utils_layer.dart';
import 'bloc/account_bloc.dart';
import 'ui/account_screen.dart';

class AccountScreenRoute {
  static Widget get route => BlocProvider(
        create: (context) => AccountBloc(
          services: getIt<UsersDBServices>(),
          email: FirebaseAuth.instance.currentUser?.email ?? '',
        )..add(
            AccountLoadEvent(),
          ),
        child: const AccountScreen(),
      );
}
