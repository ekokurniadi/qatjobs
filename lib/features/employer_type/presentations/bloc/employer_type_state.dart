part of 'employer_type_bloc.dart';

enum EmployerTypeStatus { initial, loading, complete, failure }

@freezed
class EmployerTypeState with _$EmployerTypeState {
  const factory EmployerTypeState({
    required EmployerTypeStatus status,
    required String message,
    required List<EmployerTypeModel> types,
  }) = _EmployerTypeState;

  factory EmployerTypeState.initial() => const EmployerTypeState(
        status: EmployerTypeStatus.initial,
        types: [],
        message: '',
      );
}
