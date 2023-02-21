import 'package:bds_hoan_mobile/configs/app_constants.dart';
import 'package:bds_hoan_mobile/data/enums/gender.dart';
import 'package:bds_hoan_mobile/data/enums/user_role.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
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
  @JsonKey(name: 'Role')
  final UserRole? role;
  @JsonKey(name: 'Status')
  final int? status;
  @JsonKey(name: 'CreatedBy')
  final int? createdBy;
  @JsonKey(name: 'UpdatedBy')
  final int? updateBy;
  @JsonKey(name: 'Photo', defaultValue: AppConstant.defaltAvatarUrl)
  final String? photo;
  @JsonKey(name: 'CreatedAt')
  final DateTime? createdAt;
  @JsonKey(name: 'TotalRE')
  final int? totalRE;

  UserModel({
    this.id,
    this.name,
    this.phoneNumber,
    this.gender,
    this.birthDay,
    this.role,
    this.status,
    this.createdBy,
    this.updateBy,
    this.photo,
    this.createdAt,
    this.totalRE,
  });

  String? birthDayFormat() {
    DateTime? _birthDay = UtilDateTime.stringToDateTime(birthDay);
    return UtilDateTime.formatDateTime(_birthDay);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
