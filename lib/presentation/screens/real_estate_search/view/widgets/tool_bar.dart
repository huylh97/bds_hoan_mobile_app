import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/check_box/checkbox.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/check_box/checkbox_title.dart';
import 'package:flutter/material.dart';

import 'tool_button.dart';

class ToolBar extends StatelessWidget {
  const ToolBar(
      {Key? key,
      required this.voidCallbackFilter,
      required this.voidCallbackListMode,
      required this.voidCallbackMapMode,
      required this.voidCallbackNotApprovedList,
      required this.voidCallbackHiddenList,
      required this.notAprrovedOnly,
      required this.hiddenOnly,
      required this.numProduct,
      required this.mapSelected})
      : super(key: key);

  final VoidCallback voidCallbackFilter;
  final VoidCallback voidCallbackListMode;
  final VoidCallback voidCallbackMapMode;
  final VoidCallback voidCallbackNotApprovedList;
  final VoidCallback voidCallbackHiddenList;
  final bool notAprrovedOnly;
  final bool hiddenOnly;
  final int numProduct;
  final bool mapSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${numProduct} sp',
          style: AppBloc.applicationCubit.appTextStyle.normalBold,
        ),
        const SizedBox(width: 20),
        ToolButton(
          iconPath: AppIcons.filter,
          voidCallback: voidCallbackFilter,
        ),
        if (AppBloc.authenticationCubit.isSuperAdmin != true) ...[
          // CheckboxCustom(
          //   title: 'Chưa duyệt',
          //   onTap: voidCallbackNotApprovedList,
          //   value: notAprrovedOnly,
          // )
          const SizedBox(width: 20),
          InkWell(
            splashColor: Colors.white,
            highlightColor: Colors.white,
            onTap: voidCallbackNotApprovedList,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.boxBorder),
                borderRadius: BorderRadius.circular(12),
              ),
              child: (notAprrovedOnly == true)
                  ? const Icon(Icons.library_add_check,
                      color: Color(0xFF374957))
                  : const Icon(Icons.check_box_outline_blank,
                      color: Color(0xFF374957)),
            ),
          ),
        ],
        if (AppBloc.authenticationCubit.isAdminLogin == true) ...[
          const SizedBox(width: 20),
          Tooltip(
              message: 'I am a Tooltip',
              child: InkWell(
                splashColor: Colors.white,
                highlightColor: Colors.white,
                onTap: voidCallbackHiddenList,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.boxBorder),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: (hiddenOnly == true)
                      ? const Icon(Icons.visibility, color: Color(0xFF374957))
                      : const Icon(Icons.visibility_off,
                          color: Color(0xFF374957)),
                ),
              )),
        ],
        const Expanded(child: SizedBox()),
        ToolButton(
          iconPath: AppIcons.list_mode,
          isSelected: !mapSelected,
          voidCallback: voidCallbackListMode,
        ),
        const SizedBox(width: 8),
        ToolButton(
          iconPath: AppIcons.map_mode,
          isSelected: mapSelected,
          voidCallback: voidCallbackMapMode,
        ),
      ],
    );
  }
}
