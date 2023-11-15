import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/industry/data/models/industry_model.codegen.dart';
import 'package:qatjobs/features/industry/domain/usecases/get_industry_usecase.dart';


part 'industry_event.dart';
part 'industry_state.dart';
part 'industry_bloc.freezed.dart';

@injectable
class IndustryBloc extends Bloc<IndustryEvent, IndustryState> {
  final GetIndustryUseCase _getIndustryUseCase;
  IndustryBloc(
    this._getIndustryUseCase,
  ) : super(IndustryState.initial()) {
    on<_Started>(
      (event, emit) async {
        emit(state.copyWith(status: IndustryStatus.loading));
        final result = await _getIndustryUseCase(NoParams());

        result.fold(
          (l) => emit(
            state.copyWith(
              status: IndustryStatus.failure,
              message: l.errorMessage,
            ),
          ),
          (r) => emit(
            state.copyWith(
              status: IndustryStatus.complete,
              types: r,
            ),
          ),
        );
      },
    );
  }
}
