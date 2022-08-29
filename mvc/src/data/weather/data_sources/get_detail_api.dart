import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../../../models/detail/detail_model.dart';

part 'get_detail_api.g.dart';

@RestApi(baseUrl: "https://weather.visualcrossing.com/")
abstract class GetDetailApi {
  factory GetDetailApi(Dio dio) = _GetDetailApi;

  @GET(
      'VisualCrossingWebServices/rest/services/timeline/{countryName}?unitGroup={unit}&key=SWTWXGHBQVYPUCNKXSJ9V435P&contentType=json')
  Future<DetailModel> getDetail(
    @Path('countryName') String countryName,
    @Path('unit') String unit,
  );
}
