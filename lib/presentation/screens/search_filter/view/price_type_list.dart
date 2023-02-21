class PriceTypeListData {
  PriceTypeListData(
      {this.titleTxt = '', this.isSelected = false, required this.id});

  String titleTxt;
  bool isSelected;
  int id;

  static final List<PriceTypeListData> priceTypeList = <PriceTypeListData>[
    PriceTypeListData(
      titleTxt: 'm2',
      isSelected: false,
      id: 1,
    ),
    PriceTypeListData(titleTxt: 'Mét ngang', isSelected: false, id: 2),
    PriceTypeListData(
      titleTxt: 'Nguyên lô',
      isSelected: false,
      id: 3,
    ),
  ];
}
