import 'package:json_annotation/json_annotation.dart';

part 'real_estate_status_update_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RealEstateStatusUpdateModel {
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'salePrice')
  final int? salePrice;

  RealEstateStatusUpdateModel({
    this.status,
    this.salePrice,
  });

  factory RealEstateStatusUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$RealEstateStatusUpdateModelFromJson(json);

  Map<String, dynamic> toJson() => _$RealEstateStatusUpdateModelToJson(this);
}
