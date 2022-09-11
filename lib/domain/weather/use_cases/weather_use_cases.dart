part of weather_domain;

class WeatherUseCases {
  final WeatherRepo _repo;

  WeatherUseCases(this._repo);

  Future<WeatherModel> getWeather(
      {required double lat, required double lon, required String lang}) {
    return _repo.getWeather(lat: lat, lon: lon, lang: lang);
  }

  Future<DetailModel> getDetail({
    required String countryName,
    required String unit,
  }) async {

    return await _repo.getDetail(countryName: countryName, unit: unit);
  }
}
