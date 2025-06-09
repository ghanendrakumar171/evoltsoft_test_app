// ignore_for_file: override_on_non_overriding_member

import 'package:evolesoft_app/screens/splash/bloc/splashScreenEvents.dart';
import 'package:evolesoft_app/screens/splash/bloc/splashScreenRepository.dart';
import 'package:evolesoft_app/screens/splash/bloc/splashScreenState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenRepository? splashScreenRepository;
  SplashScreenBloc({this.splashScreenRepository})
    : super(SplashInitialState()) {
    on<SplashScreenEvent>(mapEventToState);
  }
  @override
  mapEventToState(
    SplashScreenEvent event,
    Emitter<SplashScreenState> emit,
  ) async {}
}
