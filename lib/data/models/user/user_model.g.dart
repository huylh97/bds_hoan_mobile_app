// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['Id'] as int?,
      name: json['Name'] as String?,
      phoneNumber: json['PhoneNumber'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumEnumMap, json['Gender']),
      birthDay: json['Birthday'] as String?,
      role: $enumDecodeNullable(_$UserRoleEnumMap, json['Role']),
      status: json['Status'] as int?,
      createdBy: json['CreatedBy'] as int?,
      updateBy: json['UpdatedBy'] as int?,
      photo: json['Photo'] as String? ??
          'https://api.imbachat.com/plugins/imbasynergy/imbachat/assets/images/default-avatar.png',
      createdAt: json['CreatedAt'] == null
          ? null
          : DateTime.parse(json['CreatedAt'] as String),
      totalRE: json['TotalRE'] as int?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'PhoneNumber': instance.phoneNumber,
      'Gender': _$GenderEnumEnumMap[instance.gender],
      'Birthday': instance.birthDay,
      'Role': _$UserRoleEnumMap[instance.role],
      'Status': instance.status,
      'CreatedBy': instance.createdBy,
      'UpdatedBy': instance.updateBy,
      'Photo': instance.photo,
      'CreatedAt': instance.createdAt?.toIso8601String(),
      'TotalRE': instance.totalRE,
    };

const _$GenderEnumEnumMap = {
  GenderEnum.male: 0,
  GenderEnum.female: 1,
};

const _$UserRoleEnumMap = {
  UserRole.user: 1,
  UserRole.admin: 2,
  UserRole.superAdmin: 0,
};
