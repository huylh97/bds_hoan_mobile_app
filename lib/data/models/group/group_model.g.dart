// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) => GroupModel(
      id: json['Id'] as int?,
      name: json['Name'] as String?,
      ownerId: json['Owner'] as int?,
      address: json['Address'] as String?,
      contact: json['Contact'] as String?,
      taxCode: json['TaxCode'] as String?,
      enterpriseEmail: json['EnterpriseEmail'] as String?,
      enterprisePhone: json['EnterprisePhone'] as String?,
      isEnterprise: json['IsEnterprise'] as bool?,
      owners: json['Owners'] == null
          ? null
          : Owners.fromJson(json['Owners'] as Map<String, dynamic>),
      createdAt: json['CreatedAt'] == null
          ? null
          : DateTime.parse(json['CreatedAt'] as String),
      updatedAt: json['UpdatedAt'] == null
          ? null
          : DateTime.parse(json['UpdatedAt'] as String),
      members: (json['Members'] as List<dynamic>?)
          ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupModelToJson(GroupModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Owner': instance.ownerId,
      'Address': instance.address,
      'Contact': instance.contact,
      'TaxCode': instance.taxCode,
      'EnterprisePhone': instance.enterprisePhone,
      'EnterpriseEmail': instance.enterpriseEmail,
      'IsEnterprise': instance.isEnterprise,
      'Owners': instance.owners,
      'CreatedAt': instance.createdAt?.toIso8601String(),
      'UpdatedAt': instance.updatedAt?.toIso8601String(),
      'Members': instance.members,
    };

Owners _$OwnersFromJson(Map<String, dynamic> json) => Owners(
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$OwnersToJson(Owners instance) => <String, dynamic>{
      'Name': instance.name,
    };

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      name: json['Name'] as String?,
      id: json['Id'] as int?,
      phoneNumber: json['PhoneNumber'] as String?,
      totalRE: json['TotalRE'] as int?,
      photo: json['Photo'] as String?,
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'PhoneNumber': instance.phoneNumber,
      'TotalRE': instance.totalRE,
      'Photo': instance.photo,
    };
