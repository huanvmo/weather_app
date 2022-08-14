part of country_name_domain;

class GetCountryNameUseCase {
  final CountryRepo repo;

  const GetCountryNameUseCase({required this.repo});

  Future<List<CountryModel>> call({required String countryName}) {
    return repo.getCountryName(countryName: countryName);
  }
}
