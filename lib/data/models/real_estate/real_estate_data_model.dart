import 'package:bds_hoan_mobile/data/enums/status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'real_estate_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RealEstateDataModel {
  @JsonKey(name: 'Id')
  final int? id;
  @JsonKey(name: 'Title')
  final String? title;

  @JsonKey(name: 'Address')
  final String? address;
  @JsonKey(name: 'Province')
  final AddressDataModel? province;
  @JsonKey(name: 'District')
  final AddressDataModel? district;
  @JsonKey(name: 'Wards')
  final AddressDataModel? wards;

  @JsonKey(name: 'Lat')
  final double? lat;
  @JsonKey(name: 'Long')
  final double? long;

  @JsonKey(name: 'VN2000_X')
  final double? vn2000X;
  @JsonKey(name: 'VN2000_Y')
  final double? vn2000Y;

  @JsonKey(name: 'Description')
  final String? description;

  @JsonKey(name: 'Area')
  final double? area;

  @JsonKey(name: 'SquareMetrePrice')
  final int? squareMetrePrice;

  @JsonKey(name: 'WidthMetrePrice')
  final int? widthMetrePrice;

  @JsonKey(name: 'TotalPrice')
  final int? totalPrice;

  @JsonKey(name: 'PriceType')
  final int? priceType;

  @JsonKey(name: 'Commission')
  final int? commission;

  @JsonKey(name: 'Note')
  final String? note;

  @JsonKey(name: 'Status')
  final StatusEnum? status;

  @JsonKey(name: 'Disable')
  final bool? disable;

  @JsonKey(name: 'User')
  final UserDataModel? user;

  @JsonKey(name: 'Kind')
  final KindModel? kind;

  @JsonKey(name: 'Consignors')
  final int? consignors;

  @JsonKey(name: 'ConsignorsName')
  final String? consignorsName;

  @JsonKey(name: 'ConsignorsPhone')
  final String? consignorsPhone;

  @JsonKey(name: 'ConsignorsExpiry')
  final String? consignorsExpiry;

  @JsonKey(name: 'Images')
  final List<RealEstateImageData>? images;

  @JsonKey(name: 'CreatedAt')
  final DateTime? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final DateTime? updatedAt;

  RealEstateDataModel(
      {this.id,
      this.title,
      this.address,
      this.province,
      this.district,
      this.wards,
      this.lat,
      this.long,
      this.vn2000X,
      this.vn2000Y,
      this.description,
      this.area,
      this.squareMetrePrice,
      this.widthMetrePrice,
      this.totalPrice,
      this.priceType,
      this.commission,
      this.note,
      this.status,
      this.disable,
      this.user,
      this.kind,
      this.consignors,
      this.consignorsName,
      this.consignorsPhone,
      this.consignorsExpiry,
      this.images,
      this.createdAt,
      this.updatedAt});

  factory RealEstateDataModel.fromJson(Map<String, dynamic> json) =>
      _$RealEstateDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$RealEstateDataModelToJson(this);
}

@JsonSerializable()
class AddressDataModel {
  @JsonKey(name: 'Id')
  final int? id;

  @JsonKey(name: 'Name')
  final String? name;

  AddressDataModel({
    this.id,
    this.name,
  });

  factory AddressDataModel.fromJson(Map<String, dynamic> json) =>
      _$AddressDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDataModelToJson(this);
}

@JsonSerializable()
class UserDataModel {
  @JsonKey(name: 'Id')
  final int? id;

  @JsonKey(name: 'Name')
  final String? name;

  @JsonKey(name: 'Photo')
  final String? photo;

  @JsonKey(name: 'Phone')
  final String? phone;

  UserDataModel({this.id, this.name, this.photo, this.phone});

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);
}

@JsonSerializable()
class KindModel {
  @JsonKey(name: 'Id')
  final int? id;

  @JsonKey(name: 'Name')
  final String? name;

  KindModel({
    this.id,
    this.name,
  });

  factory KindModel.fromJson(Map<String, dynamic> json) =>
      _$KindModelFromJson(json);

  Map<String, dynamic> toJson() => _$KindModelToJson(this);
}

@JsonSerializable()
class RealEstateImageData {
  @JsonKey(name: 'Id')
  final int? id;

  @JsonKey(name: 'ImageUrl')
  final String? url;

  @JsonKey(name: 'Key')
  final String? key;

  RealEstateImageData({
    this.id,
    this.url,
    this.key,
  });

  factory RealEstateImageData.fromJson(Map<String, dynamic> json) =>
      _$RealEstateImageDataFromJson(json);

  Map<String, dynamic> toJson() => _$RealEstateImageDataToJson(this);
}
