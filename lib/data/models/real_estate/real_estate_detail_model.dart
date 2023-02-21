import 'package:bds_hoan_mobile/data/enums/status.dart';
import 'package:json_annotation/json_annotation.dart';

import 'real_estate_data_model.dart';

part 'real_estate_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RealEstateDetailModel extends RealEstateDataModel {
  @JsonKey(name: 'History')
  final List<String>? historyList;
  @JsonKey(name: 'SalePrice')
  final int? salePrice;

  RealEstateDetailModel(
      {id,
      title,
      address,
      province,
      district,
      wards,
      lat,
      long,
      vn2000X,
      vn2000Y,
      description,
      area,
      squareMetrePrice,
      widthMetrePrice,
      totalPrice,
      priceType,
      commission,
      note,
      status,
      disable,
      user,
      kind,
      consignors,
      consignorsName,
      consignorsPhone,
      consignorsExpiry,
      images,
      createdAt,
      updatedAt,
      this.historyList,
      this.salePrice})
      : super(
            id: id,
            title: title,
            address: address,
            province: province,
            district: district,
            wards: wards,
            lat: lat,
            long: long,
            vn2000X: vn2000X,
            vn2000Y: vn2000Y,
            description: description,
            area: area,
            squareMetrePrice: squareMetrePrice,
            widthMetrePrice: widthMetrePrice,
            totalPrice: totalPrice,
            priceType: priceType,
            commission: commission,
            note: note,
            status: status,
            disable: disable,
            user: user,
            kind: kind,
            consignors: consignors,
            consignorsName: consignorsName,
            consignorsPhone: consignorsPhone,
            consignorsExpiry: consignorsExpiry,
            images: images,
            createdAt: createdAt,
            updatedAt: updatedAt);

  factory RealEstateDetailModel.fromJson(Map<String, dynamic> json) =>
      _$RealEstateDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$RealEstateDetailModelToJson(this);
}
