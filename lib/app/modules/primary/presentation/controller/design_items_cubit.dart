import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/design_item_model.dart';
import 'package:mnb_mobile/app/modules/primary/domain/usecase/primary_use_cases.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';

class DesignItemsState extends Equatable {
  final ViewStatus status;
  final List<DesignItemModel> items;
  final String message;

  const DesignItemsState({
    this.status = ViewStatus.initial,
    this.items = const [],
    this.message = '',
  });

  DesignItemsState copyWith({
    ViewStatus? status,
    List<DesignItemModel>? items,
    String? message,
  }) {
    return DesignItemsState(
      status: status ?? this.status,
      items: items ?? this.items,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, items, message];
}

class DesignItemsCubit extends Cubit<DesignItemsState> {
  final GetDesignItemsUseCase _getDesignItems;

  DesignItemsCubit(this._getDesignItems) : super(const DesignItemsState());

  Future<void> load() async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _getDesignItems();
    result.fold(
      (failure) => emit(state.copyWith(
        status: ViewStatus.failure,
        message: failure.getError(),
      )),
      (items) => emit(state.copyWith(
        status: ViewStatus.success,
        items: items,
      )),
    );
  }
}
