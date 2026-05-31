import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/design_item_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/designer_model.dart';
import 'package:mnb_mobile/app/modules/primary/domain/usecase/primary_use_cases.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';

class HomeState extends Equatable {
  final ViewStatus status;
  final List<DesignerModel> designers;
  final List<DesignItemModel> designItems;
  final String message;

  const HomeState({
    this.status = ViewStatus.initial,
    this.designers = const [],
    this.designItems = const [],
    this.message = '',
  });

  HomeState copyWith({
    ViewStatus? status,
    List<DesignerModel>? designers,
    List<DesignItemModel>? designItems,
    String? message,
  }) {
    return HomeState(
      status: status ?? this.status,
      designers: designers ?? this.designers,
      designItems: designItems ?? this.designItems,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, designers, designItems, message];
}

class HomeCubit extends Cubit<HomeState> {
  final GetDesignersUseCase _getDesigners;
  final GetDesignItemsUseCase _getDesignItems;

  HomeCubit(this._getDesigners, this._getDesignItems)
      : super(const HomeState());

  Future<void> load() async {
    emit(state.copyWith(status: ViewStatus.loading));

    final designersResult = await _getDesigners();
    final itemsResult = await _getDesignItems();

    String? error;
    var designers = state.designers;
    var items = state.designItems;

    designersResult.fold(
      (failure) => error ??= failure.getError(),
      (data) => designers = data,
    );
    itemsResult.fold(
      (failure) => error ??= failure.getError(),
      (data) => items = data,
    );

    if (error != null && designers.isEmpty && items.isEmpty) {
      emit(state.copyWith(status: ViewStatus.failure, message: error));
      return;
    }

    emit(state.copyWith(
      status: ViewStatus.success,
      designers: designers,
      designItems: items,
    ));
  }
}
