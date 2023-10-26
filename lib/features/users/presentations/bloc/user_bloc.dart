import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/users/data/models/users_model.codegen.dart';
import 'package:qatjobs/features/users/domain/entitites/users_entity.codegen.dart';
import 'package:qatjobs/features/users/domain/usecases/get_logedin_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetLogedinUserCase _getLogedinUserCase;

  UserBloc(
    this._getLogedinUserCase,
  ) : super(UserState.initial()) {
    on<_GetLogedinUserEvent>(_onGetLogedinUser);
  }

  FutureOr<void> _onGetLogedinUser(
    _GetLogedinUserEvent event,
    Emitter<UserState> emit,
  ) async {
    final result = await _getLogedinUserCase(NoParams());

    result.fold(
      (l) => emit(
        state.copyWith(
          status: UserBlocStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: UserBlocStatus.complete,
          user: GlobalHelper.isEmpty(r) ? null : r?.toDomain(),
        ),
      ),
    );
  }
}
