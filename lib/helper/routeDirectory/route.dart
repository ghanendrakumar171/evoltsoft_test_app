import 'package:evolesoft_app/screens/home/view/singleStationView.dart';
import 'package:evolesoft_app/screens/login/bloc/loginScreenBloc.dart';
import 'package:evolesoft_app/screens/login/bloc/loginScreenRepository.dart';
import 'package:evolesoft_app/screens/login/view/login.dart';
import 'package:evolesoft_app/screens/login/view/otpScreen.dart';
import 'package:evolesoft_app/screens/splash/bloc/splashScreenBloc.dart';
import 'package:evolesoft_app/screens/splash/bloc/splashScreenRepository.dart';
import 'package:evolesoft_app/screens/splash/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../screens/home/bloc/homeScreenBloc.dart';
import '../../screens/home/bloc/homeScreenRepository.dart';
import '../../screens/home/view/homeScreen.dart';

// this file is only for route and navigation Screen File;
class AppRoute {
  static const String splash = "splash";
  static const String home = "home";
  static const String otp = "otp";
  static const String stationView = "stationView";

  static const String login = "login";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //splash screen

      case splash:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SplashScreenBloc>(
            create: (context) => SplashScreenBloc(
              splashScreenRepository: SplashScreenRepositoryImp(),
            ),
            child: const SplashScreen(),
          ),
        );

      //  login
      case login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginScreenBloc>(
            create: (context) => LoginScreenBloc(
              loginScreenRepository: LoginScreenRepositoryImp(),
            ),
            child: LoginScreen(),
          ),
        );

      // otp

      case otp:
        final String phoneNumber = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<LoginScreenBloc>(
            create: (_) => LoginScreenBloc(
              loginScreenRepository: LoginScreenRepositoryImp(),
            ),
            child: OtpScreen(phoneNumber: phoneNumber), // pass here
          ),
        );

      // Home Screen   ---->

      case home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HomeScreenBloc>(
            create: (context) =>
                HomeScreenBloc(homeScreenRepository: HomeScreenRepositoryImp()),
            child: const HomeScreen(),
          ),
        );
      //stationView
      case stationView:
        final String id = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<HomeScreenBloc>(
            create: (_) =>
                HomeScreenBloc(homeScreenRepository: HomeScreenRepositoryImp()),
            child: ChargingStationItem(stationId: id), // pass here
          ),
        );

      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text("Error")),
          body: const Center(child: Text("Page not found")),
        );
      },
    );
  }
}
