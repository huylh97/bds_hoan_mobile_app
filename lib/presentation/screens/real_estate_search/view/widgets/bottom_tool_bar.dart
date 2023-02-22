import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ToolBar extends StatefulWidget {
  const ToolBar({
    Key? key,
    required this.onSwitchViewMode,
    required this.voidCallbackFilter,
    required this.numProduct,
    required this.initalDisplayMap,
  }) : super(key: key);

  final Function(bool) onSwitchViewMode;
  final VoidCallback voidCallbackFilter;
  final int numProduct;
  final bool initalDisplayMap;

  @override
  State<ToolBar> createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  // bool displayMap = true;

  @override
  void initState() {
    super.initState();
    // displayMap = widget.initalDisplayMap;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildContainer(
          child: Text(
            '${widget.numProduct} sản phẩm',
            style: AppBloc.applicationCubit.appTextStyle.normalBold,
          ),
        ),
        const Expanded(child: SizedBox()),
        _buildContainer(
          child: Row(
            children: [
              Image.asset(AppIcons.list_mode_new, width: 20),
              const SizedBox(width: 15),
              FlutterSwitch(
                width: 46,
                height: 25,
                toggleSize: 25,
                padding: 1,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.primary,
                value: widget.initalDisplayMap,
                onToggle: (value) {
                  widget.onSwitchViewMode.call(value);
                },
              ),
              const SizedBox(width: 15),
              Image.asset(AppIcons.map_mode_new, width: 25),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContainer({required Widget child}) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}


// class ToolBar extends StatelessWidget {
//   const ToolBar({
//     Key? key,
//     required this.voidCallbackFilter,
//     required this.voidCallbackListMode,
//     required this.voidCallbackMapMode,
//     required this.voidCallbackNotApprovedList,
//     required this.voidCallbackHiddenList,
//     required this.notAprrovedOnly,
//     required this.hiddenOnly,
//     required this.numProduct,
//     required this.mapSelected,
//   }) : super(key: key);

//   final VoidCallback voidCallbackFilter;
//   final VoidCallback voidCallbackListMode;
//   final VoidCallback voidCallbackMapMode;
//   final VoidCallback voidCallbackNotApprovedList;
//   final VoidCallback voidCallbackHiddenList;
//   final bool notAprrovedOnly;
//   final bool hiddenOnly;
//   final int numProduct;
//   final bool mapSelected;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           '$numProduct sp',
//           style: AppBloc.applicationCubit.appTextStyle.normalBold,
//         ),
//         const SizedBox(width: 20),
//         ToolButton(
//           iconPath: AppIcons.filter,
//           voidCallback: voidCallbackFilter,
//         ),
//         if (AppBloc.authenticationCubit.isSuperAdmin != true) ...[
//           // CheckboxCustom(
//           //   title: 'Chưa duyệt',
//           //   onTap: voidCallbackNotApprovedList,
//           //   value: notAprrovedOnly,
//           // )
//           const SizedBox(width: 20),
//           InkWell(
//             splashColor: Colors.white,
//             highlightColor: Colors.white,
//             onTap: voidCallbackNotApprovedList,
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.boxBorder),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: (notAprrovedOnly == true)
//                   ? const Icon(Icons.library_add_check, color: Color(0xFF374957))
//                   : const Icon(Icons.check_box_outline_blank, color: Color(0xFF374957)),
//             ),
//           ),
//         ],
//         if (AppBloc.authenticationCubit.isAdminLogin == true) ...[
//           const SizedBox(width: 20),
//           Tooltip(
//               message: 'I am a Tooltip',
//               child: InkWell(
//                 splashColor: Colors.white,
//                 highlightColor: Colors.white,
//                 onTap: voidCallbackHiddenList,
//                 child: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: AppColors.boxBorder),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: (hiddenOnly == true)
//                       ? const Icon(Icons.visibility, color: Color(0xFF374957))
//                       : const Icon(Icons.visibility_off, color: Color(0xFF374957)),
//                 ),
//               )),
//         ],
//         const Expanded(child: SizedBox()),
//         ToolButton(
//           iconPath: AppIcons.list_mode,
//           isSelected: !mapSelected,
//           voidCallback: voidCallbackListMode,
//         ),
//         const SizedBox(width: 8),
//         ToolButton(
//           iconPath: AppIcons.map_mode,
//           isSelected: mapSelected,
//           voidCallback: voidCallbackMapMode,
//         ),
//       ],
//     );
//   }
// }
