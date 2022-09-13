import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryModel extends Equatable {
  final CountryName? name;
  final List<String>? capital;

  const CountryModel({
    this.name,
    this.capital,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);

  @override
  List<Object?> get props => [name, capital];
}

@JsonSerializable()
class CountryName extends Equatable {
  final String? common;

  const CountryName({
    this.common,
  });

  factory CountryName.fromJson(Map<String, dynamic> json) =>
      _$CountryNameFromJson(json);

  Map<String, dynamic> toJson() => _$CountryNameToJson(this);

  @override
  List<Object?> get props => [common];
}
