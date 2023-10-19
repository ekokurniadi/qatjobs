part of 'home_bloc.dart';

enum HomeStatus { initial, loading, complete, failure }

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required HomeStatus status,
    HomeModels? data,
    required String message,
  }) = _HomeState;

  factory HomeState.initial() => HomeState(
        status: HomeStatus.initial,
        data: null,
        message: '',
      );
}
