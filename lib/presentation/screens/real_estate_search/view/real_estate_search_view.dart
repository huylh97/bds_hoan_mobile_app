import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_data_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_filter_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_register_param.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_search/cubit/real_estate_search_state.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_search/view/widgets/add_product_modal.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_search/view/widgets/tool_button.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_search/view/widgets/widget_real_estate_map_view.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../cubit/real_estate_search_cubit.dart';
import 'widgets/add_product_intro.dart';
import 'widgets/tool_bar.dart';
import 'widgets/widget_real_estate_list_view.dart';
import 'widgets/main_app_bar.dart';

class RealEstateSearchView extends StatefulWidget {
  const RealEstateSearchView({
    Key? key,
  }) : super(key: key);

  @override
  State<RealEstateSearchView> createState() => _RealEstateSearchViewState();
}

class _RealEstateSearchViewState extends State<RealEstateSearchView> {
  late final RealEstateSearchCubit cubit;

  LatLng? currentLatLng;
  late bool displayMap = true;
  List<Marker> allMarkers = <Marker>[];
  BitmapDescriptor? iconAddNewPin;
  RealEstateDataModel? selectedData;
  bool mapTypeFlag = true;
  int zoomStatus = 0;
  late GoogleMapController _controller;

  @override
  void initState() {
    super.initState();
    allMarkers = <Marker>[];
    cubit = BlocProvider.of<RealEstateSearchCubit>(context);
    cubit.getListRealEstate();

    UtilGeolocator.getCurrentPosition().then((currLocation) {
      if (currLocation != null) {
        setState(() {
          currentLatLng = LatLng(currLocation.latitude, currLocation.longitude);
        });
      }
    });

    UtilCommon.getBytesFromAsset('assets/icons/map_pin_orange.png', 45).then((value) {
      iconAddNewPin = BitmapDescriptor.fromBytes(value);
    });
  }

