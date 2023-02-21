import 'package:bds_hoan_mobile/data/models/subcription/subscription_user_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_registered_data.g.dart';

@JsonSerializable(explicitToJson: true)
class SubscriptionRegisteredData {
  @JsonKey(name: 'Id')
  final int? id;
  @JsonKey(name: 'FK_User')
  final int? fKUser;
  @JsonKey(name: 'FK_SubDetails')
  final int? fKSubDetails;
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

  SubscriptionRegisteredData({
    this.id,
    this.fKUser,
    this.fKSubDetails,
    this.status,
    this.phone,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.subscriptionDetails,
  });

  factory SubscriptionRegisteredData.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionRegisteredDataFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionRegisteredDataToJson(this);
}
