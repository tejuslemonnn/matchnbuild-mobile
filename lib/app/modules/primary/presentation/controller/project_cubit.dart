import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/project_request_model.dart';
import 'package:mnb_mobile/app/modules/primary/domain/usecase/primary_use_cases.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';

class ProjectState extends Equatable {
  final ViewStatus status;
  final List<ProjectRequestModel> requests;
  final String message;

  const ProjectState({
    this.status = ViewStatus.initial,
    this.requests = const [],
    this.message = '',
  });

  /// Requests with an unresolved status (open / quoted / waiting).
  List<ProjectRequestModel> get active => requests
      .where((r) => r.status == 'open' || r.status == 'quoted')
      .toList();

  /// Accepted / completed requests.
  List<ProjectRequestModel> get done => requests
      .where((r) => r.status == 'accepted' || r.status == 'completed')
      .toList();

  /// Rejected / cancelled requests.
  List<ProjectRequestModel> get canceled => requests
      .where((r) => r.status == 'rejected' || r.status == 'canceled')
      .toList();

  ProjectState copyWith({
    ViewStatus? status,
    List<ProjectRequestModel>? requests,
    String? message,
  }) {
    return ProjectState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, requests, message];
}

class ProjectCubit extends Cubit<ProjectState> {
  final GetMyRequestsUseCase _getMyRequests;

  ProjectCubit(this._getMyRequests) : super(const ProjectState());

  Future<void> load() async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _getMyRequests();
    result.fold(
      (failure) => emit(state.copyWith(
        status: ViewStatus.failure,
        message: failure.getError(),
      )),
      (requests) => emit(state.copyWith(
        status: ViewStatus.success,
        requests: requests,
      )),
    );
  }
}
