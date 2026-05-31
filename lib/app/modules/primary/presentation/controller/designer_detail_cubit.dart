import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/designer_model.dart';
import 'package:mnb_mobile/app/modules/primary/domain/usecase/primary_use_cases.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';

class DesignerDetailState extends Equatable {
  final ViewStatus status;
  final DesignerModel? designer;
  final String message;

  const DesignerDetailState({
    this.status = ViewStatus.initial,
    this.designer,
    this.message = '',
  });

  DesignerDetailState copyWith({
    ViewStatus? status,
    DesignerModel? designer,
    String? message,
  }) {
    return DesignerDetailState(
      status: status ?? this.status,
      designer: designer ?? this.designer,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, designer, message];
}

class DesignerDetailCubit extends Cubit<DesignerDetailState> {
  final GetDesignerByIdUseCase _getDesignerById;

  DesignerDetailCubit(this._getDesignerById)
      : super(const DesignerDetailState());

  Future<void> load(String id) async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _getDesignerById(id);
    result.fold(
      (failure) => emit(state.copyWith(
        status: ViewStatus.failure,
        message: failure.getError(),
      )),
      (designer) => emit(state.copyWith(
        status: ViewStatus.success,
        designer: designer,
      )),
    );
  }
}
