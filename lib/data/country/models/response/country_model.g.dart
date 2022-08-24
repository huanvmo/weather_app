// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) => CountryModel(
      name: json['name'] == null
          ? null
          : CountryName.fromJson(json['name'] as Map<String, dynamic>),
      capital:
          (json['capital'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'name': instance.name?.toJson(),
      'capital': instance.capital,
    };

CountryName _$CountryNameFromJson(Map<String, dynamic> json) => CountryName(
      common: json['common'] as String?,
    );

Map<String, dynamic> _$CountryNameToJson(CountryName instance) =>
    <String, dynamic>{
      'common': instance.common,
    };
