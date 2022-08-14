part of weather_domain;

abstract class WeatherRepo {
  Future<WeatherModel> getWeather({
    required double lat,
    required double lon,
    required String lang,
  });

  Future<DetailModel> getDetail({
    required String countryName,
    required String unit,
  });
}
