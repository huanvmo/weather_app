// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_weather_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _GetWeatherApi implements GetWeatherApi {
  _GetWeatherApi(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://api.openweathermap.org/data/2.5/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<WeatherModel> getWeather(lat, lon, lang) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        WeatherModel>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            'weather?lat=${lat}&lon=${lon}&appid=4a80de72b34df28b6fa20967cf626513&lang=${lang}&units=metric',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WeatherModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
