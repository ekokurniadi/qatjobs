part of 'industry_bloc.dart';

enum IndustryStatus { initial, loading, complete, failure }

@freezed
class IndustryState with _$IndustryState {
  const factory IndustryState({
    required IndustryStatus status,
    required String message,
    required List<IndustryModel> types,
  }) = _IndustryState;

  factory IndustryState.initial() => const IndustryState(
        status: IndustryStatus.initial,
        types: [],
        message: '',
      );
}
