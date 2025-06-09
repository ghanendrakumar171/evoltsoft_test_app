// ignore_for_file: file_names

// import 'package:evolesoft_app/models/getEmployeesDataResponseModel.dart';

import 'package:evolesoft_app/models/model.dart';

abstract class HomeScreenState {}

class HomeInitialState extends HomeScreenState {}

class HomeLoadingState extends HomeScreenState {}

class HomeErrorState extends HomeScreenState {}

class HomeLastState extends HomeScreenState {}

class GetChargingStationSuccessState extends HomeScreenState {
  final List<ChargingStationListModel>? chargingStationList;

  GetChargingStationSuccessState({this.chargingStationList});
}

class GetChargingStationStatusSuccessState extends HomeScreenState {
  final ChargingStationListModel stationStatus;

  GetChargingStationStatusSuccessState({required this.stationStatus});
}
