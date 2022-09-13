import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/firebase/firebase_layer.dart';
import '../../../utils/utils_layer.dart';
import 'bloc/forgot_password_bloc.dart';
import 'ui/forgor_password_screen.dart';

class ForgotPasswordScreenRoute {
  static Widget get route => BlocProvider(
        create: (context) =>
            ForgotPasswordBloc(services: getIt<UsersDBServices>())
              ..add(
                ForgotPasswordLoadEvent(),
              ),
        child: const ForgotPasswordScreen(),
      );
}
