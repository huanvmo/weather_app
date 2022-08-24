import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_text_style.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils_layer.dart';
import '../../common/widget/back_app_bar_icon_button.dart';
import '../../common/widget/loading_widget.dart';
import '../bloc/favorites_list_bloc.dart';

class FavoritesListScreen extends StatelessWidget {
  const FavoritesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: const BackAppBarIconButton(),
        title: Text(
          S.current.favoritesList,
          style: AppTextStyle.fontSize20.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: BlocBuilder<FavoritesListBloc, FavoritesListState>(
        builder: (context, state) {
          if (state is FavoritesListLoadingState) {
            return const Loading();
          } else if (state is FavoritesListLoadedState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if (state.favoritesModel.isNotEmpty) {
                  return ListTile(
                    title: Text(state.favoritesModel[index].countryName ?? ''),
                    trailing: IconButton(
                      onPressed: () async {
                        context.read<FavoritesListBloc>().add(
                              FavoritesListDeleteEvent(
                                countryModel:
                                    state.favoritesModel[index].countryName ??
                                        '',
                              ),
                            );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        RouteDefine.detailScreen.name,
                        arguments: DetailArgument(
                          countryName:
                              state.favoritesModel[index].countryName ?? '',
                          cityName:
                              state.favoritesModel[index].countryName ?? '',
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: Text(S.current.noData),
                );
              },
              itemCount: state.favoritesModel.length,
            );
          } else if (state is FavoritesListFailureState) {
            return Center(
              child: Text(
                S.current.fail(state.message),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
