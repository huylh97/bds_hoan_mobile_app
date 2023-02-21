import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/configs/app_colors.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/address/address_info.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_filter_model.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_register/deposit_type_list.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_search/cubit/real_estate_search_cubit.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_search/cubit/real_estate_search_state.dart';
import 'package:bds_hoan_mobile/presentation/screens/search_filter/cubit/search_filters_cubit.dart';
import 'package:bds_hoan_mobile/presentation/screens/search_filter/view/price_type_list.dart';
import 'package:bds_hoan_mobile/presentation/screens/search_filter/view/status_list.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/app_elevated_button.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/text_input/app_text_input.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/text_input/selected_text_input.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFiltersView extends StatefulWidget {
  SearchFiltersView({Key? key, this.filteredData}) : super(key: key);

  RealEstateFilterModel? filteredData;

  @override
  _SearchFiltersViewState createState() => _SearchFiltersViewState();
}

class _SearchFiltersViewState extends State<SearchFiltersView> {
  late final SearchFiltersCubit cubit;
  final _formKey = GlobalKey<FormState>();
  List<DepositTypeListData> depositTypeList = [...DepositTypeListData.depositTypeList];
  List<StatusListData> statusList = [...StatusListData.statusList];
  List<PriceTypeListData> priceTypeList = [...PriceTypeListData.priceTypeList];

  bool _showMustChooseProvince = false;
  bool _showMustChooseDicstrict = false;

  TextEditingController _dateFromEditingController = TextEditingController();
  TextEditingController _dateToEditingController = TextEditingController();
  TextEditingController _priceFromEditingController = TextEditingController();
  TextEditingController _priceToEditingController = TextEditingController();
  DateTime? _dateFrom;
  DateTime? _dateTo;
  late bool enableSearchPrice;

  void onApplyFilter() {
    List<int> selectedKindList = [];
    for (int j = 0; j < depositTypeList.length; j++) {
      if (depositTypeList[j].isSelected) {
        selectedKindList.add(depositTypeList[j].id);
      }
    }

    List<int> selStatusList = [];
    for (int j = 0; j < statusList.length; j++) {
      if (statusList[j].isSelected) {
        selStatusList.add(statusList[j].id);
      }
    }

    int? selPriceType;
    int? priceFrom;
    int? priceTo;
    for (int j = 0; j < priceTypeList.length; j++) {
      if (priceTypeList[j].isSelected) {
        selPriceType = priceTypeList[j].id;
        break;
      }
    }

    if (selPriceType != null) {
      priceFrom = int.tryParse(_priceFromEditingController.text.replaceAll(',', ''));
      priceTo = int.tryParse(_priceToEditingController.text.replaceAll(',', ''));
    }

    RealEstateFilterModel filterData = RealEstateFilterModel(
        kindList: selectedKindList,
        priceType: selPriceType,
        priceFrom: priceFrom,
        priceTo: priceTo,
        provinceId: cubit.state.selectedProvince?.id,
        districtId: cubit.state.selectedDicstrict?.id,
        wardId: cubit.state.selectedWard?.id,
        statusList: selStatusList,
        fromDate: _dateFrom,
        toDate: _dateTo);
    Navigator.pop(context, filterData);
  }

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<SearchFiltersCubit>(context);

    for (int j = 0; j < depositTypeList.length; j++) {
      depositTypeList[j].isSelected = false;
    }
    for (int j = 0; j < statusList.length; j++) {
      statusList[j].isSelected = false;
    }
    for (int j = 0; j < priceTypeList.length; j++) {
      priceTypeList[j].isSelected = false;
    }

    enableSearchPrice = false;
    // if (widget.filteredData != null) {
    //   // if (widget.filteredData!.kindList != null &&
    //   //     widget.filteredData!.kindList!.isNotEmpty) {
    //   //   for (int j = 0; j < depositTypeList.length; j++) {
    //   //     if (widget.filteredData!.kindList!.contains(depositTypeList[j].id)) {
    //   //       depositTypeList[j].isSelected = true;
    //   //     }
    //   //   }
    //   // }

    //   // if (widget.filteredData!.priceType != null) {
    //   //   for (int j = 0; j < priceTypeList.length; j++) {
    //   //     if (widget.filteredData!.priceType == priceTypeList[j].id) {
    //   //       priceTypeList[j].isSelected = true;
    //   //       enableSearchPrice = true;
    //   //     }
    //   //   }
    //   // }

    //   // if (widget.filteredData!.priceFrom != null) {
    //   //   _priceFromEditingController = TextEditingController(
    //   //       text: UtilCommon.formatCommaInt(widget.filteredData!.priceFrom));
    //   // }

