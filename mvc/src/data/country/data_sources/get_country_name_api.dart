import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../../../models/country/country_model.dart';

part 'get_country_name_api.g.dart';

@RestApi(baseUrl: "https://restcountries.com/v3.1/name/")
abstract class GetCountryNameApi {
  factory GetCountryNameApi(Dio dio) = _GetCountryNameApi;

  @GET('{countryName}')
  Future<List<CountryModel>> getCountryName(
    @Path('countryName') String countryName,
  );
}
