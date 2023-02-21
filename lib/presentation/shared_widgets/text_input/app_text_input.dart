import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/app_colors.dart';
import 'package:bds_hoan_mobile/configs/app_dimension.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextInput extends StatefulWidget {
  const AppTextInput(
      {Key? key,
      this.hintText,
      this.labelText,
      this.helperText,
      this.keyboardType,
      this.onFieldSubmitted,
      this.obscureText = false,
      this.controller,
      this.maxLength,
      this.maxLines,
      this.onChanged,
      this.focusNode,
      this.validateType,
      this.validateExtraContronller,
      this.enable,
      this.showSearchIcon,
      this.showLocation,
      this.onSufficIconTap,
      this.commaSeperateFlg,
      this.numDigit,
      this.needtoUpperCase1stLetter,
      this.isRequired})
      : super(key: key);

  final String? hintText;
  final String? labelText;
  final String? helperText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onFieldSubmitted;
  final bool obscureText;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final ValidateType? validateType;
  final TextEditingController? validateExtraContronller;
  final bool? enable;
  final bool? showSearchIcon;
  final bool? showLocation;
  final VoidCallback? onSufficIconTap;
  final bool? commaSeperateFlg;
  final int? numDigit;
  final bool? needtoUpperCase1stLetter;
  final bool? isRequired;

  @override
  _AppTextInputState createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  bool? obscureText;

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  String? validateField(String? text) {
    if (text == null) return null;

    if (widget.validateType == ValidateType.email) {
      return UtilValidator.validate(data: text, type: ValidateType.email);
    } else if (widget.validateType == ValidateType.password) {
      return UtilValidator.validate(data: text, type: ValidateType.password);
    } else if (widget.validateType == ValidateType.confirmPassword) {
      return UtilValidator.validate(data: text, comparePassword: widget.validateExtraContronller?.text, type: ValidateType.confirmPassword);
    } else if (widget.validateType == ValidateType.phone) {
      return UtilValidator.validate(data: text, type: ValidateType.phone, isRequired: widget.isRequired);
    } else if (widget.validateType == ValidateType.name) {
      return UtilValidator.validate(data: text, type: ValidateType.name, isRequired: widget.isRequired);
    } else if (widget.validateType == ValidateType.nameGroup) {
      return UtilValidator.validate(data: text, type: ValidateType.nameGroup);
    } else if (widget.validateType == ValidateType.address) {
      return UtilValidator.validate(data: text, type: ValidateType.address);
    } else if (widget.validateType == ValidateType.taxCode) {
      return UtilValidator.validate(data: text, type: ValidateType.taxCode);
    } else if (widget.validateType == ValidateType.price) {
      return UtilValidator.validate(data: text, type: ValidateType.price);
    } else if (widget.validateType == ValidateType.description) {
      return UtilValidator.validate(data: text, type: ValidateType.description);
    } else if (widget.validateType == ValidateType.commission) {
      return UtilValidator.validate(data: text, type: ValidateType.commission);
    } else if (widget.validateType == ValidateType.area) {
      return UtilValidator.validate(data: text, type: ValidateType.area);
    } else if (widget.validateType == ValidateType.date) {
      return UtilValidator.validate(data: text, type: ValidateType.date);
    } else if (widget.validateType == ValidateType.vn2000) {
      return UtilValidator.validate(data: text, type: ValidateType.vn2000);
    } else if (widget.validateType == ValidateType.title) {
      return UtilValidator.validate(data: text, type: ValidateType.title);
    } else if (widget.validateType == ValidateType.numMonth) {
      return UtilValidator.validate(data: text, type: ValidateType.numMonth);
    } else if (widget.validateType == ValidateType.confirmDel) {
      return UtilValidator.validate(data: text, type: ValidateType.confirmDel);
    }

    return null;
  }

  Widget? buildSuffixIcon() {
    if (widget.obscureText) {
      return GestureDetector(
        dragStartBehavior: DragStartBehavior.down,
        onTap: () {
          setState(() {
            obscureText = !obscureText!;
          });
        },
        child: Icon(
          obscureText! ? Icons.visibility_off : Icons.visibility,
        ),
      );
    }
    if (widget.showSearchIcon == true) {
      return InkWell(
        onTap: widget.onSufficIconTap,
        child: const Icon(Icons.search, size: 28),
      );
    }
    if (widget.showLocation == true) {
      return const Icon(Icons.my_location, size: 28);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> listFormatter = [];

    if (widget.numDigit != null) {
      // listFormatter.add(ReplaceCommaFormatter());
      listFormatter.add(
        FilteringTextInputFormatter.allow(RegExp(r'^[\d,]+\.?\d{0,' + '${widget.numDigit!}' + '}')),
      );
      if (widget.commaSeperateFlg == false) {
        listFormatter.add(ReplaceCommaFormatter());
      }
    }

    if (widget.validateType == ValidateType.numMonth) {
      listFormatter.add(
        FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
      );
    }

    if ((widget.commaSeperateFlg != null && widget.commaSeperateFlg!)) {
      listFormatter.add(ThousandsSeparatorInputFormatter());
    }

    if (widget.needtoUpperCase1stLetter == null || widget.needtoUpperCase1stLetter == true) {
      if (widget.keyboardType == TextInputType.text || widget.keyboardType == TextInputType.name || widget.keyboardType == TextInputType.multiline) {
        listFormatter.add(UppercaseFirstLetterFormatter());
      }
    }

    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText!,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      validator: validateField,
      onFieldSubmitted: widget.onFieldSubmitted,
      focusNode: widget.focusNode,
      style: AppBloc.applicationCubit.appTextStyle.normal,
      enabled: widget.enable ?? true,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        filled: widget.enable == false ? true : false,
        fillColor: widget.enable == false ? AppColors.btnDisableBgColor : null,
        border: buildOutlineBorder(),
        enabledBorder: buildOutlineBorder(),
        disabledBorder: buildOutlineBorder(),
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        errorStyle: AppBloc.applicationCubit.appTextStyle.small.copyWith(color: Colors.red),
        suffixIcon: buildSuffixIcon(),
      ),
      inputFormatters: listFormatter,
    );
  }

  OutlineInputBorder buildOutlineBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.boxBorder),
      borderRadius: BorderRadius.circular(AppDimension.kButtonBorderRadius),
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty

    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text;
    if (newValueText.endsWith(',')) {
      newValueText = replaceCharAt(newValueText, newValueText.length - 1, '.');
    }
    newValueText = newValueText.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) && oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex = newValue.text.length - newValue.selection.extentOffset;
      List<String> chars = [];
      String decimalPart = '';
      if (newValueText.contains('.')) {
        final devideParts = newValueText.split('.');
        chars = devideParts[0].split('');
        decimalPart = devideParts[1];
      } else {
        chars = newValueText.split('');
      }

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) newString = separator + newString;
        newString = chars[i] + newString;
      }

      if (newValueText.contains('.')) {
        newString = newString + '.' + decimalPart;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
  }
}

class ReplaceCommaFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.replaceAll(',', '.'),
      selection: newValue.selection,
    );
  }
}

class UppercaseFirstLetterFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: UtilString.uppercaseFirstLetter(newValue.text) ?? newValue.text,
      selection: newValue.selection,
    );
  }
}
