import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/employer_type/data/models/employer_type_model.codegen.dart';
import 'package:qatjobs/features/employer_type/domain/usecases/get_employer_type_usecase.dart';


part 'employer_type_event.dart';
part 'employer_type_state.dart';
part 'employer_type_bloc.freezed.dart';

@injectable
class EmployerTypeBloc extends Bloc<EmployerTypeEvent, EmployerTypeState> {
  final GetEmployerTypeUseCase _getEmployerTypeUseCase;
  EmployerTypeBloc(
    this._getEmployerTypeUseCase,
  ) : super(EmployerTypeState.initial()) {
    on<_Started>(
      (event, emit) async {
        emit(state.copyWith(status: EmployerTypeStatus.loading));
        final result = await _getEmployerTypeUseCase(NoParams());

        result.fold(
          (l) => emit(
            state.copyWith(
              status: EmployerTypeStatus.failure,
              message: l.errorMessage,
            ),
          ),
          (r) => emit(
            state.copyWith(
              status: EmployerTypeStatus.complete,
              types: r,
            ),
          ),
        );
      },
    );
  }
}
