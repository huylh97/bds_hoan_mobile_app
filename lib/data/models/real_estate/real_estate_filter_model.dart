class RealEstateFilterModel {
  final List<int>? kindList;
  final int? priceType; // 1: mét vuông, 2: mét ngang, 3: nguyên lô
  final int? priceFrom;
  final int? priceTo;
  final int? provinceId;
  final int? districtId;
  final int? wardId;
  final List<int>? statusList;
  final DateTime? fromDate;
  final DateTime? toDate;

  RealEstateFilterModel(
      {this.kindList,
      this.priceType,
      this.priceFrom,
      this.priceTo,
      this.provinceId,
      this.districtId,
      this.wardId,
      this.statusList,
      this.fromDate,
      this.toDate});
}
