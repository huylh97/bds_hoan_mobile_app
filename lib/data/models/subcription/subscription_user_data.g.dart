// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionUserData _$SubscriptionUserDataFromJson(
        Map<String, dynamic> json) =>
    SubscriptionUserData(
      id: json['Id'] as int?,
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
      user: json['User'] == null
          ? null
          : SubscriptionUser.fromJson(json['User'] as Map<String, dynamic>),
      images: json.containsKey('Images')
          ? (json['Images'] as List<dynamic>?)
              ?.map((e) =>
                  SubscriptionImageData.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      total: json.containsKey('Total') ? json['Total'] as int? : null,
      currentMembers: json['CurrentMembers'] as int?,
      maxMembers: json['MaxMembers'] as int?,
      subStart: json['SubStart'] as String?,
      subEnd: json['SubEnd'] as String?,
    );

Map<String, dynamic> _$SubscriptionUserDataToJson(
        SubscriptionUserData instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Status': instance.status,
      'Phone': instance.phone,
      'Quantity': instance.quantity,
      'CreatedAt': instance.createdAt?.toIso8601String(),
      'UpdatedAt': instance.updatedAt?.toIso8601String(),
      'SubscriptionDetails': instance.subscriptionDetails?.toJson(),
      'User': instance.user?.toJson(),
      'Images': instance.images?.map((e) => e.toJson()).toList(),
      'Total': instance.total,
      'CurrentMembers': instance.currentMembers,
      'MaxMembers': instance.maxMembers,
      'SubStart': instance.subStart,
      'SubEnd': instance.subEnd,
    };

SubscriptionDetails _$SubscriptionDetailsFromJson(Map<String, dynamic> json) =>
    SubscriptionDetails(
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

Map<String, dynamic> _$SubscriptionDetailsToJson(
        SubscriptionDetails instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Type': instance.type,
      'Price': instance.price,
      'MaxMembers': instance.maxMembers,
      'CreatedAt': instance.createdAt?.toIso8601String(),
      'UpdatedAt': instance.updatedAt?.toIso8601String(),
    };

SubscriptionUser _$SubscriptionUserFromJson(Map<String, dynamic> json) =>
    SubscriptionUser(
      id: json['Id'] as int?,
      name: json['Name'] as String?,
      phoneNumber: json['PhoneNumber'] as String?,
      gender: json['Gender'] as int?,
      birthday: json['Birthday'] as String?,
      photo: json['Photo'] as String?,
      role: json['Role'] as int?,
      status: json['Status'] as int?,
    );

Map<String, dynamic> _$SubscriptionUserToJson(SubscriptionUser instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'PhoneNumber': instance.phoneNumber,
      'Gender': instance.gender,
      'Birthday': instance.birthday,
      'Photo': instance.photo,
      'Role': instance.role,
      'Status': instance.status,
    };

SubscriptionImageData _$SubscriptionImageDataFromJson(
        Map<String, dynamic> json) =>
    SubscriptionImageData(
      id: json['Id'] as int?,
      url: json['ImageUrl'] as String?,
      key: json['Key'] as String?,
    );

Map<String, dynamic> _$SubscriptionImageDataToJson(
        SubscriptionImageData instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'ImageUrl': instance.url,
      'Key': instance.key,
    };
