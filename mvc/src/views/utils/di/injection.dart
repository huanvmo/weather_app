part of utils_layer;

GetIt getIt = GetIt.instance;

Future setupInjection() async {
  await _registerAppComponents();
  await _registerNetworkComponents();
  _registerRepository();
  _registerFirebase();
}

Future _registerAppComponents() async {
  final SharedPreferencesManager? sharePreferences =
      await SharedPreferencesManager.getInstance();
  getIt.registerSingleton<SharedPreferencesManager>(sharePreferences!);
}

Future<void> _registerNetworkComponents() async {
  final dio = Dio(
    BaseOptions(
      connectTimeout: 10000,
    ),
  );

  dio.interceptors.addAll(
    [
      ///TODO add logger if need
      // PrettyDioLogger(
      //   requestHeader: true,
      //   requestBody: true,
      //   responseHeader: true,
      // ),
    ],
  );
  getIt.registerSingleton(dio);

  getIt.registerLazySingleton(
    (() => GetWeatherApi(dio)),
  );

  getIt.registerLazySingleton(
    (() => GetDetailApi(dio)),
  );
  getIt.registerLazySingleton(
    (() => GetCountryNameApi(dio)),
  );
}

void _registerRepository() {
  getIt.registerLazySingleton<WeatherRepo>(
    () => WeatherRepoImpl(
      getDetailApi: getIt<GetDetailApi>(),
      getWeatherApi: getIt<GetWeatherApi>(),
    ),
  );

  getIt.registerLazySingleton<CountryRepo>(
    () => CountryRepoImpl(api: getIt<GetCountryNameApi>()),
  );
}

void _registerFirebase() {
  ///Firebase db
  getIt.registerLazySingleton(
    () => FavoritesDBServices(),
  );

  getIt.registerLazySingleton(
    () => NewsDBServices(),
  );

  getIt.registerLazySingleton(
    () => UsersDBServices(),
  );

  ///Login - signup
  getIt.registerLazySingleton(
    () => LoginSignupService(
      services: getIt<UsersDBServices>(),
    ),
  );
}
