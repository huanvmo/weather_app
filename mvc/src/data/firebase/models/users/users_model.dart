import 'package:json_annotation/json_annotation.dart';

part 'users_model.g.dart';

@JsonSerializable(includeIfNull: false)
class UsersModel {
  final String? name;
  final String? uid;
  final String? email;
  final bool? isAdmin;
  final bool? isActive;
  final String? avatarUrl;

  UsersModel({
    this.name,
    this.uid,
    this.email,
    this.isAdmin,
    this.isActive,
    this.avatarUrl,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) =>
      _$UsersModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersModelToJson(this);
}
