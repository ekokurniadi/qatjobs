import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/features/auth/data/models/login_model.codegen.dart';
import 'package:qatjobs/features/auth/domain/entities/login_entity.codegen.dart';
import 'package:qatjobs/features/auth/domain/usecases/login_usecase.dart';
import 'package:qatjobs/features/users/domain/entitites/users_entity.codegen.dart';
import 'package:qatjobs/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  AuthBloc(
    this._loginUseCase,
  ) : super(AuthState.initial()) {
    on<LoginEvent>(_onLogin);
  }

  FutureOr<void> _onLogin(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));
    final result = await _loginUseCase(event.params);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: LoginStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) async {
        emit(
          state.copyWith(
            status: LoginStatus.success,
            loginEntity: r.toDomain(),
            message: 'Login Success',
          ),
        );
      },
    );
  }
}
