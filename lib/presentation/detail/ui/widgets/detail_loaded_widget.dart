import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';
import '../../../../data/weather/weather_data.dart';
import '../../../../utils/utils_layer.dart';
import '../../../common/widget/back_app_bar_icon_button.dart';
import '../../../common/widget/fl_chart.dart';
import '../../../common/widget/information_widget.dart';

class DetailLoadedWidget extends StatefulWidget {
  const DetailLoadedWidget({
    Key? key,
    required this.cityName,
    required this.countryName,
    required this.detailModel,
  }) : super(key: key);
  final String cityName;
  final String countryName;
  final DetailModel detailModel;

  @override
  _DetailLoadedWidgetState createState() => _DetailLoadedWidgetState();
}

class _DetailLoadedWidgetState extends State<DetailLoadedWidget> {
  late bool isFavorite;

  User? user;

  onRefresh(userCred) {
    setState(() {
      user = userCred;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // isFavorite = widget.detailArguments.favoritesModel?.favorite ?? false;
    onRefresh(FirebaseAuth.instance.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: const BackAppBarIconButton(),
        actions: [
          user != null
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                    // context.read<DetailBloc>().add(
                    //       DetailFavoriteButtonPressedEvent(
                    //         woeid: widget
                    //                 .detailArguments.locationModel?.woeid ??
                    //             widget.detailArguments.favoritesModel!.woeid,
                    //         favorite: isFavorite,
                    //         locationName: widget.state.detailModel?.title ??
                    //             widget.detailArguments.favoritesModel!
                    //                 .locationName,
                    //         docID: widget.detailArguments.favoritesModel!.docID,
                    //       ),
                    //     );
                  },
                  icon: isFavorite
                      ? Icon(
                          Icons.favorite,
                          color: AppColors.dangerColor,
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: AppColors.dangerColor,
                        ),
                )
              : IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RouteDefine.loginSignupIndexScreen.name);
                  },
                  icon: Icon(
                    Icons.favorite_border,
                    color: AppColors.dangerColor,
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: InformationWidget(
          isMetric: !SessionUtils.getMetric!,
          cityName: widget.cityName,
          countryName: widget.countryName,
          humidity: widget.detailModel.days.first.humidity ?? 0,
          pressure: widget.detailModel.days.first.pressure ?? 0,
          temperature: widget.detailModel.days.first.temp ?? 0,
          weatherState: widget.detailModel.days.first.conditions ?? '',
          windSpeed: widget.detailModel.days.first.windSpeed ?? 0,
          widget: FLChart(
            list: widget.detailModel.days,
          ),
        ),
      ),
    );
  }
}
