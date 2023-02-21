// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'real_estate_status_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealEstateStatusUpdateModel _$RealEstateStatusUpdateModelFromJson(
        Map<String, dynamic> json) =>
    RealEstateStatusUpdateModel(
      status: json['status'] as int?,
      salePrice: json['salePrice'] as int?,
    );

Map<String, dynamic> _$RealEstateStatusUpdateModelToJson(
        RealEstateStatusUpdateModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'salePrice': instance.salePrice,
    };
