abstract class LoginScreenEvent {}

class SendOtpEvent extends LoginScreenEvent {
  final String phoneNumber;

  SendOtpEvent({required this.phoneNumber});
}

class VerifyOtpEvent extends LoginScreenEvent {
  final String phoneNumber;
  final String otp;

  VerifyOtpEvent({required this.phoneNumber, required this.otp});
}
