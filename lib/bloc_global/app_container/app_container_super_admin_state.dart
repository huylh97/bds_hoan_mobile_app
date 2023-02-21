import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum AppBottomTabSuperAdmin {
  manageSubcription,
  manageBDS,
  exportExcel,
}

class AppContainerSuperAdminState extends Equatable {
  final AppBottomTabSuperAdmin bottomTab;

  AppContainerSuperAdminState({
    this.bottomTab = AppBottomTabSuperAdmin.manageSubcription,
  });

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  List<Object?> get props => [bottomTab];

  AppContainerSuperAdminState copyWith(
      {AppBottomTabSuperAdmin? bottomTab, int? numNotApproved}) {
    return AppContainerSuperAdminState(
      bottomTab: bottomTab ?? this.bottomTab,
    );
  }
}
