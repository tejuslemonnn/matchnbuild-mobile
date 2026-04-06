part of 'app_controller_bloc.dart';

sealed class AppControllerEvent {
  const AppControllerEvent();
}

class AppControllerStarted extends AppControllerEvent {
  const AppControllerStarted();
}

class AppControllerChangeTheme extends AppControllerEvent {
  const AppControllerChangeTheme();
}

class AppControllerUpdateLoading extends AppControllerEvent {
  final bool isLoading;
  const AppControllerUpdateLoading({required this.isLoading});
}
