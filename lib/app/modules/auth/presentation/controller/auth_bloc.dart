import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnb_mobile/app/modules/auth/domain/usecase/login_use_case.dart';
import 'package:mnb_mobile/app/modules/auth/domain/usecase/logout_use_case.dart';
import 'package:mnb_mobile/app/modules/auth/domain/usecase/register_use_case.dart';

// Events
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String role;

  RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
    this.role = 'client',
  });
}

class LogoutEvent extends AuthEvent {}

// States
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String accessToken;

  AuthSuccess(this.accessToken);
}

class RegisterSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final RegisterUseCase _registerUseCase;

  AuthBloc(this._loginUseCase, this._logoutUseCase, this._registerUseCase)
      : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final result = await _registerUseCase(
        RegisterParams(
          name: event.name,
          email: event.email,
          password: event.password,
          role: event.role,
        ),
      );

      result.fold(
        (failure) => emit(AuthFailure(failure.getError())),
        (_) => emit(RegisterSuccess()),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
        print(stackTrace);
      }
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final result = await _loginUseCase(
        LoginParams(email: event.email, password: event.password),
      );

      result.fold(
        (failure) => emit(AuthFailure(failure.getError())),
        (tokenAuth) => emit(AuthSuccess(tokenAuth.token)),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
        print(stackTrace);
      }
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await _logoutUseCase();
    emit(AuthInitial());
  }
}
