abstract class HomeScreenEvent {}

class GetChargingStationDataEvent extends HomeScreenEvent {}

class HomeScreenLastEvent extends HomeScreenEvent {}

class GetChargingStationStatusEvent extends HomeScreenEvent {
  final String stationId;
  GetChargingStationStatusEvent(this.stationId);
}
