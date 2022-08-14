part of utils_layer;

enum RouteDefine {
  homeScreen,
  loginScreen,
  signupScreen,
  splashScreen,
  loginSignupIndexScreen,
  forgotPasswordScreen,
  mainScreen,
  searchScreen,
  detailScreen,
  favoritesListScreen,
  settingsScreen,
  newsScreen,
  newsDetailScreen,
  accountManagementScreen,
  accountChangeScreen,
  accountScreen,
  newsUpdateScreen,
  accountListScreen,
  accountUpdateScreen,
  newsListScreen,
  newsAddScreen,
  newsManagementScreen,
}

class AppRouting {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      RouteDefine.homeScreen.name: (_) => HomeScreenRoute.route,
      RouteDefine.accountUpdateScreen.name: (_) =>
          AccountUpdateScreenRoute.route(
            usersModel: settings.arguments as UsersModel,
          ),
      RouteDefine.accountListScreen.name: (_) => AccountListScreenRoute.route,
      RouteDefine.accountScreen.name: (_) => AccountScreenRoute.route,
      RouteDefine.loginScreen.name: (_) => LoginScreenRoute.route,
      RouteDefine.signupScreen.name: (_) => SignupScreenRoute.route,
      RouteDefine.splashScreen.name: (_) => SplashScreenRoute.route,
      RouteDefine.mainScreen.name: (_) => MainScreenRoute.route,
      RouteDefine.favoritesListScreen.name: (_) =>
          FavoritesListScreenRoute.route,
      RouteDefine.searchScreen.name: (_) => SearchScreenRoute.route,
      RouteDefine.detailScreen.name: (_) => DetailScreenRoute.route(
          argument: settings.arguments as DetailArgument),
      RouteDefine.forgotPasswordScreen.name: (_) =>
          ForgotPasswordScreenRoute.route,
      RouteDefine.loginSignupIndexScreen.name: (_) =>
          LoginSignupIndexScreenRoute.route,
      RouteDefine.settingsScreen.name: (_) => SettingsScreenRoute.route,
      RouteDefine.newsDetailScreen.name: (_) => NewsDetailScreenRoute.route(
            newsModel: settings.arguments as NewsModel,
          ),
      RouteDefine.newsUpdateScreen.name: (_) => NewsUpdateScreenRoute.route(
            newsModel: settings.arguments as NewsModel,
          ),
      RouteDefine.newsManagementScreen.name: (_) =>
          NewsManagementScreenRoute.route,
      RouteDefine.newsAddScreen.name: (_) => NewsAddScreenRoute.route,
      RouteDefine.newsListScreen.name: (_) => NewsListScreenRoute.route,
    };

    final routeBuilder = routes[settings.name];

    return MaterialPageRoute(
      builder: (context) => routeBuilder!(context),
      settings: RouteSettings(name: settings.name),
    );
  }
}

extension RouteExt on Object {
  String get name => toString().substring(toString().indexOf('.') + 1);
}
