import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/firebase/firebase_layer.dart';
import '../../../utils/utils_layer.dart';
import 'login_bloc/login_bloc.dart';
import 'ui/login_screen.dart';

class LoginScreenRoute {
  static Widget get route => BlocProvider(
        create: (context) => LoginBloc(
          loginSignupService: getIt<LoginSignupService>(),
          usersDBServices: getIt<UsersDBServices>(),
          currentEmail: FirebaseAuth.instance.currentUser?.email ?? '',
          emailVerified:
              FirebaseAuth.instance.currentUser?.emailVerified ?? false,
        ),
        child: const LoginScreen(),
      );
}
