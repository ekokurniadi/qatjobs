import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/home/data/models/home_models.codegen.dart';
import 'package:qatjobs/features/home/domain/usecases/get_front_data_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetFrontDataUseCase _getFrontDataUseCase;
  HomeBloc(
    this._getFrontDataUseCase,
  ) : super(HomeState.initial()) {
    on<_GetFrontData>(_getFrontData);
  }

  FutureOr<void> _getFrontData(
    _GetFrontData event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await _getFrontDataUseCase(NoParams());

    result.fold(
        (l) => emit(state.copyWith(
              message: l.errorMessage,
              status: HomeStatus.failure,
            )),
        (r) => emit(
              state.copyWith(
                data: r,
                status: HomeStatus.complete,
              ),
            ));
  }
}
