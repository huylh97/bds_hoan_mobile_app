import 'package:json_annotation/json_annotation.dart';

part 'create_group_params.g.dart';

@JsonSerializable()
class CreateGroupParams {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'address')
  final String? address;

  @JsonKey(name: 'contact')
  final String? contact;

  @JsonKey(name: 'isEnterprise')
  final bool? isEnterprise;

  @JsonKey(name: 'taxCode')
  final String? taxCode;

  @JsonKey(name: 'enterprisePhone')
  final String? enterprisePhone;

  @JsonKey(name: 'enterpriseMail')
  final String? enterpriseMail;

  const CreateGroupParams({
    this.name,
    this.address,
    this.contact,
    this.isEnterprise,
    this.taxCode,
    this.enterprisePhone,
    this.enterpriseMail,
  });

  factory CreateGroupParams.fromJson(Map<String, dynamic> json) => _$CreateGroupParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGroupParamsToJson(this);
}
