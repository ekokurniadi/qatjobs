import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/constant/app_constant.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/users/data/models/users_model.codegen.dart';
import 'package:qatjobs/features/users/domain/entitites/users_entity.codegen.dart';
import 'package:qatjobs/features/users/domain/usecases/get_logedin_user_usecase.dart';
import 'package:qatjobs/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final isProfileComplete = getIt<SharedPreferences>().getBool(
      AppConstant.prefIsProfileComplete,
    );

    result.fold(
      (l) => emit(
        state.copyWith(
          status: UserBlocStatus.failure,
          message: l.errorMessage,
          isProfileComplete: isProfileComplete ?? false,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: UserBlocStatus.complete,
          user: GlobalHelper.isEmpty(r) ? null : r?.toDomain(),
          isProfileComplete: isProfileComplete ?? false,
        ),
      ),
    );
  }
}
