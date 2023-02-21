// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_registered_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionRegisteredData _$SubscriptionRegisteredDataFromJson(
        Map<String, dynamic> json) =>
    SubscriptionRegisteredData(
      id: json['Id'] as int?,
      fKUser: json['FK_User'] as int?,
      fKSubDetails: json['FK_SubDetails'] as int?,
      status: json['Status'] as int?,
      phone: json['Phone'] as String?,
      quantity: json['Quantity'] as int?,
      createdAt: json['CreatedAt'] == null
          ? null
          : DateTime.parse(json['CreatedAt'] as String),
      updatedAt: json['UpdatedAt'] == null
          ? null
          : DateTime.parse(json['UpdatedAt'] as String),
      subscriptionDetails: json['SubscriptionDetails'] == null
          ? null
          : SubscriptionDetails.fromJson(
              json['SubscriptionDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubscriptionRegisteredDataToJson(
        SubscriptionRegisteredData instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'FK_User': instance.fKUser,
      'FK_SubDetails': instance.fKSubDetails,
      'Status': instance.status,
      'Phone': instance.phone,
      'Quantity': instance.quantity,
      'CreatedAt': instance.createdAt?.toIso8601String(),
      'UpdatedAt': instance.updatedAt?.toIso8601String(),
      'SubscriptionDetails': instance.subscriptionDetails?.toJson(),
    };
