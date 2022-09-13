import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DetailModel extends Equatable {
  final String? resolvedAddress;
  final List<Days>? days;

  factory DetailModel.fromJson(Map<String, dynamic> json) =>
      _$DetailModelFromJson(json);

  const DetailModel({
    this.days,
    this.resolvedAddress,
  });

  Map<String, dynamic> toJson() => _$DetailModelToJson(this);

  @override
  List<Object?> get props => [
        days,
        resolvedAddress,
      ];
}

@JsonSerializable(explicitToJson: true)
class Days extends Equatable {
  @JsonKey(name: "datetime")
  final String? dateTime;
  final int? datetimeEpoch;
  final double? temp;
  @JsonKey(name: "tempmax")
  final double? tempMax;
  @JsonKey(name: "tempmin")
  final double? tempMin;
  final double? humidity;
  final double? pressure;
  final String? conditions;
  @JsonKey(name: "windspeed")
  final double? windSpeed;

  const Days({
    this.dateTime,
    this.datetimeEpoch,
    this.humidity,
    this.pressure,
    this.temp,
    this.tempMax,
    this.tempMin,
    this.conditions,
    this.windSpeed,
  });

  factory Days.fromJson(Map<String, dynamic> json) => _$DaysFromJson(json);

  Map<String, dynamic> toJson() => _$DaysToJson(this);

  @override
  List<Object?> get props => [
        dateTime,
        datetimeEpoch,
        humidity,
        pressure,
        temp,
        tempMax,
        tempMin,
        conditions,
        windSpeed,
      ];
}
