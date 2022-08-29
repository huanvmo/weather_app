import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryModel {
  final CountryName? name;
  final List<String>? capital;

  const CountryModel({
    this.name,
    this.capital,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}

@JsonSerializable()
class CountryName {
  final String? common;

  const CountryName({
    this.common,
  });

  factory CountryName.fromJson(Map<String, dynamic> json) =>
      _$CountryNameFromJson(json);

  Map<String, dynamic> toJson() => _$CountryNameToJson(this);
}
