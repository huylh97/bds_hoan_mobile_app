import 'package:equatable/equatable.dart';

enum RegisterLoadingStatus { init, loading }

class RegisterState extends Equatable {
  final String? phone;
  final String? name;
  final String? password;
  final String? confirmPassword;
  final RegisterLoadingStatus? loadingStatus;
  final bool confirmPrivacy;

  const RegisterState({
    this.phone,
    this.name,
    this.password,
    this.confirmPassword,
    this.loadingStatus,
    this.confirmPrivacy = false,
  });

  @override
  List<dynamic> get props => [phone, name, password, confirmPassword, loadingStatus, confirmPrivacy];

  RegisterState copyWith({
    String? phone,
    String? name,
    String? password,
    String? confirmPassword,
    RegisterLoadingStatus? loadingStatus,
    bool? confirmPrivacy,
  }) {
    return RegisterState(
      phone: phone ?? this.phone,
      name: name ?? this.name,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      confirmPrivacy: confirmPrivacy ?? this.confirmPrivacy,
    );
  }
}
