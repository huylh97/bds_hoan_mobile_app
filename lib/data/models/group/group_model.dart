import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_model.g.dart';

@JsonSerializable()
class GroupModel extends Equatable {
  @JsonKey(name: 'Id')
  final int? id;

  @JsonKey(name: 'Name')
  final String? name;

  @JsonKey(name: 'Owner')
  final int? ownerId;

  @JsonKey(name: 'Address')
  final String? address;

  @JsonKey(name: 'Contact')
  final String? contact;

  @JsonKey(name: 'TaxCode')
  final String? taxCode;

  @JsonKey(name: 'EnterprisePhone')
  final String? enterprisePhone;

  @JsonKey(name: 'EnterpriseEmail')
  final String? enterpriseEmail;

  @JsonKey(name: 'IsEnterprise')
  final bool? isEnterprise;

  @JsonKey(name: 'Owners')
  final Owners? owners;

  @JsonKey(name: 'CreatedAt')
  final DateTime? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final DateTime? updatedAt;

  @JsonKey(name: 'Members')
  final List<Member>? members;

  const GroupModel({
    this.id,
    this.name,
    this.ownerId,
    this.address,
    this.contact,
    this.taxCode,
    this.enterpriseEmail,
    this.enterprisePhone,
    this.isEnterprise,
    this.owners,
    this.createdAt,
    this.updatedAt,
    this.members,
  });

  @override
  List<dynamic> get props => [
        id,
        name,
        ownerId,
        address,
        contact,
        taxCode,
        enterpriseEmail,
        enterprisePhone,
        isEnterprise,
        owners,
        createdAt,
        updatedAt,
        members,
      ];

  factory GroupModel.fromJson(Map<String, dynamic> json) => _$GroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupModelToJson(this);
}

@JsonSerializable()
class Owners {
  @JsonKey(name: 'Name')
  final String? name;

  Owners({
    this.name,
  });

  factory Owners.fromJson(Map<String, dynamic> json) => _$OwnersFromJson(json);

  Map<String, dynamic> toJson() => _$OwnersToJson(this);
}

@JsonSerializable()
class Member {
  @JsonKey(name: 'Id')
  final int? id;
  @JsonKey(name: 'Name')
  final String? name;
  @JsonKey(name: 'PhoneNumber')
  final String? phoneNumber;
  @JsonKey(name: 'TotalRE')
  final int? totalRE;
  @JsonKey(name: 'Photo')
  final String? photo;

  Member({this.name, this.id, this.phoneNumber, this.totalRE, this.photo});

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
