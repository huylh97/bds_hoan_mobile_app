import 'package:json_annotation/json_annotation.dart';

enum GenderEnum {
  @JsonValue(0)
  male,
  @JsonValue(1)
  female,
}

int? genderEnumEncode(GenderEnum? value) {
  switch (value) {
    case GenderEnum.male:
      return 0;
    case GenderEnum.female:
      return 1;
    default:
      return null;
  }
}

GenderEnum? genderEnumDecode(int? value) {
  switch (value) {
    case 0:
      return GenderEnum.male;
    case 1:
      return GenderEnum.female;
    default:
      return null;
  }
}

String? genderEnumToString(GenderEnum? value) {
  switch (value) {
    case GenderEnum.male:
      return 'Nam';
    case GenderEnum.female:
      return 'Nữ';
    default:
      return null;
  }
}
