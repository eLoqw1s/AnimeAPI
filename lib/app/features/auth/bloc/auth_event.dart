part of "auth_bloc.dart";

sealed class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  const SignUpRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LogInRequested extends AuthEvent {
  final String email;
  final String password;

  const LogInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LogOutRequested extends AuthEvent {}

class ResetAuth extends AuthEvent {}
