class StatusListData {
  StatusListData(
      {this.titleTxt = '', this.isSelected = false, required this.id});

  String titleTxt;
  bool isSelected;
  int id;

  static final List<StatusListData> statusList = <StatusListData>[
    StatusListData(
      titleTxt: 'Mới',
      isSelected: false,
      id: 1,
    ),
    StatusListData(titleTxt: 'Đang giao dịch', isSelected: false, id: 2),
    StatusListData(
      titleTxt: 'Bình thường',
      isSelected: false,
      id: 3,
    ),
    StatusListData(
      titleTxt: 'Đã bán',
      isSelected: false,
      id: 4,
    ),
  ];
}
