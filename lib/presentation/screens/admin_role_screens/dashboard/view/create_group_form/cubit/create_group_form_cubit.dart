import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/message/bloc.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/group/create_group_params.dart';
import 'package:bds_hoan_mobile/data/models/group/group_model.dart';
import 'package:bds_hoan_mobile/data/repository/admin_repository.dart';
import 'package:bloc/bloc.dart';

import 'create_group_form_state.dart';

class CreateGroupFormCubit extends Cubit<CreateGroupFormState> {
  CreateGroupFormCubit() : super(const CreateGroupFormState());

  void initCubitState(GroupModel? groupModel) {
    emit(state.copyWith(isCompany: groupModel?.isEnterprise));
  }

  void onTapSave(ApiCallStatus value) {
    emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
  }

  void onToggleIsCompany() {
    emit(state.copyWith(isCompany: !state.isCompany));
  }

  Future<bool?> createGroup(CreateGroupParams params) async {
    emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    final result = await AdminRepository.createGroup(params);
    emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    return result;
  }

  Future<bool?> updateGroupInfo(CreateGroupParams params) async {
    emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    final result = await AdminRepository.updateGroupInfo(params);
    emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    return result;
  }
}
