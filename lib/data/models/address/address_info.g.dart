// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressInfo _$AddressInfoFromJson(Map<String, dynamic> json) => AddressInfo(
      id: json['Id'] as int?,
      name: json['Name'] as String?,
      codeName: json['CodeName'] as String?,
      type: json['Type'] as String?,
    );

Map<String, dynamic> _$AddressInfoToJson(AddressInfo instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'CodeName': instance.codeName,
      'Type': instance.type,
    };
