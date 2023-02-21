// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'real_estate_register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealEstateRegisterModel _$RealEstateRegisterModelFromJson(
        Map<String, dynamic> json) =>
    RealEstateRegisterModel(
      title: json['title'] as String?,
      address: json['address'] as String?,
      province: json['province'] as int?,
      district: json['district'] as int?,
      wards: json['wards'] as int?,
      vn2000: json['vn2000'] == null
          ? null
          : VN2000.fromJson(json['vn2000'] as Map<String, dynamic>),
      lat: (json['lat'] as num?)?.toDouble(),
      long: (json['long'] as num?)?.toDouble(),
      description: json['description'] as String?,
      area: (json['area'] as num?)?.toDouble(),
      squareMetrePrice: json['squareMetrePrice'] as int?,
      widthMetrePrice: json['widthMetrePrice'] as int?,
      totalPrice: json['totalPrice'] as int?,
      commission: json['commission'] as int?,
      note: json['note'] as String?,
      kind: json['kind'] as int?,
      consignors: json['consignors'] as int?,
      consignorsName: json['consignorsName'] as String?,
      consignorsPhone: json['consignorsPhone'] as String?,
      consignorsExpiry: json['consignorsExpiry'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) =>
              RealEstateImageRegister.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RealEstateRegisterModelToJson(
        RealEstateRegisterModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'address': instance.address,
      'province': instance.province,
      'district': instance.district,
      'wards': instance.wards,
      'vn2000': instance.vn2000?.toJson(),
      'lat': instance.lat,
      'long': instance.long,
      'description': instance.description,
      'area': instance.area,
      'squareMetrePrice': instance.squareMetrePrice,
      'widthMetrePrice': instance.widthMetrePrice,
      'totalPrice': instance.totalPrice,
      'commission': instance.commission,
      'note': instance.note,
      'kind': instance.kind,
      'consignors': instance.consignors,
      'consignorsName': instance.consignorsName,
      'consignorsPhone': instance.consignorsPhone,
      'consignorsExpiry': instance.consignorsExpiry,
      'images': instance.images?.map((e) => e.toJson()).toList(),
    };

VN2000 _$VN2000FromJson(Map<String, dynamic> json) => VN2000(
      x: (json['x'] as num?)?.toDouble(),
      y: (json['y'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$VN2000ToJson(VN2000 instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };

RealEstateImageRegister _$RealEstateImageRegisterFromJson(
        Map<String, dynamic> json) =>
    RealEstateImageRegister(
      url: json['url'] as String?,
      key: json['key'] as String?,
    );

Map<String, dynamic> _$RealEstateImageRegisterToJson(
        RealEstateImageRegister instance) =>
    <String, dynamic>{
      'url': instance.url,
      'key': instance.key,
    };

RealEstateImageDel _$RealEstateImageDelFromJson(Map<String, dynamic> json) =>
    RealEstateImageDel(
      images: (json['images'] as List<dynamic>?)
          ?.map((e) =>
              RealEstateImageRegister.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RealEstateImageDelToJson(RealEstateImageDel instance) =>
    <String, dynamic>{
      'images': instance.images,
    };
