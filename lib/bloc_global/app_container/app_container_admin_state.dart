import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum AppBottomTabAdmin {
  notification,
  manageUser,
  manageBDS,
}

class AppContainerAdminState extends Equatable {
  final ApiCallStatus? apiCallStatus;
  final AppBottomTabAdmin bottomTab;
  final int? numNotifications;

  AppContainerAdminState(
      {this.apiCallStatus,
      this.bottomTab = AppBottomTabAdmin.manageBDS,
      this.numNotifications});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  List<Object?> get props => [apiCallStatus, bottomTab, numNotifications];

  AppContainerAdminState copyWith(
      {ApiCallStatus? apiCallStatus,
      AppBottomTabAdmin? bottomTab,
      int? numNotifications}) {
    return AppContainerAdminState(
      apiCallStatus: apiCallStatus ?? this.apiCallStatus,
      bottomTab: bottomTab ?? this.bottomTab,
      numNotifications: numNotifications ?? this.numNotifications,
    );
  }
}
