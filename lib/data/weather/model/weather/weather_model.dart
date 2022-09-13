import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel extends Equatable {
  final String? name;
  final List<Weather>? weather;
  final Main? main;
  final Wind? wind;
  final Sys? sys;

  const WeatherModel({this.name, this.weather, this.main, this.wind, this.sys});

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        weather,
        main,
        wind,
        sys,
      ];
}

@JsonSerializable()
class Weather extends Equatable {
  final String main;
  final String description;
  final String icon;

  const Weather(this.main, this.description, this.icon);

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  List<Object?> get props => [
        main,
        description,
        icon,
      ];
}

@JsonSerializable()
class Main extends Equatable {
  final double temp;

  @JsonKey(name: 'temp_min')
  final double tempMin;

  @JsonKey(name: 'temp_max')
  final double tempMax;

  final double pressure;
  final double humidity;

  const Main(
      {required this.temp,
      required this.tempMax,
      required this.tempMin,
      required this.pressure,
      required this.humidity});

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);

  @override
  List<Object?> get props => [temp, tempMax, tempMin, pressure, humidity];
}

@JsonSerializable()
class Wind extends Equatable {
  final double speed;

  const Wind(this.speed);

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);

  @override
  List<Object?> get props => [speed];
}

@JsonSerializable()
class Sys extends Equatable {
  final String country;

  const Sys(this.country);

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);

  @override
  List<Object?> get props => [country];
}
