import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnb_mobile/app/modules/primary/data/datasource/primary_remote_datasource.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/preference_model.dart';
import 'package:mnb_mobile/app/modules/primary/domain/usecase/primary_use_cases.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';

class PreferencesState extends Equatable {
  final ViewStatus status;
  final PreferenceModel? preference;
  final String message;

  /// True once a create/update call succeeds — pages listen to this to
  /// navigate forward.
  final bool saved;

  const PreferencesState({
    this.status = ViewStatus.initial,
    this.preference,
    this.message = '',
    this.saved = false,
  });

  PreferencesState copyWith({
    ViewStatus? status,
    PreferenceModel? preference,
    String? message,
    bool? saved,
  }) {
    return PreferencesState(
      status: status ?? this.status,
      preference: preference ?? this.preference,
      message: message ?? this.message,
      saved: saved ?? this.saved,
    );
  }

  @override
  List<Object?> get props => [status, preference, message, saved];
}

class PreferencesCubit extends Cubit<PreferencesState> {
  final GetMyPreferencesUseCase _getMyPreferences;
  final CreatePreferencesUseCase _createPreferences;
  final UpdatePreferencesUseCase _updatePreferences;

  PreferencesCubit(
    this._getMyPreferences,
    this._createPreferences,
    this._updatePreferences,
  ) : super(const PreferencesState());

  Future<void> load() async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _getMyPreferences();
    result.fold(
      (failure) => emit(state.copyWith(
        status: ViewStatus.failure,
        message: failure.getError(),
      )),
      (preference) => emit(state.copyWith(
        status: ViewStatus.success,
        preference: preference,
      )),
    );
  }

  Future<void> create(CreatePreferenceRequest request) async {
    emit(state.copyWith(status: ViewStatus.loading, saved: false));
    final result = await _createPreferences(request);
    result.fold(
      (failure) => emit(state.copyWith(
        status: ViewStatus.failure,
        message: failure.getError(),
      )),
      (preference) => emit(state.copyWith(
        status: ViewStatus.success,
        preference: preference,
        saved: true,
      )),
    );
  }

  Future<void> update(UpdatePreferenceRequest request) async {
    emit(state.copyWith(status: ViewStatus.loading, saved: false));
    final result = await _updatePreferences(request);
    result.fold(
      (failure) => emit(state.copyWith(
        status: ViewStatus.failure,
        message: failure.getError(),
      )),
      (preference) => emit(state.copyWith(
        status: ViewStatus.success,
        preference: preference,
        saved: true,
      )),
    );
  }
}
