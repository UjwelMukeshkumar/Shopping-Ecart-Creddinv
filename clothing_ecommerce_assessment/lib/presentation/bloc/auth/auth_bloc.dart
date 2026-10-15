import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/authenticate_user.dart';
import '../../../domain/usecases/logout_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authenticate, this.logoutUser) : super(const AuthFormState()) {
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
  }

  final AuthenticateUser authenticate;
  final LogoutUser logoutUser;

  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static const String _emailErrorText = 'Enter a valid email address';
  static const String _passwordErrorText =
      'Password must contain at least 8 characters';

  AuthFormState get _formState =>
      state is AuthFormState ? state as AuthFormState : const AuthFormState();

  String? _emailError(String email) {
    final trimmed = email.trim();
    return trimmed.isEmpty || !_emailRegex.hasMatch(trimmed)
        ? _emailErrorText
        : null;
  }

  String? _passwordError(String password) =>
      password.length < 8 ? _passwordErrorText : null;

  void _onLoginEmailChanged(LoginEmailChanged event, Emitter<AuthState> emit) {
    final current = _formState;
    final email = event.email;
    emit(current.copyWith(
      email: email,
      emailError: _emailError(email),
      status: AuthStatus.idle,
      clearMessage: true,
    ));
  }

  void _onLoginPasswordChanged(
      LoginPasswordChanged event, Emitter<AuthState> emit) {
    final current = _formState;
    final password = event.password;
    emit(current.copyWith(
      password: password,
      passwordError: _passwordError(password),
      status: AuthStatus.idle,
      clearMessage: true,
    ));
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<AuthState> emit) async {
    final current = _formState;
    final emailError = _emailError(current.email);
    final passwordError = _passwordError(current.password);

    if (emailError != null || passwordError != null) {
      emit(current.copyWith(
        emailError: emailError,
        passwordError: passwordError,
        status: AuthStatus.failure,
        message: 'Please correct the highlighted fields',
      ));
      return;
    }

    emit(current.copyWith(status: AuthStatus.submitting, clearMessage: true));
    try {
      final success = await authenticate(current.email, current.password);
      emit(success
          ? current.copyWith(status: AuthStatus.success, clearMessage: true)
          : current.copyWith(
              status: AuthStatus.failure,
              message: 'Incorrect email or password',
            ));
    } catch (_) {
      emit(current.copyWith(
        status: AuthStatus.failure,
        message: 'Login failed. Please try again.',
      ));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    final current = _formState;
    emit(current.copyWith(status: AuthStatus.submitting, clearMessage: true));
    try {
      await logoutUser();
      emit(const AuthFormState(status: AuthStatus.loggedOut));
    } catch (_) {
      emit(current.copyWith(
        status: AuthStatus.failure,
        message: 'Logout failed. Please try again.',
      ));
    }
  }
}
