// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargingStationListModel _$ChargingStationListModelFromJson(
  Map<String, dynamic> json,
) => ChargingStationListModel(
  id: json['id'] as String?,
  name: json['name'] as String?,
  address: json['address'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  connector_types: (json['connector_types'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  power_kw: (json['power_kw'] as num?)?.toInt(),
  price_per_kwh: json['price_per_kwh'] as String?,
  available_ports: (json['available_ports'] as num?)?.toInt(),
  total_ports: (json['total_ports'] as num?)?.toInt(),
  status: json['status'] as String?,
  last_updated: json['last_updated'] as String?,
);

Map<String, dynamic> _$ChargingStationListModelToJson(
  ChargingStationListModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'address': instance.address,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'connector_types': instance.connector_types,
  'power_kw': instance.power_kw,
  'price_per_kwh': instance.price_per_kwh,
  'available_ports': instance.available_ports,
  'total_ports': instance.total_ports,
  'status': instance.status,
  'last_updated': instance.last_updated,
};
