import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/common/widget/loading_widget.dart';
import 'package:weather_app/presentation/main/home/ui/widgets/home_widgets.dart';

import '../../../controller/home/home_bloc.dart';
import 'widgets/home_failure_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Loading();
            } else if (state is HomeLoadedState) {
              return HomeWidget(
                homeLoadedState: state,
              );
            } else if (state is HomeFailureState) {
              return HomeFailureWidget(
                homeFailureState: state,
              );
            }
            return const Loading();
          },
        ),
      );
}
