part of country_data;

class CountryRepoImpl implements CountryRepo {
  final GetCountryNameApi api;

  const CountryRepoImpl({required this.api});

  @override
  Future<List<CountryModel>> getCountryName({
    required String countryName,
  }) async {
    try {
      return await api.getCountryName(countryName);
    } catch (e) {
      throw Exception(e);
    }
  }
}
