// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersModel _$UsersModelFromJson(Map<String, dynamic> json) => UsersModel(
      name: json['name'] as String?,
      uid: json['uid'] as String?,
      email: json['email'] as String?,
      isAdmin: json['isAdmin'] as bool?,
      isActive: json['isActive'] as bool?,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$UsersModelToJson(UsersModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('uid', instance.uid);
  writeNotNull('email', instance.email);
  writeNotNull('isAdmin', instance.isAdmin);
  writeNotNull('isActive', instance.isActive);
  writeNotNull('avatarUrl', instance.avatarUrl);
  return val;
}
