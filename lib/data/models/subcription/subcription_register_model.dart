import 'package:json_annotation/json_annotation.dart';

part 'subcription_register_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SubcriptionRegisterModel {
  @JsonKey(name: 'subscription')
  final int? subscription;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'quantity')
  final int? quantity;
  @JsonKey(name: 'images')
  final List<SubcriptionImageRegister>? images;

  SubcriptionRegisterModel(
      {this.subscription, this.phone, this.quantity, this.images});

  factory SubcriptionRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$SubcriptionRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubcriptionRegisterModelToJson(this);
}

@JsonSerializable()
class SubcriptionImageRegister {
  @JsonKey(name: 'url')
  final String? url;

  @JsonKey(name: 'key')
  final String? key;

  SubcriptionImageRegister({
    this.url,
    this.key,
  });

  factory SubcriptionImageRegister.fromJson(Map<String, dynamic> json) =>
      _$SubcriptionImageRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$SubcriptionImageRegisterToJson(this);
}

@JsonSerializable()
class SubcriptionImageDel {
  @JsonKey(name: 'images')
  final List<SubcriptionImageRegister>? images;

  SubcriptionImageDel({
    this.images,
  });

  factory SubcriptionImageDel.fromJson(Map<String, dynamic> json) =>
      _$SubcriptionImageDelFromJson(json);

  Map<String, dynamic> toJson() => _$SubcriptionImageDelToJson(this);
}
