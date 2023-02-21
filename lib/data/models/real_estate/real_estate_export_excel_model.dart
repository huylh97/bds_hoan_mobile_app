import 'package:json_annotation/json_annotation.dart';

part 'real_estate_export_excel_model.g.dart';

@JsonSerializable()
class RealEstateExportExcelModel {
  @JsonKey(name: 'Url')
  final String? url;

  @JsonKey(name: 'Key')
  final String? key;

  RealEstateExportExcelModel({
    this.url,
    this.key,
  });

  factory RealEstateExportExcelModel.fromJson(Map<String, dynamic> json) =>
      _$RealEstateExportExcelModelFromJson(json);

  Map<String, dynamic> toJson() => _$RealEstateExportExcelModelToJson(this);
}
