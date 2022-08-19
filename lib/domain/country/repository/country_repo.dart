part of country_name_domain;

// ignore: one_member_abstracts
abstract class CountryRepo {
  Future<List<CountryModel>> getCountryName({required String countryName});
}
