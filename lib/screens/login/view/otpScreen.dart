import 'package:evolesoft_app/customWidget/textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evolesoft_app/customWidget/elevatedButton.dart';
import 'package:evolesoft_app/customWidget/circularProcessIndicator.dart';
import 'package:evolesoft_app/screens/login/bloc/loginScreenBloc.dart';
import 'package:evolesoft_app/screens/login/bloc/loginScreenEvents.dart';
import 'package:evolesoft_app/screens/login/bloc/loginScreenState.dart';
import 'package:evolesoft_app/utils/appStrings.dart';
import 'package:evolesoft_app/utils/appSizes.dart';
import 'package:evolesoft_app/helper/routeDirectory/route.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  void _onVerifyOtp() {
    final otp = _otpController.text.trim();
    if (otp.length != 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(AppStrings.enterValidOtp)));
      return;
    }

    context.read<LoginScreenBloc>().add(
      VerifyOtpEvent(phoneNumber: widget.phoneNumber, otp: otp),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.onBackground,
      appBar: AppBar(
        title: Text(
          AppStrings.otpVerification,
          style: theme.textTheme.headlineMedium,
        ),
        backgroundColor: theme.colorScheme.onBackground,
        elevation: 0,
      ),
      body: BlocBuilder<LoginScreenBloc, LoginScreenState>(
        builder: (context, state) {
          final isLoading = state is AuthLoadingState;
          print("================> ${isLoading}");

          // Handle navigation and error outside the widget tree
          if (state is AuthOtpVerifiedState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.home,
                (route) => false,
              );
            });
          } else if (state is AuthErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            });
          }

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSizes.sizeTwenty),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.enterOtpSentTo,
                      style: theme.textTheme.bodyMedium,
                    ),
                    SizedBox(height: AppSizes.sizeEight),
                    Text(widget.phoneNumber, style: theme.textTheme.bodyLarge),
                    SizedBox(height: AppSizes.sizeThirty),
                    CustomTextField(
                      maxLength: 6,
                      controller: _otpController,
                      hintText: AppStrings.enterYourPhoneNumber,
                      labelText: AppStrings.otp,
                      type: CustomTextFieldType.mobileNumber,
                      keyboardType: TextInputType.number,
                      isValidation: true,
                      enabled: !isLoading,
                    ),
                    SizedBox(height: AppSizes.sizeThirty),
                    SizedBox(
                      width: double.infinity,
                      height: AppSizes.sizeFifty,
                      child: CustomElevatedButton(
                        text: AppStrings.verify,
                        onPressed: isLoading ? null : _onVerifyOtp,
                        backgroundColor: theme.colorScheme.primary,
                        textColor: theme.colorScheme.onPrimary,
                        textStyle: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: CustomCircularProcessIndicator(isLoading: isLoading),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
