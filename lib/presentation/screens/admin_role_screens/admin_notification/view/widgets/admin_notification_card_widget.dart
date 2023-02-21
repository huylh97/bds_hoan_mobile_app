import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/models/notification/notification_data.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_data_model.dart';
import 'package:bds_hoan_mobile/data/models/subcription/subscription_user_data.dart';
import 'package:bds_hoan_mobile/presentation/screens/admin_role_screens/admin_notification/cubit/admin_notification_cubit.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_view_info/view/real_estate_view_info_screen.dart';
import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_manage_list/cubit/subcription_manage_list_cubit.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WidgetAdminNotificationCard extends StatelessWidget {
  const WidgetAdminNotificationCard({Key? key, required this.cubit, required this.data, this.callback}) : super(key: key);

  final AdminNotificationCubit cubit;
  final VoidCallback? callback;
  final NotificationData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: data.seen == true ? Colors.white : Color.fromARGB(255, 204, 226, 236)),
      padding: const EdgeInsets.only(left: 0, right: 0, top: 16, bottom: 16),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: callback,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 33.0,
                    child: CircleAvatar(
                        radius: 31.0,
                        child: ClipOval(
                            child: CachedNetworkImage(
                          imageUrl: (data.user!.photo != null && data.user!.photo! != '') ? data.user!.photo! : AppConstant.defaltAvatarUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Container(),
                        )))),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.title ?? '',
                        style: data.seen == true ? AppBloc.applicationCubit.appTextStyle.normal : AppBloc.applicationCubit.appTextStyle.normalBold,
                        overflow: TextOverflow.visible,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        UtilDateTime.formatDateTime(data.createdAt),
                        style:
                            AppBloc.applicationCubit.appTextStyle.small.copyWith(fontSize: AppBloc.applicationCubit.appTextStyle.small.fontSize! - 1),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (data.image != null && data.image!.isNotEmpty) ...[
                  const SizedBox(width: 15),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.boxBorder),
                      borderRadius: BorderRadius.circular(5),
                      // color: AppColors.white,
                    ),
                    margin: const EdgeInsets.only(left: 0, right: 0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: InkWell(
                            onTap: () {},
                            child: CachedNetworkImage(
                              imageUrl: data.image ?? '',
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
                            ))),
                  ),
                ],
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward, size: 18),
                const SizedBox(width: 10),
              ],
            ),
            // const SizedBox(height: AppDimension.kSizedBoxHeight),
            // const DefaultDivider(),
          ],
        ),
      ),
    );
  }
}
