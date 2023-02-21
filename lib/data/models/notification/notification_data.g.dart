// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) =>
    NotificationData(
      id: json['Id'] as int?,
      title: json['Title'] as String?,
      status: json['Status'] as int?,
      image: json['Image'] as String?,
      seen: json['Seen'] as bool?,
      fK_RealEstate: json['FK_RealEstate'] as int?,
      fK_Group: json['FK_Group'] as int?,
      createdAt: json['CreatedAt'] == null
          ? null
          : DateTime.parse(json['CreatedAt'] as String),
      updatedAt: json['UpdatedAt'] == null
          ? null
          : DateTime.parse(json['UpdatedAt'] as String),
      user: json['User'] == null
          ? null
          : NotiUserModel.fromJson(json['User'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Title': instance.title,
      'Status': instance.status,
      'Seen': instance.seen,
      'FK_RealEstate': instance.fK_RealEstate,
      'FK_Group': instance.fK_Group,
      'CreatedAt': instance.createdAt?.toIso8601String(),
      'UpdatedAt': instance.updatedAt?.toIso8601String(),
    };

NotiUserModel _$NotiUserModelFromJson(Map<String, dynamic> json) =>
    NotiUserModel(
      id: json['Id'] as int?,
      name: json['Name'] as String?,
      photo: json['Photo'] as String?,
    );

Map<String, dynamic> _$NotiUserModelToJson(NotiUserModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Photo': instance.photo,
    };
