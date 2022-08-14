import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/firebase/firebase_layer.dart';
import '../../../utils/utils_layer.dart';
import 'bloc/account_list_bloc.dart';
import 'ui/account_list_screen.dart';

class AccountListScreenRoute {
  static Widget get route => BlocProvider(
        create: (context) => AccountListBloc(
          services: getIt<UsersDBServices>(),
        )..add(
            AccountListLoadEvent(),
          ),
        child: const AccountListScreen(),
      );
}
