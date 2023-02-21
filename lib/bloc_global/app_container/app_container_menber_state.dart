import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum AppBottomTabMember {
  search,
  groupInfo,
}

class AppContainerMemberState extends Equatable {
  final AppBottomTabMember bottomTab;

  AppContainerMemberState({this.bottomTab = AppBottomTabMember.search});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  List<Object?> get props => [bottomTab];

  AppContainerMemberState copyWith({AppBottomTabMember? bottomTab}) {
    return AppContainerMemberState(
      bottomTab: bottomTab ?? this.bottomTab,
    );
  }
}
