import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/quotation_model.dart';
import 'package:mnb_mobile/app/modules/primary/domain/usecase/primary_use_cases.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';

class QuotationState extends Equatable {
  final ViewStatus status;
  final QuotationModel? quotation;

  /// Set after a successful accept call.
  final QuotationAcceptModel? accepted;

  /// True once a reject call completes successfully.
  final bool rejected;

  /// Tracks the accept/reject action independently from the initial load.
  final ViewStatus actionStatus;

  final String message;

  const QuotationState({
    this.status = ViewStatus.initial,
    this.quotation,
    this.accepted,
    this.rejected = false,
    this.actionStatus = ViewStatus.initial,
    this.message = '',
  });

  QuotationState copyWith({
    ViewStatus? status,
    QuotationModel? quotation,
    QuotationAcceptModel? accepted,
    bool? rejected,
    ViewStatus? actionStatus,
    String? message,
  }) {
    return QuotationState(
      status: status ?? this.status,
      quotation: quotation ?? this.quotation,
      accepted: accepted ?? this.accepted,
      rejected: rejected ?? this.rejected,
      actionStatus: actionStatus ?? this.actionStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props =>
      [status, quotation, accepted, rejected, actionStatus, message];
}

class QuotationCubit extends Cubit<QuotationState> {
  final GetQuotationByIdUseCase _getQuotationById;
  final AcceptQuotationUseCase _acceptQuotation;
  final RejectQuotationUseCase _rejectQuotation;

  QuotationCubit(
    this._getQuotationById,
    this._acceptQuotation,
    this._rejectQuotation,
  ) : super(const QuotationState());

  Future<void> load(String id) async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _getQuotationById(id);
    result.fold(
      (failure) => emit(state.copyWith(
        status: ViewStatus.failure,
        message: failure.getError(),
      )),
      (quotation) => emit(state.copyWith(
        status: ViewStatus.success,
        quotation: quotation,
      )),
    );
  }

  Future<void> accept(String id) async {
    emit(state.copyWith(actionStatus: ViewStatus.loading));
    final result = await _acceptQuotation(id);
    result.fold(
      (failure) => emit(state.copyWith(
        actionStatus: ViewStatus.failure,
        message: failure.getError(),
      )),
      (accepted) => emit(state.copyWith(
        actionStatus: ViewStatus.success,
        accepted: accepted,
      )),
    );
  }

  Future<void> reject(String id) async {
    emit(state.copyWith(actionStatus: ViewStatus.loading));
    final result = await _rejectQuotation(id);
    result.fold(
      (failure) => emit(state.copyWith(
        actionStatus: ViewStatus.failure,
        message: failure.getError(),
      )),
      (_) => emit(state.copyWith(
        actionStatus: ViewStatus.success,
        rejected: true,
      )),
    );
  }
}
