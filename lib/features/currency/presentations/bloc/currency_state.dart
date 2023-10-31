part of 'currency_bloc.dart';

enum CurrencyStatus { initial, loading, complete, failure }

@freezed
class CurrencyState with _$CurrencyState {
  const factory CurrencyState({
    required CurrencyStatus status,
    required String message,
    required List<CurrencyEntity> currency,
  }) = _CurrencyState;

  factory CurrencyState.initial() => const CurrencyState(
        status: CurrencyStatus.initial,
        currency: [],
        message: '',
      );
}
