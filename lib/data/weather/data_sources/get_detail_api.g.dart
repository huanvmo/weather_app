// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_detail_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _GetDetailApi implements GetDetailApi {
  _GetDetailApi(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://weather.visualcrossing.com/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<DetailModel> getDetail(countryName, unit) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        DetailModel>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            'VisualCrossingWebServices/rest/services/timeline/${countryName}?unitGroup=${unit}&key=SWTWXGHBQVYPUCNKXSJ9V435P&contentType=json',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DetailModel.fromJson(_result.data!);
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
