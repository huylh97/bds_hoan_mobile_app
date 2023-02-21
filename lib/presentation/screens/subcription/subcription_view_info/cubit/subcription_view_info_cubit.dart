import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/bloc.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/enums/status.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_data_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_detail_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_status_update_model.dart';
import 'package:bds_hoan_mobile/data/models/subcription/subscription_user_data.dart';
import 'package:bds_hoan_mobile/data/repository/real_estate_repository.dart';
import 'package:bds_hoan_mobile/data/repository/subcription_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'subcription_view_info_state.dart';

class SubcriptionViewInfoCubit extends Cubit<SubcriptionViewInfoState> {
  SubcriptionViewInfoCubit() : super(const SubcriptionViewInfoState());

  Future<void> getSubcriptionDetailById(
      {bool enableLoading = true, required int subcriptionId}) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }

    final result =
        await SubcriptionRepository.getSubcriptionDetailById(subcriptionId);
    if (enableLoading) emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    if (result != null) {
      emit(state.copyWith(subcriptionDetail: result));
    } else {
      emit(const SubcriptionViewInfoState());
    }
  }

  Future<bool?> confirm({
    required int subcriptionId,
  }) async {
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));

    final result =
        await SubcriptionRepository.confirm(subcriptionId: subcriptionId);
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
    return result;
  }

  Future<bool?> lock({
    required int subcriptionId,
  }) async {
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));

    final result =
        await SubcriptionRepository.lock(subcriptionId: subcriptionId);
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
    return result;
  }

  Future<bool?> unlock({
    required int subcriptionId,
  }) async {
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));

    final result =
        await SubcriptionRepository.unlock(subcriptionId: subcriptionId);
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
    return result;
  }
}
