import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_data_model.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WidgetRealEstateMapView extends StatelessWidget {
  const WidgetRealEstateMapView({Key? key, required this.productData, this.callback}) : super(key: key);

  final VoidCallback? callback;
  final RealEstateDataModel productData;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Padding(
          padding: EdgeInsets.only(bottom: 80, left: 35, right: 35),
          child: InkWell(
            splashColor: Colors.white,
            onTap: callback,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    offset: const Offset(4, 4),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Stack(children: [
                        ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                            child: (productData.images != null && productData.images!.isNotEmpty && productData.images![0].url != null)
                                ? AspectRatio(
                                    aspectRatio: 2,
                                    child: CachedNetworkImage(
                                      imageUrl: productData.images![0].url!,
                                      imageBuilder: (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            // colorFilter: const ColorFilter.mode(
                                            //   Colors.red,
                                            //   BlendMode.colorBurn,
                                            // ),
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => Image.asset(
                                        'assets/images/no-image.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : AspectRatio(
                                    aspectRatio: 2,
                                    child: Image.asset(
                                      'assets/images/no-image.png',
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                        Positioned(
                          left: 5,
                          bottom: 5,
                          child: Container(
                            padding: EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
                            decoration: BoxDecoration(
                              color: UtilCommon.getColorByKind(productData!.kind!.id!),
                              // border:
                              //     Border.all(color: AppColors.boxBorder),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              productData!.kind!.name ?? '',
                              textAlign: TextAlign.left,
                              style:
                                  AppBloc.applicationCubit.appTextStyle.normal.copyWith(color: UtilCommon.getTextColorByKind(productData!.kind!.id!)),
                            ),
                          ),
                        ),
                      ]),
                      Container(
                        color: AppColors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Text(productData.title ?? '',
                                              textAlign: TextAlign.left, style: AppBloc.applicationCubit.appTextStyle.largeBold)),
                                      Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Image.asset(AppIcons.location, width: 17),
                                              const SizedBox(width: 5),
                                              Expanded(
                                                  child: Text(
                                                '${productData.address ?? ''} ${productData.wards!.name ?? ''} \n${productData.district!.name ?? ''} ${productData.province!.name ?? ''}',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                                              )),
                                            ],
                                          )),
                                      Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                  child: Row(
                                                children: [
                                                  Image.asset(AppIcons.comission, width: 17),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    '${UtilCommon.getPriceDisplayStr(productData.totalPrice)}',
                                                    style: AppBloc.applicationCubit.appTextStyle.normal,
                                                  )
                                                ],
                                              )),
                                              Expanded(
                                                  child: Row(children: [
                                                Image.asset(AppIcons.clock, width: 17),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${UtilDateTime.formatDateTime(productData.createdAt)}',
                                                  style: AppBloc.applicationCubit.appTextStyle.normal,
                                                )
                                              ])),
                                              Expanded(
                                                  child: Row(children: [
                                                Image.asset(AppIcons.area, width: 17),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${productData.area ?? ''} m2',
                                                  style: AppBloc.applicationCubit.appTextStyle.normal,
                                                )
                                              ]))
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ))
    ]);
  }
}
