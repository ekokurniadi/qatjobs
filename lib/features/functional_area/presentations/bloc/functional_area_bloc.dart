import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/functional_area/data/models/functional_area_model.codegen.dart';
import 'package:qatjobs/features/functional_area/domain/entities/functional_area_entity.codegen.dart';
import 'package:qatjobs/features/functional_area/domain/usecases/get_functional_area_usecase.dart';

part 'functional_area_event.dart';
part 'functional_area_state.dart';
part 'functional_area_bloc.freezed.dart';

@injectable
class FunctionalAreaBloc
    extends Bloc<FunctionalAreaEvent, FunctionalAreaState> {
  final GetFunctionalAreaUseCase _getFunctionalAreaUseCase;
  FunctionalAreaBloc(
    this._getFunctionalAreaUseCase,
  ) : super(FunctionalAreaState.initial()) {
    on<_Started>(
      (event, emit) async {
        emit(state.copyWith(status: FunctionalAreaStatus.loading));
        final result = await _getFunctionalAreaUseCase(NoParams());

        result.fold(
          (l) => emit(
            state.copyWith(
              status: FunctionalAreaStatus.failure,
              message: l.errorMessage,
            ),
          ),
          (r) => emit(
            state.copyWith(
              status: FunctionalAreaStatus.complete,
              functionalAreas: List<FunctionalAreaEntity>.from(
                r.map(
                  (e) => e.toDomain(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
