import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/home/home_bloc.dart';
import 'home_screen.dart';

class HomeScreenRoute {
  static Widget get route => BlocProvider(
        create: (context) => HomeBloc(

        )..add(
            HomeLoadEvent(),
          ),
        child: const HomeScreen(),
      );
}
