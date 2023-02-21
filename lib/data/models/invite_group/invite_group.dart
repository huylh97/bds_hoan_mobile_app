import 'package:bds_hoan_mobile/configs/app_constants.dart';
import 'package:bds_hoan_mobile/data/enums/gender.dart';
import 'package:bds_hoan_mobile/data/enums/user_role.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invite_group.g.dart';

@JsonSerializable()
class InviteGroup {
  @JsonKey(name: 'Id')
  final int? id;
  @JsonKey(name: 'Name')
  final String? name;
  @JsonKey(name: 'Address')
  final String? address;
  @JsonKey(name: 'Contact')
  final String? contact;
  @JsonKey(name: 'Owners')
  final GroupOwner? owners;

  InviteGroup({this.id, this.name, this.address, this.contact, this.owners});

  factory InviteGroup.fromJson(Map<String, dynamic> json) => _$InviteGroupFromJson(json);

  Map<String, dynamic> toJson() => _$InviteGroupToJson(this);
}

@JsonSerializable()
class GroupOwner {
  @JsonKey(name: 'Id')
  final int? id;
  @JsonKey(name: 'Name')
  final String? name;
  @JsonKey(name: 'PhoneNumber')
  final String? phoneNumber;
  @JsonKey(name: 'Gender')
  final GenderEnum? gender;
  @JsonKey(name: 'Birthday')
  final String? birthDay;
  @JsonKey(name: 'Photo', defaultValue: AppConstant.defaltAvatarUrl)
  final String? photo;

  String? birthDayFormat() {
    DateTime? _birthDay = UtilDateTime.stringToDateTime(birthDay);
    return UtilDateTime.formatDateTime(_birthDay);
  }

  GroupOwner({
    this.id,
    this.name,
    this.phoneNumber,
    this.gender,
    this.birthDay,
    this.photo,
  });

  factory GroupOwner.fromJson(Map<String, dynamic> json) => _$GroupOwnerFromJson(json);

  Map<String, dynamic> toJson() => _$GroupOwnerToJson(this);
}
