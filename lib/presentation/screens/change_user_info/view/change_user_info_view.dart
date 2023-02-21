import 'dart:io';

import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/application/app_text_style.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/enums/gender.dart';
import 'package:bds_hoan_mobile/data/enums/user_role.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/app_elevated_button.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/text_input/app_text_input.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/text_input/selected_text_input.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_date_time.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_logger.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_validate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../cubit/change_use_info_cubit.dart';
import '../cubit/change_user_info_state.dart';

class ChangeUserInfoView extends StatefulWidget {
  final int? userId;
  const ChangeUserInfoView({Key? key, required this.userId}) : super(key: key);

  @override
  _ChangeUserInfoViewState createState() {
    return _ChangeUserInfoViewState();
  }
}

class _ChangeUserInfoViewState extends State<ChangeUserInfoView> {
  late final ChangeUserInfoCubit cubit;
  final _formKey = GlobalKey<FormState>();
  final _formKeyConfirmDel = GlobalKey<FormState>();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _birthDayEditingController = TextEditingController();
  final TextEditingController _confirmDeleteInputController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  DateTime? _birdthDay;
  GenderEnum? _gender;
  bool _showGenderErrorText = false;
  File? photo;
  bool disableButtonAccountDel = true;

  @override
  void initState() {
    cubit = BlocProvider.of<ChangeUserInfoCubit>(context);
    _getChangeUserInfoPageData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getChangeUserInfoPageData() async {
    if (widget.userId != null) {
      await cubit.getUserInfoByAdmin(widget.userId);
    } else {
      await cubit.getUserInfo();
    }

    _phoneEditingController.text = cubit.state.userModel?.phoneNumber ?? '';
    _nameEditingController.text = cubit.state.userModel?.name ?? '';
    _birthDayEditingController.text = cubit.state.userModel?.birthDayFormat() ?? '';
    _birdthDay = UtilDateTime.stringToDateTime(cubit.state.userModel?.birthDay);
    _gender = cubit.state.userModel?.gender;
  }

  void onUpdate() async {
    int? _id;
    if (AppBloc.userCubit.state?.role == UserRole.admin) {
      _id = widget.userId ?? AppBloc.userCubit.state?.id;
    } else {
      _id = null;
    }
    cubit.onUpdate(
      userId: _id,
      name: _nameEditingController.text,
      birthDay: UtilDateTime.formatDateTimeToSubmit(_birdthDay),
      gender: _gender,
      photo: photo,
    );
  }

  void _getFromGallery() async {
    try {
      final _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (_pickedFile == null) return;
      setState(() {
        photo = File(_pickedFile.path);
      });
    } catch (e) {
      UtilLogger.log('Pickfile error');
    }
  }

  void confirmDel() {
    _confirmDeleteInputController.text = '';
    _displayConfirmDelDialog(context).then((value) async {
      bool? confirmDel = value as bool?;
      if (confirmDel == true) {
        bool? ret = await cubit.onRequestDeletion();
        if (ret == true) {
          await AppBloc.authenticationCubit.onClear();
          AppBloc.appContainerAdminCubit.reset();
          AppBloc.appContainerMemberCubit.reset();
          Navigator.pop(context);
        }
      }
    });
  }

  Future<void> _displayConfirmDelDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Xác nhận xóa', style: AppBloc.applicationCubit.appTextStyle.extraBoldPrimaryColor),
            content: Form(
                key: _formKeyConfirmDel,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: 'Để xóa tài khoản, vui lòng nhập ',
                      style: AppBloc.applicationCubit.appTextStyle.normal,
                      children: <TextSpan>[
                        TextSpan(text: '\'delete\'', style: AppBloc.applicationCubit.appTextStyle.normal.copyWith(color: AppColors.primary)),
                        const TextSpan(
                            text:
                                ' vào ô bên dưới. Việc xóa tài khoản sẽ khiến bạn không thể sử dụng được ứng dụng nữa. Vui lòng cân nhắc trước khi thực hiện hành động này.'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppDimension.kSizedBoxHeight,
                  ),
                  AppTextInput(
                    controller: _confirmDeleteInputController,
                    hintText: 'Xác nhận',
                    labelText: 'Xác nhận',
                    keyboardType: TextInputType.text,
                    validateType: ValidateType.confirmDel,
                    needtoUpperCase1stLetter: false,
                  )
                ])),
            actions: <Widget>[
              AppElevatedButton(
                text: 'Xác nhận',
                onPressed: () async {
                  if (_formKeyConfirmDel.currentState!.validate()) {
                    if (_confirmDeleteInputController.text.isEmpty || _confirmDeleteInputController.text != 'delete') {
                      return;
                    }
                    Navigator.pop(context, true);
                  }
                },
                radius: AppDimension.kButtonBorderRadius,
              )
            ],
          );
        });
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
          body: BlocBuilder<ChangeUserInfoCubit, ChangeUserInfoState>(builder: (context, state) {
            if (state.apiCallStatus == ApiCallStatus.loading && state.userModel == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
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
                          const SizedBox(height: AppDimension.kLargeSizedBoxHeight),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 61,
                                    backgroundColor: AppColors.primary,
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.greyLight,
                                      backgroundImage: photo != null
                                          ? Image.file(
                                              photo!,
                                              fit: BoxFit.cover,
                                            ).image
                                          : NetworkImage(state.userModel?.photo != null && state.userModel?.photo != ''
                                              ? state.userModel!.photo!
                                              : AppConstant.defaltAvatarUrl),
                                      radius: 60,
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 63,
                                    backgroundColor: Colors.transparent,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: InkWell(
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            onTap: () => _getFromGallery(),
                                            child: const CircleAvatar(
                                              radius: 18,
                                              backgroundColor: Colors.black26,
                                              child: Icon(CupertinoIcons.camera, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(height: AppDimension.kLargeSizedBoxHeight),
                                AppTextInput(
                                  controller: _phoneEditingController,
                                  labelText: 'Số điện thoại',
                                  hintText: state.userModel?.phoneNumber ?? '',
                                  enable: false,
                                ),
                                const SizedBox(height: AppDimension.kTextFormFieldMargin),
                                AppTextInput(
                                  controller: _nameEditingController,
                                  labelText: 'Họ tên',
                                  hintText: 'Nhập họ tên',
                                  keyboardType: TextInputType.name,
                                  validateType: ValidateType.name,
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
                                      _birthDayEditingController.text = UtilDateTime.formatDateTime(pickedDate);
                                      _birdthDay = pickedDate;
                                    }
                                  },
                                  controller: _birthDayEditingController,
                                  labelText: 'Ngày sinh',
                                  suffixIconPath: AppIcons.calendar,
                                  validateType: ValidateType.birthDay,
                                ),
                                const SizedBox(height: AppDimension.kTextFormFieldMargin),
                                _buildTextInputTitle('Giới tính'),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: RadioListTile<GenderEnum>(
                                        title: Text("Nam", style: AppBloc.applicationCubit.appTextStyle.normal),
                                        value: GenderEnum.male,
                                        groupValue: _gender,
                                        onChanged: (value) {
                                          setState(() {
                                            _gender = value;
                                          });
                                        },
                                        contentPadding: EdgeInsets.zero,
                                        activeColor: AppColors.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 30),
                                    SizedBox(
                                      width: 120,
                                      child: RadioListTile<GenderEnum>(
                                        title: Text("Nữ", style: AppBloc.applicationCubit.appTextStyle.normal),
                                        value: GenderEnum.female,
                                        groupValue: _gender,
                                        onChanged: (value) {
                                          setState(() {
                                            _gender = value;
                                          });
                                        },
                                        contentPadding: EdgeInsets.zero,
                                        activeColor: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                _showGenderErrorText == true
                                    ? Padding(
                                        padding: const EdgeInsets.only(left: 16.0),
                                        child: Text(
                                          'Vui lòng chọn giới tính',
                                          style: AppBloc.applicationCubit.appTextStyle.small.copyWith(color: Colors.red),
                                        ),
                                      )
                                    : const SizedBox(),
                                const SizedBox(height: AppDimension.kTextFormFieldMargin),
                                AppElevatedButton(
                                  text: 'Cập nhật',
                                  onPressed: () {
                                    if (_gender == null) {
                                      setState(() {
                                        _showGenderErrorText = true;
                                      });
                                    } else {
                                      setState(() {
                                        _showGenderErrorText = false;
                                      });
                                    }
                                    if (_formKey.currentState!.validate()) {
                                      if (_showGenderErrorText == false) {
                                        onUpdate();
                                      }
                                    }
                                  },
                                  radius: AppDimension.kButtonBorderRadius,
                                  loading: state.apiCallStatus == ApiCallStatus.loading,
                                  disabled: state.apiCallStatus == ApiCallStatus.loading,
                                ),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: InkWell(
                                    onTap: () {
                                      confirmDel();
                                    },
                                    child: Text(
                                      'Xóa tài khoản',
                                      style: TextStyle(
                                        fontSize: AppTextStyle.smallFontSize,
                                        color: AppColors.primary,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
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
      child: Text(title, style: AppBloc.applicationCubit.appTextStyle.normalBold),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(
        widget.userId == AppBloc.userCubit.state?.id ? 'Hồ sơ cá nhân' : 'Hồ sơ thành viên',
        style: AppBloc.applicationCubit.appTextStyle.mediumBold,
      ),
    );
  }
}
