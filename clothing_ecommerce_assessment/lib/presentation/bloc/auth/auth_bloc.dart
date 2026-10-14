import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/authenticate_user.dart';
import '../../../domain/usecases/logout_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authenticate, this.logoutUser) : super(const AuthFormState()) {
    on<LoginEmailChanged>((event, emit) {
      final current = state is AuthFormState
          ? state as AuthFormState
          : const AuthFormState();
      final email = event.email.trim();
      emit(current.copyWith(
          email: event.email,
          emailError: email.isEmpty ||
                  !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)
              ? 'Enter a valid email address'
              : null,
          status: AuthStatus.idle,
          clearMessage: true));
    });
    on<LoginPasswordChanged>((event, emit) {
      final current = state is AuthFormState
          ? state as AuthFormState
          : const AuthFormState();
      emit(current.copyWith(
          password: event.password,
          passwordError: event.password.length < 8
              ? 'Password must contain at least 8 characters'
              : null,
          status: AuthStatus.idle,
          clearMessage: true));
    });
    on<LoginSubmitted>((event, emit) async {
      final current = state is AuthFormState
          ? state as AuthFormState
          : const AuthFormState();
      final emailError =
          RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(current.email.trim())
              ? null
              : 'Enter a valid email address';
      final passwordError = current.password.length >= 8
          ? null
          : 'Password must contain at least 8 characters';
      if (emailError != null || passwordError != null) {
        emit(current.copyWith(
            emailError: emailError,
            passwordError: passwordError,
            status: AuthStatus.failure,
            message: 'Please correct the highlighted fields'));
        return;
      }
      emit(current.copyWith(status: AuthStatus.submitting, clearMessage: true));
      try {
        final success = await authenticate(current.email, current.password);
        if (success) {
          emit(
              current.copyWith(status: AuthStatus.success, clearMessage: true));
        } else {
          emit(current.copyWith(
              status: AuthStatus.failure,
              message: 'Incorrect email or password'));
        }
      } catch (_) {
        emit(current.copyWith(
            status: AuthStatus.failure,
            message: 'Login failed. Please try again.'));
      }
    });
    on<LogoutRequested>((event, emit) async {
      final current = state is AuthFormState
          ? state as AuthFormState
          : const AuthFormState();
      emit(current.copyWith(status: AuthStatus.submitting, clearMessage: true));
      try {
        await logoutUser();
        emit(const AuthFormState(status: AuthStatus.loggedOut));
      } catch (_) {
        emit(current.copyWith(
            status: AuthStatus.failure,
            message: 'Logout failed. Please try again.'));
      }
    });
  }
  final AuthenticateUser authenticate;
  final LogoutUser logoutUser;
}
