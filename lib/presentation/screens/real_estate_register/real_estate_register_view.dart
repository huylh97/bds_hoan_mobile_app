import 'dart:io';

import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/address/address_info.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_register_param.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_register_model.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_register/cubit/real_estate_register_cubit.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/dialogs/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/text_input/app_text_input.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/text_input/selected_text_input.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'deposit_type_list.dart';

class RealEstateRegisterView extends StatefulWidget {
  const RealEstateRegisterView({Key? key, required this.param}) : super(key: key);

  final RealEstateRegEditParam param;

  @override
  State<RealEstateRegisterView> createState() => _RealEstateRegisterViewState();
}

class _RealEstateRegisterViewState extends State<RealEstateRegisterView> {
  late final RealEstateRegisterCubit cubit;
  final _formKey = GlobalKey<FormState>();
  final _formFieldKey = GlobalKey<FormFieldState>();
  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _addressEditingController = TextEditingController();
  TextEditingController _vn2000XEditingController = TextEditingController();
  TextEditingController _vn2000YEditingController = TextEditingController();
  TextEditingController _descriptionEditingController = TextEditingController();
  TextEditingController _priceSquareMetreEditingController = TextEditingController();
  TextEditingController _priceWidthMetreEditingController = TextEditingController();
  TextEditingController _priceAllEditingController = TextEditingController();
  TextEditingController _commissionEditingController = TextEditingController();
  TextEditingController _areaEditingController = TextEditingController();

  TextEditingController _depositNameEditingController = TextEditingController();
  TextEditingController _depositPhoneEditingController = TextEditingController();
  TextEditingController _depositTermEditingController = TextEditingController();
  ImagePicker _picker = ImagePicker();

  List<DepositTypeListData> depositTypeListData = [...DepositTypeListData.depositTypeList];

