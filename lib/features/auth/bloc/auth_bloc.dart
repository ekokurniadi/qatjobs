import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/constant/url_constant.dart';
import 'package:qatjobs/core/extensions/dio_response_extension.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/features/auth/data/models/login_model.codegen.dart';
import 'package:qatjobs/features/auth/domain/entities/login_entity.codegen.dart';
import 'package:qatjobs/features/auth/domain/usecases/login_usecase.dart';
import 'package:qatjobs/features/auth/domain/usecases/register_usecase.dart';
import 'package:qatjobs/features/users/domain/entitites/users_entity.codegen.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  AuthBloc(
    this._loginUseCase,
    this._registerUseCase,
  ) : super(AuthState.initial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<ForgotPassword>(_onForgotPassword);
  }

  FutureOr<void> _onLogin(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _loginUseCase(event.params);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            status: AuthStatus.success,
            loginEntity: r.toDomain(),
            message: 'Login Success',
          ),
        );
      },
    );
  }

  FutureOr<void> _onRegister(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _registerUseCase(event.params);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            status: AuthStatus.registerSuccess,
            message: 'Register Success',
          ),
        );
      },
    );
  }

  FutureOr<void> _onForgotPassword(
    ForgotPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final response = await DioHelper.dio!.post(URLConstant.forgotPassword,
          data: FormData.fromMap({'email': event.email}),
          options: Options(headers: {'Accept': 'application/json'}));

      if (response.isOk) {
        emit(
          state.copyWith(
            status: AuthStatus.sendEmailForgotPassword,
            message: response.data['message'],
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            message: response.data['message'],
          ),
        );
      }
    } on DioError catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: DioHelper.formatException(e),
        ),
      );
    }
  }
}
