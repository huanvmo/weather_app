import 'package:flutter/material.dart';
import 'package:weather_app/config/app_colors.dart';
import 'package:weather_app/config/app_text_style.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/common/method/toast.dart';
import 'package:weather_app/presentation/common/widget/back_app_bar_icon_button.dart';
import 'package:weather_app/presentation/common/widget/common_list_tile.dart';
import 'package:weather_app/presentation/common/widget/common_switch_list_tile.dart';

import '../utils/utils_layer.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool metric;

  List languages = ['English', 'Tiếng Việt'];

  String lang = 'English';

  @override
  void initState() {
    super.initState();
    lang = SessionUtils.getLanguages!;
    metric = SessionUtils.getMetric!;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: BackAppBarIconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              RouteDefine.mainScreen.name,
            );
          },
        ),
        title: Text(
          S.current.setting,
          style: AppTextStyle.fontSize20.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CommonSwitchListTile(
              title: S.current.chooseUnits,
              valueTextOn: S.current.imperial,
              valueTextOff: S.current.metric,
              icon: const Icon(
                Icons.ac_unit,
              ),
              boolValue: metric,
              onChanged: (value) async {
                setState(() {
                  metric = !metric;
                });
                SessionUtils.saveMetric(
                  metric,
                );
              },
            ),
            CommonDropdownButton(
                title: Text(
                  S.current.chooseYourLanguages,
                  style: AppTextStyle.fontSize14.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                string: lang,
                listString: languages,
                leadingIcon: const Icon(Icons.language),
                onChanged: (value) async {
                  switch (value) {
                    case "Tiếng Việt":
                      setState(() {
                        lang = value.toString();
                      });
                      SessionUtils.saveLanguages(
                        lang,
                      );
                      await S.load(
                        const Locale('vi', 'VN'),
                      );
                      toast(
                        msg: S.current.choosed(S.current.tiengViet),
                      );
                      lang = value.toString();

                      break;
                    default:
                      setState(() {
                        lang = value.toString();
                      });
                      SessionUtils.saveLanguages(
                        lang,
                      );
                      await S.load(
                        const Locale('en', 'EN'),
                      );

                      toast(
                        msg: S.current.choosed(S.current.english),
                      );

                      lang = value.toString();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
