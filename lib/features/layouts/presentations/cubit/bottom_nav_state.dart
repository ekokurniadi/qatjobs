part of 'bottom_nav_cubit.dart';

@freezed
class BottomNavState with _$BottomNavState {
  const factory BottomNavState({
    required int selectedMenuIndex,
    UserModel? user,
  }) = _BottomNavState;

  factory BottomNavState.initial() => const BottomNavState(
        selectedMenuIndex: 0,
        user: null,
      );
}
