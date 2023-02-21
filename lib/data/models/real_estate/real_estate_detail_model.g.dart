// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'real_estate_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealEstateDetailModel _$RealEstateDetailModelFromJson(
        Map<String, dynamic> json) =>
    RealEstateDetailModel(
      id: json['Id'] as int?,
      title: json['Title'] as String?,
      address: json['Address'] as String?,
      province: json['Province'] == null
          ? null
          : AddressDataModel.fromJson(json['Province'] as Map<String, dynamic>),
      district: json['District'] == null
          ? null
          : AddressDataModel.fromJson(json['District'] as Map<String, dynamic>),
      wards: json['Wards'] == null
          ? null
          : AddressDataModel.fromJson(json['Wards'] as Map<String, dynamic>),
      lat: (json['Lat'] as num?)?.toDouble(),
      long: (json['Long'] as num?)?.toDouble(),
      vn2000X: (json['VN2000_X'] as num?)?.toDouble(),
      vn2000Y: (json['VN2000_Y'] as num?)?.toDouble(),
      description: json['Description'] as String?,
      area: (json['Area'] as num?)?.toDouble(),
      squareMetrePrice: json['SquareMetrePrice'] as int?,
      widthMetrePrice: json['WidthMetrePrice'] as int?,
      totalPrice: json['TotalPrice'] as int?,
      priceType: json['PriceType'] as int?,
      commission: json['Commission'] as int?,
      note: json['Note'] as String?,
      status: $enumDecodeNullable(_$StatusEnumEnumMap, json['Status']),
      disable: json['Disable'] as bool?,
      user: json['User'] == null
          ? null
          : UserDataModel.fromJson(json['User'] as Map<String, dynamic>),
      kind: json['Kind'] == null
          ? null
          : KindModel.fromJson(json['Kind'] as Map<String, dynamic>),
      consignors: json['Consignors'] as int?,
      consignorsName: json['ConsignorsName'] as String?,
      consignorsPhone: json['ConsignorsPhone'] as String?,
      consignorsExpiry: json['ConsignorsExpiry'] as String?,
      images: (json['Images'] as List<dynamic>?)
          ?.map((e) => RealEstateImageData.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['CreatedAt'] == null
          ? null
          : DateTime.parse(json['CreatedAt'] as String),
      updatedAt: json['UpdatedAt'] == null
          ? null
          : DateTime.parse(json['UpdatedAt'] as String),
      historyList:
          (json['History'] as List<dynamic>?)?.map((e) => e as String).toList(),
      salePrice: json['SalePrice'] as int?,
    );

Map<String, dynamic> _$RealEstateDetailModelToJson(
        RealEstateDetailModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Title': instance.title,
      'Address': instance.address,
      'Province': instance.province?.toJson(),
      'District': instance.district?.toJson(),
      'Wards': instance.wards?.toJson(),
      'Lat': instance.lat,
      'Long': instance.long,
      'VN2000_X': instance.vn2000X,
      'VN2000_Y': instance.vn2000Y,
      'Description': instance.description,
      'Area': instance.area,
      'SquareMetrePrice': instance.squareMetrePrice,
      'WidthMetrePrice': instance.widthMetrePrice,
      'TotalPrice': instance.totalPrice,
      'PriceType': instance.priceType,
      'Commission': instance.commission,
      'Note': instance.note,
      'Status': _$StatusEnumEnumMap[instance.status],
      'Disable': instance.disable,
      'User': instance.user?.toJson(),
      'Kind': instance.kind?.toJson(),
      'Consignors': instance.consignors,
      'ConsignorsName': instance.consignorsName,
      'ConsignorsPhone': instance.consignorsPhone,
      'ConsignorsExpiry': instance.consignorsExpiry,
      'Images': instance.images?.map((e) => e.toJson()).toList(),
      'CreatedAt': instance.createdAt?.toIso8601String(),
      'UpdatedAt': instance.updatedAt?.toIso8601String(),
      'History': instance.historyList,
      'SalePrice': instance.salePrice,
    };

const _$StatusEnumEnumMap = {
  StatusEnum.New: 0,
  StatusEnum.Approved: 1,
  StatusEnum.GD: 2,
  StatusEnum.Normal: 3,
  StatusEnum.SaledByAdmin: 4,
  StatusEnum.SaledByUser: 5,
};
