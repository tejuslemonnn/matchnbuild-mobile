part of 'app_controller_bloc.dart';

class AppControllerState {
  final AppThemeMode appThemeMode;
  final bool isLoading;
  final bool isAuthenticated;
  final bool splashCompleted;
  final String? errorMessage;

  const AppControllerState({
    required this.appThemeMode,
    required this.isLoading,
    this.isAuthenticated = false,
    this.splashCompleted = false,
    this.errorMessage,
  });

  factory AppControllerState.initial() => const AppControllerState(
    appThemeMode: AppThemeMode.system,
    isLoading: false,
    isAuthenticated: false,
    splashCompleted: false,
  );

  AppControllerState copyWith({
    AppThemeMode? appThemeMode,
    bool? isLoading,
    bool? isAuthenticated,
    bool? splashCompleted,
    String? errorMessage,
  }) {
    return AppControllerState(
      appThemeMode: appThemeMode ?? this.appThemeMode,
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      splashCompleted: splashCompleted ?? this.splashCompleted,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppControllerState &&
          runtimeType == other.runtimeType &&
          appThemeMode == other.appThemeMode &&
          isLoading == other.isLoading &&
          isAuthenticated == other.isAuthenticated &&
          splashCompleted == other.splashCompleted &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode =>
      appThemeMode.hashCode ^
      isLoading.hashCode ^
      isAuthenticated.hashCode ^
      splashCompleted.hashCode ^
      errorMessage.hashCode;
}
