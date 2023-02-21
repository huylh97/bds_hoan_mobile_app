enum RealEstateInputType { vn2000, address }

enum RealEstateProcessMode { register, edit }

class RealEstateRegEditParam {
  final RealEstateProcessMode processMode;
  final RealEstateInputType inputType;
  final int? productId;
  double? lat;
  double? long;

  RealEstateRegEditParam(
      {required this.processMode,
      required this.inputType,
      this.productId,
      this.lat,
      this.long});
}
