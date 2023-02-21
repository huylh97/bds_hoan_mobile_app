import 'package:json_annotation/json_annotation.dart';

enum UserRole {
  @JsonValue(1)
  user,
  @JsonValue(2)
  admin,
  @JsonValue(0)
  superAdmin,
}
