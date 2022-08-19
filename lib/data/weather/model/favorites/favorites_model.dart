import 'package:json_annotation/json_annotation.dart';

part 'favorites_model.g.dart';

@JsonSerializable()
class FavoritesModel {
  final String? countryName;
  final String? cityName;

  FavoritesModel({
     this.countryName,
     this.cityName,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) =>
      _$FavoritesModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritesModelToJson(this);
}
