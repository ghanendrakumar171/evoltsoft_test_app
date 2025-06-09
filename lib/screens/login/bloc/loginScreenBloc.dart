import 'package:flutter_bloc/flutter_bloc.dart';
import 'loginScreenEvents.dart';
import 'loginScreenRepository.dart';
import 'loginScreenState.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final LoginScreenRepository loginScreenRepository;

  LoginScreenBloc({required this.loginScreenRepository})
    : super(LoginInitialState()) {
    on<SendOtpEvent>(_onSendOtpEvent);
    on<VerifyOtpEvent>(_onVerifyOtpEvent);
  }

  Future<void> _onSendOtpEvent(
    SendOtpEvent event,
    Emitter<LoginScreenState> emit,
  ) async {
    emit(AuthLoadingState());

    try {
      final isOtpSent = await loginScreenRepository.sendOtp(event.phoneNumber);

      if (isOtpSent) {
        emit(AuthOtpSentState());
      } else {
        emit(AuthErrorState(message: 'Failed to send OTP. Please try again.'));
      }
    } catch (e) {
      emit(AuthErrorState(message: 'Something went wrong: ${e.toString()}'));
    }
  }

  Future<void> _onVerifyOtpEvent(
    VerifyOtpEvent event,
    Emitter<LoginScreenState> emit,
  ) async {
    emit(AuthLoadingState());

    try {
      final isOtpVerified = await loginScreenRepository.verifyOtp(
        event.phoneNumber,
        event.otp,
      );

      if (isOtpVerified) {
        emit(AuthOtpVerifiedState());
      } else {
        emit(AuthErrorState(message: 'Invalid OTP. Please try again.'));
      }
    } catch (e) {
      emit(AuthErrorState(message: 'Something went wrong: ${e.toString()}'));
    }
  }
}
