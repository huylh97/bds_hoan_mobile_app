import 'package:bds_hoan_mobile/data/models/user/user_model.dart';
import 'package:equatable/equatable.dart';

enum ChangePasswordLoadingStatus { init, loading }

class ChangePasswordState extends Equatable {
  final ChangePasswordLoadingStatus? loadingStatus;

  const ChangePasswordState({
    this.loadingStatus,
  });

  @override
  List<Object?> get props => [loadingStatus];

  ChangePasswordState copyWith({
    ChangePasswordLoadingStatus? loadingStatus,
    UserModel? userModel,
  }) {
    return ChangePasswordState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
