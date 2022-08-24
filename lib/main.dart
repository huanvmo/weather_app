import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/app_colors.dart';
import 'generated/l10n.dart';
import 'utils/utils_layer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupInjection();
  final a = await FirebaseAppCheck.instance.getToken();
  await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: a);

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  initLang() {
    switch (SessionUtils.getLanguages) {
      case 'Tiếng Việt':
        S.load(
          const Locale('vi', 'VN'),
        );
        break;

      case "English":
        S.load(
          const Locale('en', 'EN'),
        );
        break;

      case null:
        S.load(
          const Locale('vi', 'VN'),
        );
        SessionUtils.saveLanguages('Tiếng Việt');
    }
  }

  initMetric() {
    if (SessionUtils.getMetric == null) {
      SessionUtils.saveMetric(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    initLang();
    initMetric();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) => MaterialApp(
        color: AppColors.primaryColor,
        title: 'Weather app',
        initialRoute: RouteDefine.splashScreen.name,
        onGenerateRoute: AppRouting.generateRoute,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}
