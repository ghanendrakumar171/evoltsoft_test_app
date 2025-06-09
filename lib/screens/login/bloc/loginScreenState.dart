// loginScreenState.dart

abstract class LoginScreenState {}

class LoginInitialState extends LoginScreenState {}

class AuthLoadingState extends LoginScreenState {}

class AuthOtpSentState extends LoginScreenState {}

class AuthOtpVerifiedState extends LoginScreenState {}

class AuthErrorState extends LoginScreenState {
  final String message;

  AuthErrorState({required this.message});
}
