import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/carrier_level/data/models/career_level_model.codegen.dart';
import 'package:qatjobs/features/carrier_level/domain/entities/career_level_entity.codegen.dart';
import 'package:qatjobs/features/carrier_level/domain/usecases/get_career_level_usecase.dart';

part 'career_level_event.dart';
part 'career_level_state.dart';
part 'career_level_bloc.freezed.dart';

@injectable
class CareerLevelBloc extends Bloc<CareerLevelEvent, CareerLevelState> {
  final GetCareerLevelUseCase _getCareerLevelUseCase;
  CareerLevelBloc(
    this._getCareerLevelUseCase,
  ) : super(CareerLevelState.initial()) {
    on<_Started>(
      (event, emit) async {
        emit(state.copyWith(status: CareerLevelStatus.loading));
        final result = await _getCareerLevelUseCase(NoParams());

        result.fold(
          (l) => emit(
            state.copyWith(
              status: CareerLevelStatus.failure,
              message: l.errorMessage,
            ),
          ),
          (r) => emit(
            state.copyWith(
              status: CareerLevelStatus.complete,
              careerLevels: List<CareerLevelEntity>.from(
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
