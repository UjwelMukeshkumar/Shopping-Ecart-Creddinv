import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class LoginEmailChanged extends AuthEvent {
  const LoginEmailChanged(this.email);
  final String email;
  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends AuthEvent {
  const LoginPasswordChanged(this.password);
  final String password;
  @override
  List<Object?> get props => [password];
}

class LoginSubmitted extends AuthEvent {
  const LoginSubmitted();
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}
