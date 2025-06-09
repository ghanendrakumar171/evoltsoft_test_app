// ignore_for_file: override_on_non_overriding_member

// import 'package:evolesoft_app/models/getEmployeesDataResponseModel.dart';
import 'package:evolesoft_app/models/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'homeScreenEvents.dart';
import 'homeScreenRepository.dart';
import 'homeScreenState.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenRepository? homeScreenRepository;
  HomeScreenBloc({this.homeScreenRepository}) : super(HomeInitialState()) {
    on<HomeScreenEvent>(mapEventToState);
  }
  @override
  mapEventToState(HomeScreenEvent event, Emitter<HomeScreenState> emit) async {
    if (event is GetChargingStationDataEvent) {
      emit(HomeLoadingState());
      try {
        List<ChargingStationListModel> chargingStationList =
            await homeScreenRepository!.getChargingStationListFunction();
        emit(
          GetChargingStationSuccessState(
            chargingStationList: chargingStationList,
          ),
        );
      } catch (e) {
        emit(HomeErrorState());
      }
    } else if (event is GetChargingStationStatusEvent) {
      emit(HomeLoadingState());
      try {
        ChargingStationListModel? stationStatus = await homeScreenRepository
            ?.getChargingStationStatus(event.stationId);
        if (stationStatus != null) {
          emit(
            GetChargingStationStatusSuccessState(stationStatus: stationStatus),
          );
        } else {
          emit(HomeErrorState());
        }
      } catch (_) {
        emit(HomeErrorState());
      }
    }
  }
}
