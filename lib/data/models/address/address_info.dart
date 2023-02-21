import 'package:json_annotation/json_annotation.dart';

part 'address_info.g.dart';

@JsonSerializable()
class AddressInfo {
  @JsonKey(name: 'Id')
  final int? id;
  @JsonKey(name: 'Name')
  final String? name;
  @JsonKey(name: 'CodeName')
  final String? codeName;
  @JsonKey(name: 'Type')
  final String? type;

  AddressInfo({
    this.id,
    this.name,
    this.codeName,
    this.type,
  });

  factory AddressInfo.fromJson(Map<String, dynamic> json) =>
      _$AddressInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressInfoToJson(this);

  ///custom comparing function to check if two users are equal
  bool isEqual(AddressInfo model) {
    return this.id == model.id;
  }

  bool locationFilterByName(String? filter) {
    if (filter == null) {
      return true;
    }
    return name!.contains(filter);
  }
}