  _handleTapGoogleMap(LatLng pos) {
    if (AppBloc.authenticationCubit.isSuperAdmin == true) {
      return;
    }
    if (iconAddNewPin == null) {
      return;
    }
    allMarkers.removeWhere((element) => element.mapsId.value == 'AddNew');

    final marker = Marker(
      markerId: MarkerId('AddNew'),
      icon: iconAddNewPin!,
      position: LatLng(pos.latitude, pos.longitude),
    );

    allMarkers.add(marker);
    setState(() {
      allMarkers = [...allMarkers];
      selectedData == null;
    });
    showMaterialModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => AddProductModal(
          cubit: cubit,
          pinPos: pos,
          callback: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, Routes.realEstateRegister,
                    arguments: RealEstateRegEditParam(
                        processMode: RealEstateProcessMode.register, inputType: RealEstateInputType.address, lat: pos.latitude, long: pos.longitude))
                .then((value) {
              setState(() {
                allMarkers = [];
                zoomStatus = 0;
              });
              cubit.getListRealEstate();
            });
          }),
    ).then((value) {
      allMarkers.removeWhere((element) => element.mapsId.value == 'AddNew');
      setState(() {
        allMarkers = [...allMarkers];
      });
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
          appBar: buildAppBar(
            context,
            () {
              setState(() {
                allMarkers = [];
                zoomStatus = 0;
              });

              cubit.getListRealEstate();
            },
          ),
          body: BlocBuilder<RealEstateSearchCubit, RealEstateSearchState>(builder: (context, state) {
            if (state.apiCallStatus == ApiCallStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (displayMap) {
              return Stack(
                children: [
                  _buildGoogleMapDisplay(context, state.displayDataList),
                  _buildTopToolBar(state, context),
                ],
              );
            }
            return Column(
              children: [
                _buildTopToolBar(state, context),
                state.displayDataList == null
                    ? const Padding(padding: EdgeInsets.only(left: 12, right: 12), child: AddProductIntro())
                    : Expanded(
                        child: ListView.builder(
                          itemCount: state.displayDataList!.length,
                          padding: const EdgeInsets.only(top: 8),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return WidgetRealEstateListView(
                              callback: () {
                                Navigator.pushNamed(context, Routes.realEstateViewInfo, arguments: state.displayDataList![index].id).then((value) {
                                  setState(() {
                                    allMarkers = [];
                                    zoomStatus = 0;
                                  });
                                  cubit.getListRealEstate();
                                });
                              },
                              productData: state.displayDataList![index],
                            );
                          },
                        ),
                      ),
              ],
            );
          }),
        ));
  }

  Widget _buildTopToolBar(RealEstateSearchState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimension.kScaffoldHorPadding,
        vertical: 10,
      ),
      child: ToolBar(
        initalDisplayMap: displayMap,
        onSwitchViewMode: (bool value) {
          setState(() {
            displayMap = value;
          });
        },
        numProduct: state.displayDataList != null ? state.displayDataList!.length : 0,
        voidCallbackFilter: () {
          Navigator.pushNamed(context, Routes.searchFilters, arguments: state.filterData).then((value) {
            RealEstateFilterModel filterData = value as RealEstateFilterModel;
            setState(() {
              allMarkers = [];
            });

            cubit.filter(filterData: filterData);
          });
        },
      ),
    );
  }

  Widget _buildGoogleMapDisplay(BuildContext context, List<RealEstateDataModel>? dataList) {
    Future<List<Marker>> generateMarkers(List<RealEstateDataModel>? dataList) async {
      if (dataList != null) {
        // allMarkers = [];
        for (final data in dataList) {
          final marker = Marker(
              visible: !((zoomStatus == 1) ||
                  ((dataList.indexOf(data) % 2 == 0) && zoomStatus == 2) ||
                  ((dataList.indexOf(data) % 4 == 0) && zoomStatus == 3)),
              markerId: MarkerId('${data.id}'),
              icon: await UtilCommon.bitmapDescriptorFromSvgAsset(
                  context,
                  data.kind!.id!,
                  data.status!,
                  UtilCommon.getPriceDisplayStr(data.squareMetrePrice),
                  UtilCommon.getPriceDisplayStr(data.widthMetrePrice),
                  UtilCommon.getPriceDisplayStr(data.totalPrice),
                  mapTypeFlag),
              onTap: () async {
                showMaterialModalBottomSheet(
                  expand: false,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => WidgetRealEstateMapView(
                      productData: data,
                      callback: () {
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, Routes.realEstateViewInfo, arguments: data.id).then((value) {
                          setState(() {
                            allMarkers = [];
                            zoomStatus = 0;
                          });
                          cubit.getListRealEstate();
                        });
                      }),
                ).then((value) {});
              },
              position: LatLng(data.lat!, data.long!));

          allMarkers.add(marker);
        }
      }

      return allMarkers;
    }

    return FutureBuilder(
        future: generateMarkers(dataList),
        initialData: Set.of(<Marker>[]),
        builder: (context, snapshot) => (currentLatLng == null || snapshot.data is! List<Marker>)
            ? const Center(child: CircularProgressIndicator())
            : Stack(children: [
                GoogleMap(
                    mapType: mapTypeFlag ? MapType.normal : MapType.satellite,
                    initialCameraPosition: CameraPosition(
                      target: currentLatLng!,
                      zoom: 12.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                    },
                    onTap: _handleTapGoogleMap,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    markers: Set.from(allMarkers),
                    onCameraMove: (CameraPosition cameraPosition) {
                      setState(() {
                        zoomStatus = 0;
                        if (cameraPosition.zoom < 8.5) {
                          zoomStatus = 1;
                        } else if (cameraPosition.zoom < 9.5) {
                          zoomStatus = 2;
                        } else if (cameraPosition.zoom < 10.5) {
                          zoomStatus = 3;
                        }
                      });
                    },
                    gestureRecognizers: Set()
                      ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                      ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
                      ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
                      ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer()))
                      ..add(Factory<HorizontalDragGestureRecognizer>(() => HorizontalDragGestureRecognizer()))),
                Positioned.fill(
                  bottom: 5,
                  left: 80,
                  right: 80,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(padding: EdgeInsets.all(0), child: Image.asset('assets/images/product_info_detail.png'))),
                ),
                if (selectedData != null) ...[
                  Positioned.fill(
                    bottom: 5,
                    left: 20,
                    right: 20,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: EdgeInsets.all(0),
                            child: WidgetRealEstateMapView(
                              productData: selectedData!,
                              callback: () {
                                setState(() {
                                  selectedData = null;
                                });
                              },
                            ))),
                  ),
                ],
                Positioned(
                    top: 10,
                    left: 10,
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: ToolButton(
                            iconPath: AppIcons.map_overlay,
                            isSelected: true,
                            voidCallback: () {
                              setState(() {
                                mapTypeFlag = !mapTypeFlag;
                              });
                            },
                          ),
                        ))),
              ]));
  }
}
