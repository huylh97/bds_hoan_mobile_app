import 'package:json_annotation/json_annotation.dart';

enum StatusEnum {
  @JsonValue(0)
  New,
  @JsonValue(1)
  Approved,
  @JsonValue(2)
  GD,
  @JsonValue(3)
  Normal,
  @JsonValue(4)
  SaledByAdmin,
  @JsonValue(5)
  SaledByUser,
}

int? StatusEnumEncode(StatusEnum? value) {
  switch (value) {
    case StatusEnum.New:
      return 0;
    case StatusEnum.Approved:
      return 1;
    case StatusEnum.GD:
      return 2;
    case StatusEnum.Normal:
      return 3;
    case StatusEnum.SaledByAdmin:
      return 4;
    case StatusEnum.SaledByUser:
      return 5;
    default:
      return null;
  }
}

StatusEnum? StatusEnumDecode(int? value) {
  switch (value) {
    case 0:
      return StatusEnum.New;
    case 1:
      return StatusEnum.Approved;
    case 2:
      return StatusEnum.GD;
    case 3:
      return StatusEnum.Normal;
    case 4:
      return StatusEnum.SaledByAdmin;
    case 5:
      return StatusEnum.SaledByUser;
    default:
      return null;
  }
}

String? StatusEnumToString(StatusEnum? value) {
  switch (value) {
    case StatusEnum.New:
      return 'New';
    case StatusEnum.Approved:
      return 'Approved';
    default:
      return null;
  }
}
