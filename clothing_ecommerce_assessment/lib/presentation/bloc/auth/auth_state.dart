import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthFormState extends AuthState {
  const AuthFormState(
      {this.email = '',
      this.password = '',
      this.emailError,
      this.passwordError,
      this.status = AuthStatus.idle,
      this.message});
  final String email, password;
  final String? emailError, passwordError, message;
  final AuthStatus status;
  bool get canSubmit => _validEmail(email) && password.length >= 8;
  static bool _validEmail(String value) =>
      RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim());
  AuthFormState copyWith(
          {String? email,
          String? password,
          String? emailError,
          String? passwordError,
          AuthStatus? status,
          String? message,
          bool clearMessage = false}) =>
      AuthFormState(
          email: email ?? this.email,
          password: password ?? this.password,
          emailError: emailError,
          passwordError: passwordError,
          status: status ?? this.status,
          message: clearMessage ? null : message ?? this.message);
  @override
  List<Object?> get props =>
      [email, password, emailError, passwordError, status, message];
}

enum AuthStatus { idle, submitting, success, failure, loggedOut }
