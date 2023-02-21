// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcription_register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubcriptionRegisterModel _$SubcriptionRegisterModelFromJson(
        Map<String, dynamic> json) =>
    SubcriptionRegisterModel(
      subscription: json['subscription'] as int?,
      phone: json['phone'] as String?,
      quantity: json['quantity'] as int?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) =>
              SubcriptionImageRegister.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubcriptionRegisterModelToJson(
        SubcriptionRegisterModel instance) =>
    <String, dynamic>{
      'subscription': instance.subscription,
      'phone': instance.phone,
      'quantity': instance.quantity,
      'images': instance.images?.map((e) => e.toJson()).toList(),
    };

SubcriptionImageRegister _$SubcriptionImageRegisterFromJson(
        Map<String, dynamic> json) =>
    SubcriptionImageRegister(
      url: json['url'] as String?,
      key: json['key'] as String?,
    );

Map<String, dynamic> _$SubcriptionImageRegisterToJson(
        SubcriptionImageRegister instance) =>
    <String, dynamic>{
      'url': instance.url,
      'key': instance.key,
    };

SubcriptionImageDel _$SubcriptionImageDelFromJson(Map<String, dynamic> json) =>
    SubcriptionImageDel(
      images: (json['images'] as List<dynamic>?)
          ?.map((e) =>
              SubcriptionImageRegister.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubcriptionImageDelToJson(
        SubcriptionImageDel instance) =>
    <String, dynamic>{
      'images': instance.images,
    };
