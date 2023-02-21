import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/app_colors.dart';
import 'package:bds_hoan_mobile/configs/app_dimension.dart';
import 'package:bds_hoan_mobile/configs/app_icons.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_validate.dart';
import 'package:flutter/material.dart';

class SelectedTextInput extends StatefulWidget {
  const SelectedTextInput({
    Key? key,
    this.hintText,
    this.labelText,
    this.errorText,
    this.controller,
    this.maxLength,
    this.maxLines,
    this.suffixIconPath,
    this.prefixIconPadding,
    this.onTap,
    this.showSuffixIcon = true,
    this.validateType,
  }) : super(key: key);

  final String? hintText;
  final String? labelText;
  final String? errorText;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final String? suffixIconPath;
  final double? prefixIconPadding;
  final VoidCallback? onTap;
  final bool showSuffixIcon;
  final ValidateType? validateType;

  @override
  _SelectedTextInputState createState() => _SelectedTextInputState();
}

class _SelectedTextInputState extends State<SelectedTextInput> {
  final double kIconPadding = 16;

  @override
  void initState() {
    super.initState();
  }

  String? validateField(String? text) {
    if (text == null) return null;

    if (widget.validateType == ValidateType.birthDay) {
      return UtilValidator.validate(data: text, type: ValidateType.birthDay);
    } else if (widget.validateType == ValidateType.date) {
      return UtilValidator.validate(data: text, type: ValidateType.date);
    }

    return null;
  }

  Widget? buildSuffixIcon() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kIconPadding),
      child: widget.suffixIconPath != null
          ? Image.asset(
              widget.suffixIconPath!,
              width: kIconPadding + 5,
              height: kIconPadding + 5,
            )
          : Image.asset(
              widget.suffixIconPath ?? AppIcons.arrow_down,
              width: kIconPadding - 5,
              height: kIconPadding - 5,
            ),
    );
  }

  OutlineInputBorder buildOutlineBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.boxBorder),
      borderRadius: BorderRadius.circular(AppDimension.kButtonBorderRadius),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      controller: widget.controller,
      readOnly: true,
      validator: validateField,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines ?? 1,
      cursorColor: AppColors.kTextColor,
      style: AppBloc.applicationCubit.appTextStyle.normal,
      decoration: InputDecoration(
        errorMaxLines: 3,
        border: buildOutlineBorder(),
        enabledBorder: buildOutlineBorder(),
        focusedBorder: buildOutlineBorder(),
        hintText: widget.hintText,
        labelText: widget.labelText,
        errorText: widget.errorText,
        errorStyle: AppBloc.applicationCubit.appTextStyle.small.copyWith(color: Colors.red),
        suffixIconConstraints: BoxConstraints(minHeight: kIconPadding, minWidth: kIconPadding),
        suffixIcon: widget.showSuffixIcon ? buildSuffixIcon() : null,
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppDimension.kTextFormFieldVerPadding,
          horizontal: AppDimension.kTextFormFieldHorPadding,
        ),
      ),
    );
  }
}
