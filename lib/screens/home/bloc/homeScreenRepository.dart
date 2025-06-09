import 'package:evolesoft_app/helper/networkManager/apiClient.dart';
import 'package:evolesoft_app/models/model.dart';

abstract class HomeScreenRepository {
  Future<List<ChargingStationListModel>> getChargingStationListFunction();
  Future<ChargingStationListModel?> getChargingStationStatus(String stationId);
}

class HomeScreenRepositoryImp extends HomeScreenRepository {
  @override
  Future<List<ChargingStationListModel>>
  getChargingStationListFunction() async {
    try {
      final response = await ApiClient().getChargingStationList(); // re
      List<ChargingStationListModel> list = response;
      return list;
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  @override
  Future<ChargingStationListModel?> getChargingStationStatus(
    String stationId,
  ) async {
    try {
      final response = await ApiClient().getChargingStationStatus(stationId);
      return response;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
