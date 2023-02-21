class DepositTypeListData {
  DepositTypeListData(
      {this.titleTxt = '', this.isSelected = false, required this.id});

  String titleTxt;
  bool isSelected;
  int id;

  static final List<DepositTypeListData> depositTypeList =
      <DepositTypeListData>[
    DepositTypeListData(
      titleTxt: 'Chính chủ',
      isSelected: false,
      id: 1,
    ),
    DepositTypeListData(titleTxt: 'Liên kết Sale', isSelected: false, id: 2),
    DepositTypeListData(
      titleTxt: 'Công ty',
      isSelected: false,
      id: 3,
    ),
    DepositTypeListData(
      titleTxt: 'Ký gửi',
      isSelected: false,
      id: 4,
    ),
  ];
}
