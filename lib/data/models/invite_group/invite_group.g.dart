// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InviteGroup _$InviteGroupFromJson(Map<String, dynamic> json) => InviteGroup(
      id: json['Id'] as int?,
      name: json['Name'] as String?,
      address: json['Address'] as String?,
      contact: json['Contact'] as String?,
      owners: json['Owners'] == null
          ? null
          : GroupOwner.fromJson(json['Owners'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InviteGroupToJson(InviteGroup instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Address': instance.address,
      'Contact': instance.contact,
      'Owners': instance.owners?.toJson(),
    };

GroupOwner _$GroupOwnerFromJson(Map<String, dynamic> json) => GroupOwner(
      id: json['Id'] as int?,
      name: json['Name'] as String?,
      phoneNumber: json['PhoneNumber'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumEnumMap, json['Gender']),
      birthDay: json['Birthday'] as String?,
      photo: json['Photo'] as String? ??
          'https://api.imbachat.com/plugins/imbasynergy/imbachat/assets/images/default-avatar.png',
    );

Map<String, dynamic> _$GroupOwnerToJson(GroupOwner instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'PhoneNumber': instance.phoneNumber,
      'Gender': _$GenderEnumEnumMap[instance.gender],
      'Birthday': instance.birthDay,
      'Photo': instance.photo,
    };

const _$GenderEnumEnumMap = {
  GenderEnum.male: 0,
  GenderEnum.female: 1,
};
