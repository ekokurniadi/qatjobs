import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/degree_level/data/models/degree_level_model.codegen.dart';
import 'package:qatjobs/features/degree_level/domain/entities/degree_level_entity.codegen.dart';
import 'package:qatjobs/features/degree_level/domain/usecases/get_degree_level_usecase.dart';

part 'degree_level_event.dart';
part 'degree_level_state.dart';
part 'degree_level_bloc.freezed.dart';

@injectable
class DegreeLevelBloc extends Bloc<DegreeLevelEvent, DegreeLevelState> {
  final GetDegreeLevelUseCase _getDegreeLevelUseCase;
  DegreeLevelBloc(
    this._getDegreeLevelUseCase,
  ) : super(DegreeLevelState.initial()) {
    on<_Started>(
      (event, emit) async {
        emit(state.copyWith(status: DegreeLevelStatus.loading));
        final result = await _getDegreeLevelUseCase(NoParams());

        result.fold(
          (l) => emit(
            state.copyWith(
              status: DegreeLevelStatus.failure,
              message: l.errorMessage,
            ),
          ),
          (r) => emit(
            state.copyWith(
              status: DegreeLevelStatus.complete,
              degreeLevels: List<DegreeLevelEntity>.from(
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
