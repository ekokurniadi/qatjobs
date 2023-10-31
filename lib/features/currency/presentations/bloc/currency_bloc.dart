import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/currency/data/models/currency_model.codegen.dart';
import 'package:qatjobs/features/currency/domain/entities/currency_entity.codegen.dart';
import 'package:qatjobs/features/currency/domain/usecases/get_currency_usecase.dart';

part 'currency_event.dart';
part 'currency_state.dart';
part 'currency_bloc.freezed.dart';

@injectable
class CurrencyBloc
    extends Bloc<CurrencyEvent, CurrencyState> {
  final GetCurrencyUseCase _getCurrencyUseCase;
  CurrencyBloc(
    this._getCurrencyUseCase,
  ) : super(CurrencyState.initial()) {
    on<_Started>(
      (event, emit) async {
        emit(state.copyWith(status: CurrencyStatus.loading));
        final result = await _getCurrencyUseCase(NoParams());

        result.fold(
          (l) => emit(
            state.copyWith(
              status: CurrencyStatus.failure,
              message: l.errorMessage,
            ),
          ),
          (r) => emit(
            state.copyWith(
              status: CurrencyStatus.complete,
              currency: List<CurrencyEntity>.from(
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
