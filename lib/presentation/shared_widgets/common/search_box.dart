import 'package:bds_hoan_mobile/bloc_global/application/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    Key? key,
    required this.controller,
    this.hintText,
    this.onFieldSubmitted,
    this.onChanged,
    this.onClearText,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final ValueChanged<String?>? onFieldSubmitted;
  final ValueChanged<String?>? onChanged;
  final VoidCallback? onClearText;

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  void initState() {
    super.initState();
  }

  Widget? buildSuffixIcon() {
    if (widget.controller.text.isEmpty) return null;
    return GestureDetector(
      dragStartBehavior: DragStartBehavior.down,
      onTap: () {
        widget.controller.clear();
        setState(() {});
        widget.onClearText?.call();
      },
      child: const Icon(Icons.clear),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: (String text) {
        widget.onChanged?.call(text);
        setState(() {});
      },
      decoration: InputDecoration(
        isDense: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
          borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
          borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 1),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
          borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 1),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: const Color(0xFFC5C5C5), fontWeight: FontWeight.bold, fontSize: AppTextStyle.normalFontSize),
        suffixIcon: buildSuffixIcon(),
        suffixIconConstraints: BoxConstraints(minWidth: 35.sp),
        // prefixIcon: Image.asset(AppIcons.search, width: 18.sp, height: 18.sp),
        prefixIconConstraints: BoxConstraints(minWidth: 35.sp),
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppDimension.kTextFormFieldVerPadding,
          horizontal: AppDimension.kTextFormFieldHorPadding,
        ),
      ),
    );
  }
}