    //   // // Price To
    //   // if (widget.filteredData!.priceTo != null) {
    //   //   _priceToEditingController = TextEditingController(
    //   //       text: UtilCommon.formatCommaInt(widget.filteredData!.priceTo));
    //   // }

    //   // // Status
    //   // if (widget.filteredData!.statusList != null &&
    //   //     widget.filteredData!.statusList!.isNotEmpty) {
    //   //   for (int j = 0; j < statusList.length; j++) {
    //   //     if (widget.filteredData!.statusList!.contains(statusList[j].id)) {
    //   //       statusList[j].isSelected = true;
    //   //     }
    //   //   }
    //   // }

    //   // if (widget.filteredData!.fromDate != null) {
    //   //   _dateFrom = widget.filteredData!.fromDate;
    //   //   _dateFromEditingController = TextEditingController(
    //   //       text: UtilDateTime.formatDateTime(widget.filteredData!.fromDate));
    //   // }

    //   // if (widget.filteredData!.toDate != null) {
    //   //   _dateTo = widget.filteredData!.toDate;
    //   //   _dateToEditingController = TextEditingController(
    //   //       text: UtilDateTime.formatDateTime(widget.filteredData!.toDate));
    //   // }

    //   // cubit.getLocationInfo(
    //   //     provinceId: widget.filteredData!.provinceId,
    //   //     dicstrictId: widget.filteredData!.districtId,
    //   //     wardId: widget.filteredData!.wardId);
    // } else {
    cubit.getProvinces();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.scaffoldBgColor,
          appBar: _buildAppBar(context),
          body: BlocBuilder<SearchFiltersCubit, SearchFiltersState>(builder: (context, state) {
            if (state.apiCallStatus == ApiCallStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(children: [
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: DefaultDivider(),
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppDimension.kScaffoldHorPadding),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Form(
                                key: _formKey,
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                  const SizedBox(height: AppDimension.kLargeSizedBoxHeight),
                                  kindFilter(),
                                  priceFilter(),
                                  addressFilter(state),
                                  statusFilter(),
                                  timeFilter(),
                                  button(),
                                ]))
                          ]))))
            ]);
          }),
        ));
  }

  Widget _buildTextInputTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(title, style: AppBloc.applicationCubit.appTextStyle.extraBoldPrimaryColor),
    );
  }

  Widget kindFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Loại hàng',
            textAlign: TextAlign.left,
            style: AppBloc.applicationCubit.appTextStyle.mediumBold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getKindList(),
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  List<Widget> getKindList() {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    const int columnCount = 2;
    for (int i = 0; i < depositTypeList.length / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < columnCount; i++) {
        try {
          final DepositTypeListData date = depositTypeList[count];
          listUI.add(Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      setState(() {
                        date.isSelected = !date.isSelected;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            date.isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                            color: date.isSelected ? AppColors.primary : Colors.grey.withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            date.titleTxt,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
          if (count < depositTypeList.length - 1) {
            count += 1;
          } else {
            break;
          }
        } catch (e) {
          print(e);
        }
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  Widget priceFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Lọc theo giá',
            textAlign: TextAlign.left,
            style: AppBloc.applicationCubit.appTextStyle.mediumBold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Column(
                  children: getPriceTypeList(),
                ),
              ),
              const SizedBox(height: AppDimension.kTextFormFieldMargin),
              AppTextInput(
                controller: _priceFromEditingController,
                labelText: 'Từ',
                hintText: 'Từ',
                keyboardType: TextInputType.number,
                validateType: ValidateType.price,
                commaSeperateFlg: true,
                enable: enableSearchPrice,
              ),
              const SizedBox(height: AppDimension.kTextFormFieldMargin),
              AppTextInput(
                controller: _priceToEditingController,
                labelText: 'Tới',
                hintText: 'Tới',
                keyboardType: TextInputType.number,
                validateType: ValidateType.price,
                commaSeperateFlg: true,
                enable: enableSearchPrice,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  List<Widget> getPriceTypeList() {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    const int columnCount = 3;
    for (int i = 0; i < depositTypeList.length / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < columnCount; i++) {
        try {
          final PriceTypeListData priceType = priceTypeList[count];
          listUI.add(Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      setState(() {
                        if (!priceType.isSelected) {
                          for (int j = 0; j < priceTypeList.length; j++) {
                            priceTypeList[j].isSelected = false;
                          }
                          enableSearchPrice = true;
                        } else {
                          enableSearchPrice = false;
                          _priceFromEditingController.text = '';
                          _priceToEditingController.text = '';
                        }
                        priceType.isSelected = !priceType.isSelected;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            priceType.isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                            color: priceType.isSelected ? AppColors.primary : Colors.grey.withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            priceType.titleTxt,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
          if (count < depositTypeList.length - 1) {
            count += 1;
          } else {
            break;
          }
        } catch (e) {
          print(e);
        }
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  Widget addressFilter(SearchFiltersState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Lọc theo khu vực',
            textAlign: TextAlign.left,
            style: AppBloc.applicationCubit.appTextStyle.mediumBold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: [
              const SizedBox(height: AppDimension.kTextFormFieldMargin),
              DropdownSearch<AddressInfo>(
                items: state.provinceList ?? [],
                selectedItem: state.selectedProvince,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    //                               filled: widget.enable == false ? true : false,
                    // fillColor: widget.enable == false ? AppColors.btnDisableBgColor : null,
                    border: buildOutlineBorder(),
                    enabledBorder: buildOutlineBorder(),
                    disabledBorder: buildOutlineBorder(),
                    labelText: 'Tỉnh/Thành phố',
                    hintText: 'Chọn Tỉnh/Thành phố',
                    // helperText: widget.helperText,
                    errorStyle: AppBloc.applicationCubit.appTextStyle.small.copyWith(color: Colors.red),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: AppDimension.kTextFormFieldVerPadding,
                      horizontal: AppDimension.kTextFormFieldHorPadding,
                    ),
                  ),
                ),
                onChanged: (province) {
                  setState(() {
                    _showMustChooseProvince = false;
                  });
                  cubit.getDicStricts(enableLoading: false, selectedProvince: province);
                },
                itemAsString: (addressInfo) => addressInfo.name ?? '',
                filterFn: (location, filter) => location.locationFilterByName(filter),
                compareFn: (i, s) => i.isEqual(s),
                validator: validateField,
                popupProps: PopupProps.dialog(
                  itemBuilder: _customAdressPopupItemBuilder,
                  showSearchBox: true,
                  showSelectedItems: true,
                  dialogProps: const DialogProps(backgroundColor: Colors.white),
                ),
              ),
              const SizedBox(height: AppDimension.kTextFormFieldMargin),
              DropdownSearch<AddressInfo>(
                items: state.dicstrictList ?? [],
                selectedItem: state.selectedDicstrict,
                onBeforePopupOpening: (selectedItem) {
                  if (state.selectedProvince == null) {
                    setState(() {
                      _showMustChooseProvince = true;
                    });
                    return Future<bool>.value(false);
                  } else {
                    setState(() {
                      _showMustChooseProvince = false;
                    });
                    return Future<bool>.value(true);
                  }
                },
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    //                               filled: widget.enable == false ? true : false,
                    // fillColor: widget.enable == false ? AppColors.btnDisableBgColor : null,
                    border: buildOutlineBorder(),
                    enabledBorder: buildOutlineBorder(),
                    disabledBorder: buildOutlineBorder(),
                    labelText: 'Quận/Huyện',
                    hintText: 'Chọn Quận/Huyện',
                    // helperText: widget.helperText,
                    errorStyle: AppBloc.applicationCubit.appTextStyle.small.copyWith(color: Colors.red),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: AppDimension.kTextFormFieldVerPadding,
                      horizontal: AppDimension.kTextFormFieldHorPadding,
                    ),
                  ),
                ),
                itemAsString: (addressInfo) => addressInfo.name ?? '',
                filterFn: (location, filter) => location.locationFilterByName(filter),
                compareFn: (i, s) => i.isEqual(s),
                validator: validateField,
                onChanged: (dicstrict) {
                  setState(() {
                    _showMustChooseDicstrict = false;
                  });
                  cubit.getWards(enableLoading: false, selectedDicstrict: dicstrict);
                },
                popupProps: PopupProps.dialog(
                  itemBuilder: _customAdressPopupItemBuilder,
                  showSearchBox: true,
                  showSelectedItems: true,
                  dialogProps: const DialogProps(backgroundColor: Colors.white),
                ),
              ),
              _showMustChooseProvince == true
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Bạn phải chọn Tỉnh/Thành trước',
                        style: AppBloc.applicationCubit.appTextStyle.small.copyWith(color: Colors.red),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: AppDimension.kTextFormFieldMargin),
              DropdownSearch<AddressInfo>(
                items: state.wardList ?? [],
                selectedItem: state.selectedWard,
                onBeforePopupOpening: (selectedItem) {
                  if (state.selectedProvince == null) {
                    setState(() {
                      _showMustChooseProvince = true;
                    });
                    return Future<bool>.value(false);
                  }

                  if (state.selectedDicstrict == null) {
                    setState(() {
                      _showMustChooseDicstrict = true;
                    });
                    return Future<bool>.value(false);
                  }

                  setState(() {
                    _showMustChooseProvince = false;
                    _showMustChooseDicstrict = false;
                  });
                  return Future<bool>.value(true);
                },
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    //                               filled: widget.enable == false ? true : false,
                    // fillColor: widget.enable == false ? AppColors.btnDisableBgColor : null,
                    border: buildOutlineBorder(),
                    enabledBorder: buildOutlineBorder(),
                    disabledBorder: buildOutlineBorder(),
                    labelText: 'Phường/Xã',
                    hintText: 'Chọn Phường/Xã',
                    // helperText: widget.helperText,
                    errorStyle: AppBloc.applicationCubit.appTextStyle.small.copyWith(color: Colors.red),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: AppDimension.kTextFormFieldVerPadding,
                      horizontal: AppDimension.kTextFormFieldHorPadding,
                    ),
                  ),
                ),
                itemAsString: (addressInfo) => addressInfo.name ?? '',
                filterFn: (location, filter) => location.locationFilterByName(filter),
                compareFn: (i, s) => i.isEqual(s),
                onChanged: (ward) => cubit.setWard(selectedWard: ward),
                validator: validateField,
                popupProps: PopupProps.dialog(
                  itemBuilder: _customAdressPopupItemBuilder,
                  showSearchBox: true,
                  showSelectedItems: true,
                  dialogProps: DialogProps(backgroundColor: Colors.white),
                ),
              ),
              _showMustChooseProvince == true
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Bạn phải chọn Tỉnh/Thành trước',
                        style: AppBloc.applicationCubit.appTextStyle.small.copyWith(color: Colors.red),
                      ),
                    )
                  : const SizedBox(),
              _showMustChooseDicstrict == true
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Bạn phải chọn Quận/Huyện trước',
                        style: AppBloc.applicationCubit.appTextStyle.small.copyWith(color: Colors.red),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: AppDimension.kTextFormFieldMargin),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget statusFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Lọc theo trạng thái',
            textAlign: TextAlign.left,
            style: AppBloc.applicationCubit.appTextStyle.mediumBold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getStatusList(),
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  List<Widget> getStatusList() {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    const int columnCount = 2;
    for (int i = 0; i < statusList.length / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < columnCount; i++) {
        try {
          final StatusListData status = statusList[count];
          listUI.add(Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      setState(() {
                        status.isSelected = !status.isSelected;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            status.isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                            color: status.isSelected ? AppColors.primary : Colors.grey.withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            status.titleTxt,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
          if (count < statusList.length - 1) {
            count += 1;
          } else {
            break;
          }
        } catch (e) {
          print(e);
        }
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  Widget timeFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Lọc theo thời gian',
            textAlign: TextAlign.left,
            style: AppBloc.applicationCubit.appTextStyle.mediumBold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: [
              const SizedBox(height: AppDimension.kTextFormFieldMargin),
              SelectedTextInput(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2025),
                    cancelText: 'Hủy',
                    confirmText: 'Xác nhận',
                  );
                  if (pickedDate != null) {
                    _dateFromEditingController.text = UtilDateTime.formatDateTime(pickedDate);
                    _dateFrom = pickedDate;
                  }
                },
                controller: _dateFromEditingController,
                labelText: 'Từ ngày',
                suffixIconPath: AppIcons.calendar,
                // validateType: ValidateType.date,
              ),
              const SizedBox(height: AppDimension.kTextFormFieldMargin),
              SelectedTextInput(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2025),
                    cancelText: 'Hủy',
                    confirmText: 'Xác nhận',
                  );
                  if (pickedDate != null) {
                    _dateToEditingController.text = UtilDateTime.formatDateTime(pickedDate);
                    _dateTo = pickedDate;
                  }
                },
                controller: _dateToEditingController,
                labelText: 'Tới ngày',
                suffixIconPath: AppIcons.calendar,
                // validateType: ValidateType.date,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              blurRadius: 8,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: AppElevatedButton(
          text: 'Áp dụng',
          onPressed: () {
            onApplyFilter();
          },
          radius: AppDimension.kButtonBorderRadius,
          // loading: state.apiCallStatus ==
          //     ApiCallStatus.loading,
          // disabled: state.apiCallStatus ==
          //     ApiCallStatus.loading,
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(
        'Lọc sản phẩm',
        style: AppBloc.applicationCubit.appTextStyle.mediumBold,
      ),
    );
  }

  Widget _customAdressPopupItemBuilder(BuildContext context, AddressInfo item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.name!),
        // subtitle: Text(item.name),
      ),
    );
  }

  OutlineInputBorder buildOutlineBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.boxBorder),
      borderRadius: BorderRadius.circular(AppDimension.kButtonBorderRadius),
    );
  }

  String? validateField(AddressInfo? addressInfo) {
    if (addressInfo == null) return 'Vui lòng chọn địa chỉ';
    return null;
  }
}
