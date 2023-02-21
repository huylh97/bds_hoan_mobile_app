import 'package:json_annotation/json_annotation.dart';

part 'subscription_user_data.g.dart';

@JsonSerializable(explicitToJson: true)
class SubscriptionUserData {
  @JsonKey(name: 'Id')
  final int? id;
  @JsonKey(name: 'Status')
  final int? status;
  @JsonKey(name: 'Phone')
  final String? phone;
  @JsonKey(name: 'Quantity')
  final int? quantity;
  @JsonKey(name: 'CreatedAt')
  final DateTime? createdAt;
  @JsonKey(name: 'UpdatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: 'SubscriptionDetails')
  final SubscriptionDetails? subscriptionDetails;
  @JsonKey(name: 'User')
  final SubscriptionUser? user;
  @JsonKey(name: 'Images')
  final List<SubscriptionImageData>? images;
  @JsonKey(name: 'Total')
  final int? total;
  @JsonKey(name: 'CurrentMembers')
  final int? currentMembers;
  @JsonKey(name: 'MaxMembers')
  final int? maxMembers;
  @JsonKey(name: 'SubStart')
  final String? subStart;
  @JsonKey(name: 'SubEnd')
  final String? subEnd;

  SubscriptionUserData(
      {this.id,
      this.status,
      this.phone,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.subscriptionDetails,
      this.user,
      this.images,
      this.total,
      this.currentMembers,
      this.maxMembers,
      this.subStart,
      this.subEnd});

  factory SubscriptionUserData.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionUserDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SubscriptionDetails {
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

  SubscriptionDetails(
      {this.id,
      this.name,
      this.type,
      this.price,
      this.maxMembers,
      this.createdAt,
      this.updatedAt});

  factory SubscriptionDetails.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionDetailsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SubscriptionUser {
  @JsonKey(name: 'Id')
  final int? id;
  @JsonKey(name: 'Name')
  final String? name;
  @JsonKey(name: 'PhoneNumber')
  final String? phoneNumber;
  @JsonKey(name: 'Gender')
  final int? gender;
  @JsonKey(name: 'Birthday')
  final String? birthday;
  @JsonKey(name: 'Photo')
  final String? photo;
  @JsonKey(name: 'Role')
  final int? role;
  @JsonKey(name: 'Status')
  final int? status;

  SubscriptionUser(
      {this.id,
      this.name,
      this.phoneNumber,
      this.gender,
      this.birthday,
      this.photo,
      this.role,
      this.status});

  factory SubscriptionUser.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionUserFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionUserToJson(this);
}

@JsonSerializable()
class SubscriptionImageData {
  @JsonKey(name: 'Id')
  final int? id;

  @JsonKey(name: 'ImageUrl')
  final String? url;

  @JsonKey(name: 'Key')
  final String? key;

  SubscriptionImageData({
    this.id,
    this.url,
    this.key,
  });

  factory SubscriptionImageData.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionImageDataFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionImageDataToJson(this);
}
