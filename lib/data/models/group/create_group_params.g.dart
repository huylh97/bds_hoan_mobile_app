// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_group_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGroupParams _$CreateGroupParamsFromJson(Map<String, dynamic> json) =>
    CreateGroupParams(
      name: json['name'] as String?,
      address: json['address'] as String?,
      contact: json['contact'] as String?,
      isEnterprise: json['isEnterprise'] as bool?,
      taxCode: json['taxCode'] as String?,
      enterprisePhone: json['enterprisePhone'] as String?,
      enterpriseMail: json['enterpriseMail'] as String?,
    );

Map<String, dynamic> _$CreateGroupParamsToJson(CreateGroupParams instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'contact': instance.contact,
      'isEnterprise': instance.isEnterprise,
      'taxCode': instance.taxCode,
      'enterprisePhone': instance.enterprisePhone,
      'enterpriseMail': instance.enterpriseMail,
    };
