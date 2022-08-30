import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/config/app_colors.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/common/method/common_show_dialog.dart';
import 'package:weather_app/presentation/common/widget/back_app_bar_icon_button.dart';
import 'package:weather_app/presentation/common/widget/fl_chart.dart';
import 'package:weather_app/presentation/common/widget/information_widget.dart';
import 'package:weather_app/presentation/common/widget/loading_widget.dart';

import '../../controller/detail/detail_bloc.dart';
import '../../models/favorites/favorites_model.dart';
import '../utils/utils_layer.dart';


class DetailScreen extends StatefulWidget {
  const DetailScreen({
    Key? key,
    required this.countryName,
    required this.cityName,
  }) : super(key: key);

  final String countryName;
  final String cityName;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFavorite = false;

  User? _user;

  onRefresh(userCred) {
    setState(() {
      _user = userCred;
    });
  }

  @override
  void initState() {
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<DetailBloc, DetailState>(
        listener: (_, state) {
          if (state is DetailFailureState) {
            showConfirmDialog(
              context,
              title: 'Error',
              subTitle: state.message,
              textButton: S.current.reload,
            );
          }
          if (state is DetailLoadedState) {
            for (var element in state.listFav) {
              if (element.countryName == widget.countryName) {
                _isFavorite = true;
              }
            }
          }
        },
        builder: (context, state) {
          if (state is DetailLoadingState) {
            return const Loading();
          } else if (state is DetailLoadedState) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: const BackAppBarIconButton(),
                actions: [
                  _user != null
                      ? IconButton(
                          onPressed: () {
                            if (_isFavorite) {
                              context.read<DetailBloc>().add(
                                    DetailFavoriteButtonPressedEvent(
                                      isFavorite: false,
                                      model: FavoritesModel(
                                        countryName: widget.countryName,
                                        cityName: widget.cityName,
                                      ),
                                    ),
                                  );
                            } else {
                              context.read<DetailBloc>().add(
                                    DetailFavoriteButtonPressedEvent(
                                      model: FavoritesModel(
                                        countryName: widget.countryName,
                                        cityName: widget.cityName,
                                      ),
                                    ),
                                  );
                            }
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                          },
                          icon: _isFavorite
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
                            Navigator.pushReplacementNamed(context,
                                RouteDefine.loginSignupIndexScreen.name);
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
                  humidity: state.detailModel.days?.first.humidity ?? 0,
                  pressure: state.detailModel.days?.first.pressure ?? 0,
                  temperature: state.detailModel.days?.first.temp ?? 0,
                  weatherState: state.detailModel.days?.first.conditions ?? '',
                  windSpeed: state.detailModel.days?.first.windSpeed ?? 0,
                  widget: FLChart(
                    list: state.detailModel.days ?? [],
                  ),
                ),
              ),
            );
          }
          return const Loading();
        },
      );
}
