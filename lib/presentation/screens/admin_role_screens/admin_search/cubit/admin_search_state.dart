import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:equatable/equatable.dart';

class AdminSearchState extends Equatable {
  final ApiCallStatus? apiCallStatus;

  const AdminSearchState({
    this.apiCallStatus,
  });

  @override
  List<Object?> get props => [
        apiCallStatus,
      ];

  AdminSearchState copyWith({
    ApiCallStatus? apiCallStatus,
  }) {
    return AdminSearchState(
      apiCallStatus: apiCallStatus ?? this.apiCallStatus,
    );
  }
}
