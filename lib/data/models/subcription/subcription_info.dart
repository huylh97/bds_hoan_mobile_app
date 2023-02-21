import 'package:json_annotation/json_annotation.dart';

part 'subcription_info.g.dart';

@JsonSerializable(explicitToJson: true)
class SubcriptionInfo {
  @JsonKey(name: 'Id')
  final int? id;
  @JsonKey(name: 'Name')
  final String? name;
  @JsonKey(name: 'Type')
  final int? type;

  @JsonKey(name: 'Price')
  final int? price;
  @JsonKey(name: 'MaxMembers')
  final int? maxMembers;
  @JsonKey(name: 'CreatedAt')
  final DateTime? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final DateTime? updatedAt;

  SubcriptionInfo(
      {this.id,
      this.name,
      this.type,
      this.price,
      this.maxMembers,
      this.createdAt,
      this.updatedAt});

  factory SubcriptionInfo.fromJson(Map<String, dynamic> json) =>
      _$SubcriptionInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SubcriptionInfoToJson(this);
}
