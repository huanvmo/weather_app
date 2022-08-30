import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/config/app_colors.dart';
import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/common/method/common_show_dialog.dart';
import 'package:weather_app/presentation/common/method/loading_dialog.dart';
import 'package:weather_app/presentation/common/widget/common_custom_paint.dart';
import 'package:weather_app/presentation/common/widget/common_text_form_field.dart';
import 'package:weather_app/presentation/main/search/ui/widgets/search_result_widget.dart';

import '../../../controller/search/search_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CommonCustomPaint(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CommonTextFormField(
                  focusedBorderColor: AppColors.white,
                  controller: controller,
                  labelText: S.current.search,
                  prefixIcon: const Icon(Icons.search),
                  textInputAction: TextInputAction.search,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return S.current.characterRequire;
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<SearchBloc>().add(
                            SearchPressedEvent(
                              cityName: controller.text,
                            ),
                          );
                    }
                  },
                ),
              ),
              BlocConsumer<SearchBloc, SearchState>(
                listener: (context, state) {
                  switch (state.runtimeType) {
                    case SearchFailureState:
                      state as SearchFailureState;
                      LoadingDialog.hideLoadingDialog(context);
                      showConfirmDialog(
                        context,
                        title: "Error",
                        subTitle: state.message,
                        textButton: S.current.reload,
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<SearchBloc>().add(
                                SearchLoadEvent(),
                              );
                        },
                      );
                      break;
                    case SearchResultState:
                      LoadingDialog.hideLoadingDialog(context);
                      break;
                    case SearchLoadingState:
                      LoadingDialog.showLoadingDialog(context);
                      break;
                  }
                },
                builder: (_, state) {
                  switch (state.runtimeType) {
                    case SearchResultState:
                      state as SearchResultState;
                      if (state.countryModel.isEmpty) {
                        return Text(S.current.noData);
                      }

                      return SearchResultWidget(
                        countryModel: state.countryModel,
                      );

                    default:
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          Assets.svgImages.search.path,
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
