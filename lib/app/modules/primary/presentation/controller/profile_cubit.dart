import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/user_model.dart';
import 'package:mnb_mobile/app/modules/primary/domain/usecase/primary_use_cases.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';

class ProfileState extends Equatable {
  final ViewStatus status;
  final UserModel? user;
  final String message;

  const ProfileState({
    this.status = ViewStatus.initial,
    this.user,
    this.message = '',
  });

  ProfileState copyWith({
    ViewStatus? status,
    UserModel? user,
    String? message,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, user, message];
}

class ProfileCubit extends Cubit<ProfileState> {
  final GetCurrentUserUseCase _getCurrentUser;

  ProfileCubit(this._getCurrentUser) : super(const ProfileState());

  Future<void> load() async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _getCurrentUser();
    result.fold(
      (failure) => emit(state.copyWith(
        status: ViewStatus.failure,
        message: failure.getError(),
      )),
      (user) => emit(state.copyWith(
        status: ViewStatus.success,
        user: user,
      )),
    );
  }
}
