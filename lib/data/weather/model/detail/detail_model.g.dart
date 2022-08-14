// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailModel _$DetailModelFromJson(Map<String, dynamic> json) => DetailModel(
      (json['days'] as List<dynamic>)
          .map((e) => Days.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['resolvedAddress'] as String,
    );

Map<String, dynamic> _$DetailModelToJson(DetailModel instance) =>
    <String, dynamic>{
      'resolvedAddress': instance.resolvedAddress,
      'days': instance.days.map((e) => e.toJson()).toList(),
    };

Days _$DaysFromJson(Map<String, dynamic> json) => Days(
      dateTime: json['datetime'] as String?,
      datetimeEpoch: json['datetimeEpoch'] as int?,
      humidity: (json['humidity'] as num?)?.toDouble(),
      pressure: (json['pressure'] as num?)?.toDouble(),
      temp: (json['temp'] as num?)?.toDouble(),
      tempMax: (json['tempmax'] as num?)?.toDouble(),
      tempMin: (json['tempmin'] as num?)?.toDouble(),
      conditions: json['conditions'] as String?,
      windSpeed: (json['windspeed'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DaysToJson(Days instance) => <String, dynamic>{
      'datetime': instance.dateTime,
      'datetimeEpoch': instance.datetimeEpoch,
      'temp': instance.temp,
      'tempmax': instance.tempMax,
      'tempmin': instance.tempMin,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'conditions': instance.conditions,
      'windspeed': instance.windSpeed,
    };
