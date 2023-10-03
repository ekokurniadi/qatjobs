part of 'auth_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required LoginStatus status,
    required LoginEntity loginEntity,
    required String message,
  }) = _AuthState;

  factory AuthState.initial() => AuthState(
        status: LoginStatus.initial,
        message: '',
        loginEntity: LoginEntity(
          accessToken: '',
          user: UserEntity(
            id: 0,
            firstName: '',
            lastName: '',
            email: '',
            gender: 0,
            isActive: false,
            isVerified: false,
            ownerId: 0,
            ownerType: '',
            language: '',
            profileViews: '0',
            themeMode: '0',
            isDefault: false,
            regionCode: '',
            fullName: '',
            avatar: '',
            roles: [],
          ),
          roles: [],
        ),
      );
}
