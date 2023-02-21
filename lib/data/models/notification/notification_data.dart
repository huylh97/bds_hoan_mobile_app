import 'package:json_annotation/json_annotation.dart';

part 'notification_data.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationData {
  @JsonKey(name: 'Id')
  final int? id;
  @JsonKey(name: 'Title')
  final String? title;
  @JsonKey(name: 'Status')
  final int? status;
  @JsonKey(name: 'Image')
  final String? image;
  @JsonKey(name: 'Seen')
  final bool? seen;
  @JsonKey(name: 'FK_RealEstate')
  final int? fK_RealEstate;
  @JsonKey(name: 'FK_Group')
  final int? fK_Group;
  @JsonKey(name: 'CreatedAt')
  final DateTime? createdAt;
  @JsonKey(name: 'UpdatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: 'User')
  final NotiUserModel? user;

  NotificationData(
      {this.id,
      this.title,
      this.status,
      this.image,
      this.seen,
      this.fK_RealEstate,
      this.fK_Group,
      this.createdAt,
      this.updatedAt,
      this.user});

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}

@JsonSerializable()
class NotiUserModel {
  @JsonKey(name: 'Id')
  final int? id;

  @JsonKey(name: 'Name')
  final String? name;

  @JsonKey(name: 'Photo')
  final String? photo;

  NotiUserModel({this.id, this.name, this.photo});

  factory NotiUserModel.fromJson(Map<String, dynamic> json) =>
      _$NotiUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotiUserModelToJson(this);
}
