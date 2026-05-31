import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/design_item_model.dart';
import 'package:mnb_mobile/app/modules/primary/domain/usecase/primary_use_cases.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';

class DesignDetailState extends Equatable {
  final ViewStatus status;
  final DesignItemModel? item;
  final String message;

  const DesignDetailState({
    this.status = ViewStatus.initial,
    this.item,
    this.message = '',
  });

  DesignDetailState copyWith({
    ViewStatus? status,
    DesignItemModel? item,
    String? message,
  }) {
    return DesignDetailState(
      status: status ?? this.status,
      item: item ?? this.item,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, item, message];
}

class DesignDetailCubit extends Cubit<DesignDetailState> {
  final GetDesignItemByIdUseCase _getDesignItemById;

  DesignDetailCubit(this._getDesignItemById) : super(const DesignDetailState());

  Future<void> load(String id) async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _getDesignItemById(id);
    result.fold(
      (failure) => emit(state.copyWith(
        status: ViewStatus.failure,
        message: failure.getError(),
      )),
      (item) => emit(state.copyWith(
        status: ViewStatus.success,
        item: item,
      )),
    );
  }
}
