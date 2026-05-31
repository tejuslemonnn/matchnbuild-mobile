import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mnb_mobile/app/modules/auth/data/local/datasource/auth_local_datasource.dart';
import 'package:mnb_mobile/models/theme/theme_data.dart';
import 'package:mnb_mobile/services/api.dart';

part 'app_controller_event.dart';
part 'app_controller_state.dart';

class AppControllerBloc extends Bloc<AppControllerEvent, AppControllerState> {
  final AuthLocalDatasource _authLocalDatasource;
  final DioClient _dioClient;

  AppControllerBloc(this._authLocalDatasource, this._dioClient)
      : super(AppControllerState.initial()) {
    on<AppControllerEvent>((event, emit) async {
      switch (event) {
        case AppControllerStarted():
          await Future.delayed(const Duration(seconds: 2));
          final token = await _authLocalDatasource.getToken();
          // Re-apply the stored access token to the shared client so that
          // authenticated requests work after a cold start.
          if (token != null) {
            _dioClient.setAuthToken(token.token);
          }
          emit(state.copyWith(
            isAuthenticated: token != null,
            splashCompleted: true,
          ));
        case AppControllerChangeTheme():
          AppThemeMode nextTheme = AppThemeMode.values[0];

          try {
            nextTheme = AppThemeMode.values[state.appThemeMode.index + 1];
          } catch (e) {
            nextTheme = AppThemeMode.values[0];
          }

          emit(state.copyWith(appThemeMode: nextTheme));
        case AppControllerUpdateLoading(:final isLoading):
          emit(state.copyWith(isLoading: isLoading));
      }
    });
  }

  ThemeMode get theme => state.appThemeMode.toThemeMode();
}
