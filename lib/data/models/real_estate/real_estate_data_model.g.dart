// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'real_estate_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealEstateDataModel _$RealEstateDataModelFromJson(Map<String, dynamic> json) =>
    RealEstateDataModel(
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
    );

Map<String, dynamic> _$RealEstateDataModelToJson(
        RealEstateDataModel instance) =>
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
    };

const _$StatusEnumEnumMap = {
  StatusEnum.New: 0,
  StatusEnum.Approved: 1,
  StatusEnum.GD: 2,
  StatusEnum.Normal: 3,
  StatusEnum.SaledByAdmin: 4,
  StatusEnum.SaledByUser: 5,
};

AddressDataModel _$AddressDataModelFromJson(Map<String, dynamic> json) =>
    AddressDataModel(
      id: json['Id'] as int?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$AddressDataModelToJson(AddressDataModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
    };

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    UserDataModel(
      id: json['Id'] as int?,
      name: json['Name'] as String?,
      photo: json['Photo'] as String?,
      phone: json['Phone'] as String?,
    );

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Photo': instance.photo,
      'Phone': instance.phone,
    };

KindModel _$KindModelFromJson(Map<String, dynamic> json) => KindModel(
      id: json['Id'] as int?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$KindModelToJson(KindModel instance) => <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
    };

RealEstateImageData _$RealEstateImageDataFromJson(Map<String, dynamic> json) =>
    RealEstateImageData(
      id: json['Id'] as int?,
      url: json['ImageUrl'] as String?,
      key: json['Key'] as String?,
    );

Map<String, dynamic> _$RealEstateImageDataToJson(
        RealEstateImageData instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'ImageUrl': instance.url,
      'Key': instance.key,
    };
