import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnb_mobile/app/modules/primary/data/datasource/primary_remote_datasource.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/project_request_model.dart';
import 'package:mnb_mobile/app/modules/primary/domain/usecase/primary_use_cases.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';

class ProjectRequestFormState extends Equatable {
  final ViewStatus status;
  final ProjectRequestModel? created;
  final String message;

  const ProjectRequestFormState({
    this.status = ViewStatus.initial,
    this.created,
    this.message = '',
  });

  ProjectRequestFormState copyWith({
    ViewStatus? status,
    ProjectRequestModel? created,
    String? message,
  }) {
    return ProjectRequestFormState(
      status: status ?? this.status,
      created: created ?? this.created,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, created, message];
}

class ProjectRequestFormCubit extends Cubit<ProjectRequestFormState> {
  final CreateProjectRequestUseCase _createProjectRequest;

  ProjectRequestFormCubit(this._createProjectRequest)
      : super(const ProjectRequestFormState());

  Future<void> submit(CreateProjectRequest request) async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _createProjectRequest(request);
    result.fold(
      (failure) => emit(state.copyWith(
        status: ViewStatus.failure,
        message: failure.getError(),
      )),
      (created) => emit(state.copyWith(
        status: ViewStatus.success,
        created: created,
      )),
    );
  }
}
