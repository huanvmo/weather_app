import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorites_model.g.dart';

@JsonSerializable()
class FavoritesModel extends Equatable {
  final String? countryName;
  final String? cityName;

  const FavoritesModel({
    this.countryName,
    this.cityName,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) =>
      _$FavoritesModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritesModelToJson(this);

  @override
  List<Object?> get props => [
        countryName,
        cityName,
      ];
}
