import 'package:bloc/bloc.dart';
import 'app_container_menber_state.dart';

class AppContainerMemberCubit extends Cubit<AppContainerMemberState> {
  AppContainerMemberCubit() : super(AppContainerMemberState());

  void onSelectBottomTab(AppBottomTabMember bottomTab) {
    emit(state.copyWith(bottomTab: bottomTab));
  }

  void reset() {
    emit(state.copyWith(bottomTab: AppBottomTabMember.search));
  }
}
