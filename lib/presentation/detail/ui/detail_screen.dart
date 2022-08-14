import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widget/loading_widget.dart';
import '../bloc/detail_bloc.dart';
import 'widgets/detail_failure_widget.dart';
import 'widgets/detail_loaded_widget.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.countryName,
    required this.cityName,
  }) : super(key: key);

  final String countryName;
  final String cityName;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state is DetailLoadingState) {
              return const Loading();
            } else if (state is DetailLoadedState) {
              return DetailLoadedWidget(
                detailModel: state.detailModel!,
                countryName: countryName,
                cityName: cityName,
              );
            } else if (state is DetailFailureState) {
              return DetailFailureWidget(
                state: state,
                // locationModel: widget.detailArguments.locationModel!,
              );
            }
            return const Loading();
          },
        ),
      );
}
