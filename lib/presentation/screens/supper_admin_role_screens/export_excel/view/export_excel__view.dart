import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/application/app_text_style.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/configs/app_colors.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/address/address_info.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_filter_model.dart';
import 'package:bds_hoan_mobile/presentation/screens/supper_admin_role_screens/export_excel/cubit/export_excel_cubit.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/app_elevated_button.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/dialogs/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/text_input/selected_text_input.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ExportExcelView extends StatefulWidget {
  ExportExcelView({Key? key}) : super(key: key);

  @override
  _ExportExcelViewState createState() => _ExportExcelViewState();
}

class _ExportExcelViewState extends State<ExportExcelView> {
  late final ExportExcelCubit cubit;
  final _formKey = GlobalKey<FormState>();

  bool _showMustChooseProvince = false;
  bool _showMustChooseDicstrict = false;

  TextEditingController _dateFromEditingController = TextEditingController();
  TextEditingController _dateToEditingController = TextEditingController();
  DateTime? _dateFrom;
  DateTime? _dateTo;
  late bool enableSearchPrice;

  Future<void> onExportExcel() async {
    RealEstateFilterModel filterData = RealEstateFilterModel(
        provinceId: cubit.state.selectedProvince?.id,
        districtId: cubit.state.selectedDicstrict?.id,
        wardId: cubit.state.selectedWard?.id,
        fromDate: _dateFrom,
        toDate: _dateTo);

    final success = await cubit.exportExcelRealEstate(filterData: filterData);

    await Future.delayed(const Duration(milliseconds: 500));
    if (success == true) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SuccessAlertDialog(message: 'Xuất file thành công'),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<ExportExcelCubit>(context);
    cubit.getProvinces();
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
          body: BlocBuilder<ExportExcelCubit, ExportExcelState>(builder: (context, state) {
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
                                  addressFilter(state),
                                  timeFilter(),
                                  clearFilter(),
                                  button(state),
                                  result(state),
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

  Widget addressFilter(ExportExcelState state) {
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

  Widget clearFilter() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
      child: InkWell(
        onTap: () {
          _dateToEditingController.text = '';
          _dateFrom = null;
          _dateFromEditingController.text = '';
          _dateTo = null;
          cubit.clearSearchCondition();
        },
        child: Text(
          'Clear bộ lọc',
          style: TextStyle(
            fontSize: AppTextStyle.smallFontSize,
            color: AppColors.primary,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget button(ExportExcelState state) {
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
          text: 'Xuất file',
          onPressed: () {
            onExportExcel();
          },
          radius: AppDimension.kButtonBorderRadius,
          loading: state.apiCallStatus == ApiCallStatus.loading,
          disabled: state.apiCallStatus == ApiCallStatus.loading,
        ),
      ),
    );
  }

  Widget result(ExportExcelState state) {
    return (state.excelUrl != null && state.excelUrl!.isNotEmpty)
        ? Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
            child: InkWell(
              onTap: () {},
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  if (!await launchUrlString(
                    state.excelUrl!,
                    mode: LaunchMode.externalApplication,
                  )) {
                    throw 'Could not launch ${state.excelUrl!}';
                  }
                },
                child: Text(
                  state.excelUrl ?? '',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: AppTextStyle.smallFontSize,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          )
        : Container();
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      leadingWidth: 0,
      leading: const SizedBox(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            splashColor: Colors.white,
            highlightColor: Colors.white,
            onTap: () {
              AppBloc.appContainerSuperAdminCubit.state.scaffoldKey.currentState?.openDrawer();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.boxBorder),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.menu, color: Color(0xFF374957)),
            ),
          ),
          const Expanded(child: SizedBox()),
          Text(
            'Xuất Excel',
            style: AppBloc.applicationCubit.appTextStyle.mediumBold,
          ),
          const Expanded(child: SizedBox()),
          Text('        ')
        ],
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
