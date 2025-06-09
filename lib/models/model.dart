import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class ChargingStationListModel {
  String? id;
  String? name;
  String? address;
  double? latitude;
  double? longitude;
  List<String>? connector_types;
  int? power_kw;
  String? price_per_kwh;
  int? available_ports;
  int? total_ports;
  String? status;
  String? last_updated;

  ChargingStationListModel({
    this.id,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.connector_types,
    this.power_kw,
    this.price_per_kwh,
    this.available_ports,
    this.total_ports,
    this.status,
    this.last_updated,
  });

  factory ChargingStationListModel.fromJson(Map<String, dynamic> json) =>
      _$ChargingStationListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChargingStationListModelToJson(this);
}
