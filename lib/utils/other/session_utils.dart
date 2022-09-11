part of utils_layer;

class SessionUtils {
  static final SharedPreferencesManager _sharedPref =
      getIt<SharedPreferencesManager>();

  static void saveLanguages(String languages) => _sharedPref.setString(
        SharedPreferenceKey.languages,
        value: languages,
      );

  static String? get getLanguages => _sharedPref.getString(
        SharedPreferenceKey.languages,
      );

  static void saveMetric(bool metric) => _sharedPref.setBool(
        SharedPreferenceKey.metric,
        value: metric,
      );

  static bool get getMetric => _sharedPref.getBool(
        SharedPreferenceKey.metric,
      ) ?? false;

  static Future<void> get removePrefs async {
    await Future.wait(
      <Future<void>>[
        _sharedPref.remove(SharedPreferenceKey.languages),
        _sharedPref.remove(SharedPreferenceKey.metric),
      ],
    );
  }
}
