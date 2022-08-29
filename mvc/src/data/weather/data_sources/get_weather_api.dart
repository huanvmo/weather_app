import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../../../models/weather/weather_model.dart';

part 'get_weather_api.g.dart';

@RestApi(baseUrl: "http://api.openweathermap.org/data/2.5/")
abstract class GetWeatherApi {
  factory GetWeatherApi(Dio dio) = _GetWeatherApi;

  @GET(
      'weather?lat={lat}&lon={lon}&appid=4a80de72b34df28b6fa20967cf626513&lang={lang}&units=metric')
  Future<WeatherModel> getWeather(
    @Path('lat') double lat,
    @Path('lon') double lon,
    @Path('lang') String lang,
  );
}
