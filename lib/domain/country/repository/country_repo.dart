part of country_name_domain;

abstract class CountryRepo {
  Future<List<CountryModel>> getCountryName({required String countryName});
}
