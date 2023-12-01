part of 'user_bloc.dart';

enum UserBlocStatus { initial, loading, complete, failure }

@freezed
class UserState with _$UserState {
  factory UserState({
    required UserBlocStatus status,
    required String message,
    required bool isProfileComplete,
    UserEntity? user,
  }) = _UserState;

  factory UserState.initial() => UserState(
        status: UserBlocStatus.initial,
        message: '',
        user: null,
        isProfileComplete: false,
      );
}
