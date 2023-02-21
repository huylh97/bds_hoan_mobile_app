import 'package:bds_hoan_mobile/configs/app_colors.dart';
import 'package:flutter/material.dart';

class CheckboxCustom extends StatefulWidget {
  final VoidCallback onTap;
  final String? title;
  final bool value;

  const CheckboxCustom({
    Key? key,
    required this.onTap,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  State<CheckboxCustom> createState() => _CheckboxCustomState();
}

class _CheckboxCustomState extends State<CheckboxCustom> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    widget.value
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: widget.value
                        ? AppColors.primary
                        : Colors.grey.withOpacity(0.6),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    widget.title ?? '',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
