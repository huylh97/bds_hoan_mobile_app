import 'package:equatable/equatable.dart';

enum LoginStateStatus { init, loading, signOut }

class LoginState extends Equatable {
  final String? email;
  final String? password;
  final LoginStateStatus? status;

  const LoginState({
    this.email,
    this.password,
    this.status,
  });

  @override
  List<Object?> get props => [email, password, status];

  LoginState copyWith({String? email, String? password, LoginStateStatus? status}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
