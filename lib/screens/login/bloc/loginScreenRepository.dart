abstract class LoginScreenRepository {
  Future<bool> sendOtp(String phoneNumber);
  Future<bool> verifyOtp(String phoneNumber, String otp);
}

class LoginScreenRepositoryImp extends LoginScreenRepository {
  @override
  Future<bool> sendOtp(String phoneNumber) async {
    try {
      // Simulate sending OTP (replace with actual Firebase or API logic)
      await Future.delayed(Duration(seconds: 2));
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> verifyOtp(String phoneNumber, String otp) async {
    try {
      // Simulate verifying OTP (replace with actual Firebase or API logic)
      await Future.delayed(Duration(seconds: 2));

      // For demo, accept OTP '123456' as valid
      if (otp == '123456') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
