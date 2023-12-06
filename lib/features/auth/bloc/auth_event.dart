part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login(LoginRequestParams params) = LoginEvent;
  const factory AuthEvent.register(RegisterRequestParam params) = RegisterEvent;
  const factory AuthEvent.forgotPassword(String email) = ForgotPassword;
}