  bool _showDepositTypeErrorText = false;
  bool _showMustChooseProvince = false;
  bool _showMustChooseDicstrict = false;
  DateTime? _consignorsExpiry;
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
    depositTypeListData = [...DepositTypeListData.depositTypeList];
    for (int j = 0; j < depositTypeListData.length; j++) {
      depositTypeListData[j].isSelected = false;
    }
    cubit = BlocProvider.of<RealEstateRegisterCubit>(context);
    if (widget.param.processMode == RealEstateProcessMode.edit) {
      cubit.getRealEstateDetalById(productId: widget.param.productId!);
    } else {
      cubit.getProvinces();
    }
  }

  void _getFromGallery() async {
    try {
      final _pickedFiles = await _picker.pickMultiImage();
      if (_pickedFiles == null || _pickedFiles.isEmpty) return;

      setState(() {
        cubit.uploadRealEstateImg(pickedFiles: _pickedFiles);
      });
    } catch (e) {
      UtilLogger.log('Pickfile error');
    }
  }

  void onRegisterRealEstate() async {
    final success = await cubit.registerRealEstate(
      param: widget.param,
      title: _titleEditingController.text,
      address: _addressEditingController.text,
      vn2000X: double.tryParse(_vn2000XEditingController.text.replaceAll(',', '')),
      vn2000Y: double.tryParse(_vn2000YEditingController.text.replaceAll(',', '')),
      description: _descriptionEditingController.text,
      area: double.tryParse(_areaEditingController.text.replaceAll(',', '')),
      priceSquareMetre: int.tryParse(_priceSquareMetreEditingController.text.replaceAll(',', '')),
      priceWidthMetre: int.tryParse(_priceWidthMetreEditingController.text.replaceAll(',', '')),
      priceAll: int.tryParse(_priceAllEditingController.text.replaceAll(',', '')),
      commission: int.tryParse(_commissionEditingController.text.replaceAll(',', '')),
      note: '',
      consignorsName: _depositNameEditingController.text,
      consignorsPhone: _depositPhoneEditingController.text,
      consignorsExpiry: UtilDateTime.formatDateTimeToSubmit(_consignorsExpiry),
    );
    await Future.delayed(const Duration(milliseconds: 500));
    if (success == true) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SuccessAlertDialog(message: 'Thêm bất động sản thành công'),
      );
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.pop(context);
    }
  }

  void onUpdateRealEstate() async {
    final success = await cubit.updateRealEstate(
      param: widget.param,
      title: _titleEditingController.text,
      address: _addressEditingController.text,
      vn2000X: double.tryParse(_vn2000XEditingController.text.replaceAll(',', '')),
      vn2000Y: double.tryParse(_vn2000YEditingController.text.replaceAll(',', '')),
      description: _descriptionEditingController.text,
      area: double.tryParse(_areaEditingController.text.replaceAll(',', '')),
      priceSquareMetre: int.tryParse(_priceSquareMetreEditingController.text.replaceAll(',', '')),
      priceWidthMetre: int.tryParse(_priceWidthMetreEditingController.text.replaceAll(',', '')),
      priceAll: int.tryParse(_priceAllEditingController.text.replaceAll(',', '')),
      commission: int.tryParse(_commissionEditingController.text.replaceAll(',', '')),
      note: '',
      consignorsName: _depositNameEditingController.text,
      consignorsPhone: _depositPhoneEditingController.text,
      consignorsExpiry: UtilDateTime.formatDateTimeToSubmit(_consignorsExpiry),
    );
    await Future.delayed(const Duration(milliseconds: 500));
    if (success == true) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SuccessAlertDialog(message: 'Chỉnh sửa thành công'),
      );
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.pop(context);
    }
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
          body: BlocBuilder<RealEstateRegisterCubit, RealEstateRegisterState>(builder: (context, state) {
            if (state.apiCallStatus == ApiCallStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (widget.param.processMode == RealEstateProcessMode.edit && _isInit == true) {
              _isInit = false;
              widget.param.lat = state.editData!.lat;
              widget.param.long = state.editData!.long;
              _titleEditingController = TextEditingController(text: state.editData!.title);
              _addressEditingController = TextEditingController(text: state.editData!.address);
              _vn2000XEditingController = TextEditingController(text: state.editData!.vn2000X == null ? '' : state.editData!.vn2000X.toString());
              _vn2000YEditingController = TextEditingController(text: state.editData!.vn2000Y == null ? '' : state.editData!.vn2000Y.toString());
              _areaEditingController = TextEditingController(text: UtilCommon.formatCommaDoubleArea(state.editData!.area));
              _priceSquareMetreEditingController = TextEditingController(text: UtilCommon.formatCommaInt(state.editData!.squareMetrePrice));
              _priceWidthMetreEditingController = TextEditingController(text: UtilCommon.formatCommaInt(state.editData!.widthMetrePrice));
              _priceAllEditingController = TextEditingController(text: UtilCommon.formatCommaInt(state.editData!.totalPrice));
              _commissionEditingController = TextEditingController(text: UtilCommon.formatCommaInt(state.editData!.commission));
              _descriptionEditingController = TextEditingController(text: state.editData!.description);
              for (int j = 0; j < depositTypeListData.length; j++) {
                depositTypeListData[j].isSelected = false;
                if (depositTypeListData[j].id == state.editData!.kind!.id) {
                  depositTypeListData[j].isSelected = true;
                }
              }
              if (state.editData!.kind!.id == 2 || state.editData!.kind!.id == 4) {
                _depositNameEditingController = TextEditingController(text: state.editData!.consignorsName);
                _depositPhoneEditingController = TextEditingController(text: state.editData!.consignorsPhone);
                if (state.editData!.kind!.id == 4) {
                  _consignorsExpiry = UtilDateTime.stringToDateTime(state.editData!.consignorsExpiry);
                  _depositTermEditingController = TextEditingController(text: UtilDateTime.formatDateTime(_consignorsExpiry));
                }
              }
            }

            return Column(
              children: [
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: DefaultDivider(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimension.kScaffoldHorPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(height: AppDimension.kLargeSizedBoxHeight),
                                // -------------------------- Chi tiết sản phẩm START ---------------------------//
                                _buildTextInputTitle('Tiêu đề'),
                                const SizedBox(height: AppDimension.kTextFormFieldMargin),
                                AppTextInput(
                                  controller: _titleEditingController,
                                  labelText: 'Tiêu đề',
                                  hintText: 'Nhập tiêu đề',
                                  keyboardType: TextInputType.text,
                                  validateType: ValidateType.title,
                                  showLocation: false,
                                ),
                                const SizedBox(height: AppDimension.kTextFormFieldMargin),
                                _buildTextInputTitle('Địa chỉ'),

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
                                  key: _formFieldKey,
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
                                AppTextInput(
                                  controller: _addressEditingController,
                                  labelText: 'Địa chỉ',
                                  hintText: 'Nhập địa chỉ',
                                  keyboardType: TextInputType.text,
                                  // validateType: ValidateType.address,
                                  showLocation: false,
                                ),

                                const SizedBox(height: AppDimension.kTextFormFieldMargin),
                                if (widget.param.inputType == RealEstateInputType.vn2000) ...[
                                  Row(
                                    children: [
                                      Expanded(
                                          child: AppTextInput(
                                        controller: _vn2000XEditingController,
                                        labelText: 'X',
                                        hintText: 'X',
                                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                        validateType: ValidateType.vn2000,
                                        numDigit: 2,
                                        commaSeperateFlg: false,
                                      )),
                                      const SizedBox(width: AppDimension.kSizedBoxWidth),
                                      Expanded(
                                          child: AppTextInput(
                                        controller: _vn2000YEditingController,
                                        labelText: 'Y',
                                        hintText: 'Y',
                                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                        validateType: ValidateType.vn2000,
                                        numDigit: 2,
                                        commaSeperateFlg: false,
                                      )),
                                    ],
                                  )
                                ],

                                const SizedBox(height: AppDimension.kTextFormFieldMargin),

                                // -------------------------- Chi tiết sản phẩm START ---------------------------//
                                _buildTextInputTitle('Chi tiết sản phẩm'),
                                const SizedBox(height: AppDimension.kTextFormFieldMargin),

                                Row(
                                  children: [
                                    Expanded(
                                        child: AppTextInput(
                                      controller: _areaEditingController,
                                      labelText: 'Diện tích',
                                      hintText: 'Nhập diện tích',
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      validateType: ValidateType.area,
                                      commaSeperateFlg: true,
                                      numDigit: 1,
                                      onChanged: (value) {
                                        // _priceAllEditingController.text.isNotEmpty ||
                                        if (_priceSquareMetreEditingController.text.isEmpty) {
                                          return;
                                        }
                                        if (value.isNotEmpty) {
                                          _priceAllEditingController.text = UtilCommon.formatCommaDouble(
                                              int.parse(_priceSquareMetreEditingController.text.replaceAll(',', '')) *
                                                  double.parse(value.replaceAll(',', '')));
                                        }
                                      },
                                    )),
                                    const SizedBox(width: AppDimension.kSizedBoxWidth),
                                    Expanded(
                                      child: AppTextInput(
                                        controller: _priceSquareMetreEditingController,
                                        labelText: '/m2',
                                        hintText: '/m2',
                                        keyboardType: TextInputType.number,
                                        validateType: ValidateType.price,
                                        commaSeperateFlg: true,
                                        onChanged: (value) {
                                          //_priceAllEditingController.text.isNotEmpty ||
                                          if (_areaEditingController.text.isEmpty) {
                                            return;
                                          }
                                          if (value.isNotEmpty) {
                                            _priceAllEditingController.text = UtilCommon.formatCommaDouble(
                                                double.parse(_areaEditingController.text.replaceAll(',', '')) *
                                                    (int.tryParse(value.replaceAll(',', '')) ?? 0));
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: AppDimension.kTextFormFieldMargin),
                                Row(
                                  children: [
                                    Expanded(
                                        child: AppTextInput(
                                      controller: _priceWidthMetreEditingController,
                                      labelText: '/mét ngang',
                                      hintText: '/mn',
                                      keyboardType: TextInputType.number,
                                      // validateType: ValidateType.price,
                                      commaSeperateFlg: true,
                                    )),
                                    const SizedBox(width: AppDimension.kSizedBoxWidth),
                                    Expanded(
                                        child: AppTextInput(
                                      controller: _priceAllEditingController,
                                      labelText: '/nguyên lô',
                                      hintText: '/nguyên lô',
                                      keyboardType: TextInputType.number,
                                      validateType: ValidateType.price,
                                      commaSeperateFlg: true,
                                    ))
                                  ],
                                ),
                                const SizedBox(height: AppDimension.kTextFormFieldMargin),
                                AppTextInput(
                                  controller: _commissionEditingController,
                                  labelText: 'Hoa hồng',
                                  hintText: 'Nhập hoa hồng',
                                  keyboardType: TextInputType.number,
                                  validateType: ValidateType.commission,
                                  commaSeperateFlg: true,
                                ),

                                // -------------------------- Chi tiết sản phẩm END ---------------------------//
                                const SizedBox(height: AppDimension.kTextFormFieldMargin),
                                const SizedBox(height: AppDimension.kTextFormFieldMargin),
                                const SizedBox(height: AppDimension.kTextFormFieldMargin),

                                // -------------------------- Thông tin ký gửi START ---------------------------//
                                _depositType(),
                                _showDepositTypeErrorText == true
                                    ? Padding(
                                        padding: const EdgeInsets.only(left: 16.0),
                                        child: Text(
                                          'Vui lòng chọn loại hình sản phẩm',
                                          style: AppBloc.applicationCubit.appTextStyle.small.copyWith(color: Colors.red),
                                        ),
                                      )
                                    : const SizedBox(),
                                const SizedBox(height: AppDimension.kTextFormFieldMargin),
                                if (state.kind == 2 || state.kind == 4) ...[
                                  // Truong hop la ky gui.sale lien ket thi moi hien thi
                                  AppTextInput(
                                    controller: _depositNameEditingController,
                                    labelText: state.kind == 2 ? 'Tên sale liên kết' : 'Tên người ký gửi',
                                    hintText: state.kind == 2 ? 'Nhập tên sale liên kết' : 'Nhập tên người ký gửi',
                                    keyboardType: TextInputType.text,
                                    validateType: ValidateType.name,
                                    isRequired: false,
                                  ),
                                  const SizedBox(height: AppDimension.kTextFormFieldMargin),
                                  AppTextInput(
                                    controller: _depositPhoneEditingController,
                                    labelText: state.kind == 2 ? 'Số điện thoại sale liên kết' : 'Số điện thoại người ký gửi',
                                    hintText: 'Nhập số điện thoại',
                                    keyboardType: TextInputType.phone,
                                    validateType: ValidateType.phone,
                                    isRequired: false,
                                  ),
                                  if (state.kind == 4) ...[
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
                                          _depositTermEditingController.text = UtilDateTime.formatDateTime(pickedDate);
                                          _consignorsExpiry = pickedDate;
                                        }
                                      },
                                      controller: _depositTermEditingController,
                                      labelText: 'Hạn ký gửi',
                                      suffixIconPath: AppIcons.calendar,
                                      // validateType: ValidateType.date,
                                    ),
                                  ]
                                ],
                                // -------------------------- Thông tin ký gửi END ---------------------------//
                                const SizedBox(height: AppDimension.kTextFormFieldMargin),
                                AppTextInput(
                                  controller: _descriptionEditingController,
                                  labelText: 'Mô tả',
                                  hintText: 'Nhập mô tả',
                                  maxLines: 6,
                                  keyboardType: TextInputType.multiline,
                                  // validateType: ValidateType.description,
                                ),

                                const SizedBox(height: AppDimension.kTextFormFieldMargin),
                                (state.isUploading != null && state.isUploading!)
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : _imageUpload(images: state.images),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () => _getFromGallery(),
                                        child: Container(
                                            height: 120,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              color: AppColors.greyAccountIcon,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            padding: const EdgeInsets.all(40),
                                            child: Icon(
                                              Icons.add,
                                              color: AppColors.greyLight,
                                            ))),
                                  ],
                                ),
                                const SizedBox(height: AppDimension.kTextFormFieldMargin),
                                AppElevatedButton(
                                  text: 'Gửi',
                                  onPressed: () {
                                    if (state.kind == null) {
                                      setState(() {
                                        _showDepositTypeErrorText = true;
                                      });
                                    } else {
                                      setState(() {
                                        _showDepositTypeErrorText = false;
                                      });
                                    }
                                    if (_formKey.currentState!.validate() && !_showDepositTypeErrorText) {
                                      if (widget.param.processMode == RealEstateProcessMode.register) {
                                        onRegisterRealEstate();
                                      } else {
                                        onUpdateRealEstate();
                                      }
                                    }
                                  },
                                  radius: AppDimension.kButtonBorderRadius,
                                  loading: state.apiCallStatus == ApiCallStatus.loading,
                                  disabled: state.apiCallStatus == ApiCallStatus.loading,
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          })),
    );
  }

  Widget _buildTextInputTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(title, style: AppBloc.applicationCubit.appTextStyle.extraBoldPrimaryColor),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(
        widget.param.processMode == RealEstateProcessMode.register ? 'Thêm sản phẩm' : 'Chỉnh sửa sản phẩm',
        style: AppBloc.applicationCubit.appTextStyle.mediumBold,
      ),
    );
  }

  Widget _depositType() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 0, left: 0),
          child: Column(
            children: _getDepositList(),
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  List<Widget> _getDepositList() {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    const int columnCount = 2;
    for (int i = 0; i < depositTypeListData.length / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < columnCount; i++) {
        try {
          final DepositTypeListData depositType = depositTypeListData[count];
          listUI.add(Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      setState(() {
                        if (!depositType.isSelected) {
                          for (int j = 0; j < depositTypeListData.length; j++) {
                            depositTypeListData[j].isSelected = false;
                          }
                        }
                        depositType.isSelected = !depositType.isSelected;
                        cubit.setKind(selectedKind: depositType.id);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            depositType.isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                            color: depositType.isSelected ? AppColors.primary : AppColors.primary,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            depositType.titleTxt,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
          if (count < depositTypeListData.length - 1) {
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

  Widget _imageUpload({required List<RealEstateImageRegister> images}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 0, left: 0),
          child: Column(
            children: _getImageList(images: images),
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  List<Widget> _getImageList({required List<RealEstateImageRegister> images}) {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    const int columnCount = 3;
    for (int i = 0; i < images.length / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < columnCount; i++) {
        try {
          final RealEstateImageRegister realEstateImage = images[count];
          listUI.add(Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.boxBorder),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: realEstateImage.url != null
                                  ? Stack(children: <Widget>[
                                      CachedNetworkImage(
                                        imageUrl: realEstateImage.url!,
                                        imageBuilder: (context, imageProvider) => Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) => Image.asset(
                                          'assets/images/no-image.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                          top: 5,
                                          right: 5,
                                          child: GestureDetector(
                                            onTap: () {
                                              cubit.deleteUploadedRealEstateImg(removeFile: realEstateImage);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: AppColors.boxBorder),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Icon(
                                                Icons.highlight_remove,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                          )),
                                    ])
                                  : Container()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
          if (count < images.length - 1) {
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
