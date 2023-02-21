import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_data_model.dart';
import 'package:bds_hoan_mobile/data/models/subcription/subcription_info.dart';
import 'package:bds_hoan_mobile/data/repository/real_estate_repository.dart';
import 'package:bds_hoan_mobile/data/repository/subcription_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'subcription_selection_state.dart';

class SubcriptionSelectionCubit extends Cubit<SubcriptionSelectionState> {
  SubcriptionSelectionCubit() : super(SubcriptionSelectionState());

  Future<void> getSubscriptionInfo({bool enableLoading = true}) async {
    if (isClosed) {
      return;
    } else {
      if (enableLoading) {
        emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
      }

      final result = await SubcriptionRepository.getSubscriptionInfo();
      if (!isClosed && enableLoading)
        emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
      if (!isClosed) {
        if (result != null) {
          emit(state.copyWith(dataList: result));
        } else {
          emit(const SubcriptionSelectionState());
        }
      }
    }
  }
}
