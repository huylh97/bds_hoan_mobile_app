// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcription_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubcriptionInfo _$SubcriptionInfoFromJson(Map<String, dynamic> json) =>
    SubcriptionInfo(
      id: json['Id'] as int?,
      name: json['Name'] as String?,
      type: json['Type'] as int?,
      price: json['Price'] as int?,
      maxMembers: json['MaxMembers'] as int?,
      createdAt: json['CreatedAt'] == null
          ? null
          : DateTime.parse(json['CreatedAt'] as String),
      updatedAt: json['UpdatedAt'] == null
          ? null
          : DateTime.parse(json['UpdatedAt'] as String),
    );

Map<String, dynamic> _$SubcriptionInfoToJson(SubcriptionInfo instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Type': instance.type,
      'Price': instance.price,
      'MaxMembers': instance.maxMembers,
      'CreatedAt': instance.createdAt?.toIso8601String(),
      'UpdatedAt': instance.updatedAt?.toIso8601String(),
    };
