import 'package:evolesoft_app/customWidget/circularProcessIndicator.dart';
import 'package:evolesoft_app/customWidget/elevatedButton.dart';
import 'package:evolesoft_app/customWidget/textField.dart';
import 'package:evolesoft_app/helper/routeDirectory/route.dart';
import 'package:evolesoft_app/screens/login/bloc/loginScreenBloc.dart';
import 'package:evolesoft_app/screens/login/bloc/loginScreenEvents.dart';
import 'package:evolesoft_app/screens/login/bloc/loginScreenState.dart';
import 'package:evolesoft_app/utils/appAssets.dart';
import 'package:evolesoft_app/utils/appSizes.dart';
import 'package:evolesoft_app/utils/appStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  bool _isNavigating = false; // track if navigation started

  void _onContinue(BuildContext context) {
    final phone = _phoneController.text.trim();
    if (phone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Enter a valid phone number"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }
    context.read<LoginScreenBloc>().add(SendOtpEvent(phoneNumber: phone));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.onBackground,
      body: BlocConsumer<LoginScreenBloc, LoginScreenState>(
        listener: (context, state) async {
          if (state is AuthOtpSentState) {
            setState(() {
              _isNavigating = true; // start showing loader during navigation
            });
            await Navigator.pushNamed(
              context,
              AppRoute.otp,
              arguments: _phoneController.text.trim(),
            );
            setState(() {
              _isNavigating = false; // navigation done, hide loader
            });
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          bool isLoading = state is AuthLoadingState || _isNavigating;

          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(AppSizes.sizeTwenty),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.evoltsoft, style: textTheme.headlineLarge),
                    SizedBox(height: AppSizes.sizeTwenty),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizes.sizeSixteen),
                      child: Image.asset(
                        AppAssets.splashLogo,
                        height: AppSizes.twoHundred,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: AppSizes.sizeFifty),
                    CustomTextField(
                      maxLength: 10,
                      controller: _phoneController,
                      hintText: AppStrings.enterYourPhoneNumber,
                      labelText: AppStrings.contactNumber,
                      type: CustomTextFieldType.mobileNumber,
                      keyboardType: TextInputType.phone,
                      isValidation: true,
                      enabled: !isLoading,
                    ),
                    SizedBox(height: AppSizes.sizeTwenty),
                    SizedBox(
                      width: double.infinity,
                      height: AppSizes.sizeFifty,
                      child: CustomElevatedButton(
                        text: AppStrings.continnue,
                        onPressed: isLoading
                            ? null
                            : () => _onContinue(context),
                        backgroundColor: colorScheme.primary,
                        textColor: colorScheme.onPrimary,
                        textStyle: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
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
