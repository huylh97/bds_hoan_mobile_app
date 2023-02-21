import 'package:json_annotation/json_annotation.dart';

part 'real_estate_register_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RealEstateRegisterModel {
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'province')
  final int? province;
  @JsonKey(name: 'district')
  final int? district;
  @JsonKey(name: 'wards')
  final int? wards;

  @JsonKey(name: 'vn2000')
  final VN2000? vn2000;

  @JsonKey(name: 'lat')
  final double? lat;
  @JsonKey(name: 'long')
  final double? long;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'area')
  final double? area;

  @JsonKey(name: 'squareMetrePrice')
  final int? squareMetrePrice;

  @JsonKey(name: 'widthMetrePrice')
  final int? widthMetrePrice;

  @JsonKey(name: 'totalPrice')
  final int? totalPrice;

  @JsonKey(name: 'commission')
  final int? commission;

  @JsonKey(name: 'note')
  final String? note;

  @JsonKey(name: 'kind')
  final int? kind;

  @JsonKey(name: 'consignors')
  final int? consignors;

  @JsonKey(name: 'consignorsName')
  final String? consignorsName;

  @JsonKey(name: 'consignorsPhone')
  final String? consignorsPhone;

  @JsonKey(name: 'consignorsExpiry')
  final String? consignorsExpiry;

  @JsonKey(name: 'images')
  final List<RealEstateImageRegister>? images;

  RealEstateRegisterModel(
      {this.title,
      this.address,
      this.province,
      this.district,
      this.wards,
      this.vn2000,
      this.lat,
      this.long,
      this.description,
      this.area,
      this.squareMetrePrice,
      this.widthMetrePrice,
      this.totalPrice,
      this.commission,
      this.note,
      this.kind,
      this.consignors,
      this.consignorsName,
      this.consignorsPhone,
      this.consignorsExpiry,
      this.images});

  factory RealEstateRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RealEstateRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RealEstateRegisterModelToJson(this);
}

@JsonSerializable()
class VN2000 {
  @JsonKey(name: 'x')
  final double? x;

  @JsonKey(name: 'y')
  final double? y;

  VN2000({
    this.x,
    this.y,
  });

  factory VN2000.fromJson(Map<String, dynamic> json) => _$VN2000FromJson(json);

  Map<String, dynamic> toJson() => _$VN2000ToJson(this);
}

@JsonSerializable()
class RealEstateImageRegister {
  @JsonKey(name: 'url')
  final String? url;

  @JsonKey(name: 'key')
  final String? key;

  RealEstateImageRegister({
    this.url,
    this.key,
  });

  factory RealEstateImageRegister.fromJson(Map<String, dynamic> json) =>
      _$RealEstateImageRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$RealEstateImageRegisterToJson(this);
}

@JsonSerializable()
class RealEstateImageDel {
  @JsonKey(name: 'images')
  final List<RealEstateImageRegister>? images;

  RealEstateImageDel({
    this.images,
  });

  factory RealEstateImageDel.fromJson(Map<String, dynamic> json) =>
      _$RealEstateImageDelFromJson(json);

  Map<String, dynamic> toJson() => _$RealEstateImageDelToJson(this);
}
