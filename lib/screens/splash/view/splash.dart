import 'dart:async';
import 'package:evolesoft_app/appTheme/appTheme.dart';
import 'package:evolesoft_app/customWidget/circularProcessIndicator.dart';
import 'package:evolesoft_app/helper/routeDirectory/route.dart';
import 'package:evolesoft_app/screens/splash/bloc/splashScreenBloc.dart';
import 'package:evolesoft_app/screens/splash/bloc/splashScreenState.dart';
import 'package:evolesoft_app/utils/appAssets.dart';
import 'package:evolesoft_app/utils/appSizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenBloc? splashScreenBloc;
  bool? isLoading = false;
  @override
  void initState() {
    splashScreenBloc = context.read<SplashScreenBloc>();
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate loading

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoute.login,
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeClass.backgroundColor,
      body: BlocBuilder<SplashScreenBloc, SplashScreenState>(
        builder: (BuildContext context, currentState) {
          print("Current State ${currentState}");
          if (currentState is SplashLoadingState) {
            isLoading = true;
          } else if (currentState is SplashInitialState) {
            isLoading = false;
          }
          return _splashScreen(context);
        },
      ),
    );
  }

  Widget _splashScreen(BuildContext context) {
    return isLoading!
        ? const CustomCircularProcessIndicator(isLoading: true)
        : Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.sizeSixteen),
              child: Image.asset(
                AppAssets.splashLogo,
                height: AppSizes.threeHundredFifty,
                fit: BoxFit.cover,
              ),
            ),
          );
  }
}
