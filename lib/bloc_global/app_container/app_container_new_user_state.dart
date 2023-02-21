import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppContainerNewUserState extends Equatable {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final ApiCallStatus? apiCallStatus;
  final bool? hasUnApprovedSubcription;
  final bool? showNotBelongToAnyGroup;

  AppContainerNewUserState(
      {this.apiCallStatus,
      this.hasUnApprovedSubcription,
      this.showNotBelongToAnyGroup});

  @override
  List<Object?> get props =>
      [apiCallStatus, hasUnApprovedSubcription, showNotBelongToAnyGroup];

  AppContainerNewUserState copyWith(
      {ApiCallStatus? apiCallStatus,
      bool? hasUnApprovedSubcription,
      bool? showNotBelongToAnyGroup}) {
    return AppContainerNewUserState(
        apiCallStatus: apiCallStatus ?? this.apiCallStatus,
        hasUnApprovedSubcription:
            hasUnApprovedSubcription ?? this.hasUnApprovedSubcription,
        showNotBelongToAnyGroup:
            showNotBelongToAnyGroup ?? this.showNotBelongToAnyGroup);
  }
}
