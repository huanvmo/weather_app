part of weather_data;

class WeatherRepoImpl extends WeatherRepo {
  final GetDetailApi getDetailApi;
  final GetWeatherApi getWeatherApi;

  WeatherRepoImpl({
    required this.getWeatherApi,
    required this.getDetailApi,
  });

  @override
  Future<WeatherModel> getWeather({
    required double lat,
    required double lon,
    required String lang,
  }) async {
    try {
      return await getWeatherApi.getWeather(
        lat,
        lon,
        lang,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<DetailModel> getDetail({
    required String countryName,
    required String unit,
  }) async {
    try {
      return await getDetailApi.getDetail(
        countryName,
        unit,
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
