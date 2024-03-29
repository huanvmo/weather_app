import 'package:flutter/material.dart';

import '../../../../../utils/utils_layer.dart';
import '../../../../common/widget/common_custom_paint.dart';
import '../../../../common/widget/information_widget.dart';
import '../../bloc/home_bloc.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    Key? key,
    required this.homeLoadedState,
  }) : super(key: key);

  final HomeLoadedState homeLoadedState;

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CommonCustomPaint(),
        SafeArea(
          child: InformationWidget(
            weatherState: widget
                    .homeLoadedState.weatherModel.weather?.first.description ??
                '',
            temperature: widget.homeLoadedState.weatherModel.main?.temp ?? 0,
            pressure: widget.homeLoadedState.weatherModel.main?.pressure ?? 0,
            humidity: widget.homeLoadedState.weatherModel.main?.humidity ?? 0,
            countryName: widget.homeLoadedState.weatherModel.sys?.country ?? '',
            cityName: widget.homeLoadedState.weatherModel.name ?? '',
            windSpeed: widget.homeLoadedState.weatherModel.wind?.speed ?? 0,
            widget: const Spacer(),
            iconButton: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteDefine.settingsScreen.name);
              },
              icon: const Icon(
                Icons.settings,
              ),
            ),
            isMetric: !SessionUtils.getMetric,
          ),
        ),
      ],
    );
  }
}
