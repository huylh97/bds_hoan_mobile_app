import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:equatable/equatable.dart';

class CreateGroupFormState extends Equatable {
  final ApiCallStatus apiCallStatus;
  final bool isCompany;

  const CreateGroupFormState({
    this.apiCallStatus = ApiCallStatus.init,
    this.isCompany = false,
  });

  @override
  List<Object?> get props => [
        apiCallStatus,
        isCompany,
      ];

  CreateGroupFormState copyWith({
    ApiCallStatus? apiCallStatus,
    bool? isCompany,
  }) {
    return CreateGroupFormState(
      apiCallStatus: apiCallStatus ?? this.apiCallStatus,
      isCompany: isCompany ?? this.isCompany,
    );
  }
}
