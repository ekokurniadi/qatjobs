part of 'connectivity_bloc.dart';

@freezed
class ConnectivityState with _$ConnectivityState {
  const factory ConnectivityState({
    required bool internetConnectionStatus,
  }) = _ConnectivityState;

  factory ConnectivityState.initial() => const ConnectivityState(
        internetConnectionStatus: true,
      );
}
