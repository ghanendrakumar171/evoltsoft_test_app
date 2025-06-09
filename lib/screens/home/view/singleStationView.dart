// ignore_for_file: file_names

import 'package:evolesoft_app/appTheme/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evolesoft_app/screens/home/bloc/homeScreenBloc.dart';
import 'package:evolesoft_app/screens/home/bloc/homeScreenEvents.dart';
import 'package:evolesoft_app/screens/home/bloc/homeScreenState.dart';
import 'package:evolesoft_app/utils/appStrings.dart';
import 'package:evolesoft_app/utils/appSizes.dart';

class ChargingStationItem extends StatefulWidget {
  final String? stationId;

  const ChargingStationItem({super.key, required this.stationId});

  @override
  State<ChargingStationItem> createState() => _ChargingStationItemState();
}

class _ChargingStationItemState extends State<ChargingStationItem> {
  @override
  void initState() {
    super.initState();
    if (widget.stationId != null) {
      context.read<HomeScreenBloc>().add(
        GetChargingStationStatusEvent(widget.stationId!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.chargingStationDetail),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetChargingStationStatusSuccessState) {
            final station = state.stationStatus;

            if (station == null) {
              return Center(
                child: Text(
                  AppStrings.stationDataMissing,
                  style: textTheme.bodyLarge,
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(AppSizes.sizeTwelve),
              child: Card(
                elevation: AppSizes.sizeFour,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.sizeSixteen),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: AppSizes.hundredEighty,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppThemeClass.backgroundColor,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(AppSizes.sizeSixteen),
                        ),
                      ),
                      child: const Icon(
                        Icons.ev_station_rounded,
                        size: AppSizes.sizeEighty,
                        color: AppThemeClass.primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppSizes.sizeSixteen),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            station.name ?? "N/A",
                            style: textTheme.headlineMedium,
                          ),
                          const SizedBox(height: AppSizes.sizeFour),
                          Text(
                            station.address ?? AppStrings.noAddressProvided,
                            style: textTheme.bodySmall,
                          ),
                          const SizedBox(height: AppSizes.sizeSixteen),
                          Text(
                            AppStrings.facilitiesAvailable,
                            style: textTheme.labelMedium,
                          ),
                          const SizedBox(height: AppSizes.sizeEight),
                          InfoRow(
                            icon: Icons.flash_on,
                            label: AppStrings.powerKW,
                            value: station.power_kw?.toString() ?? "N/A",
                            textStyle: textTheme.bodyMedium,
                          ),
                          InfoRow(
                            icon: Icons.attach_money,
                            label: AppStrings.pricePerKwh,
                            value: station.price_per_kwh ?? "N/A",
                            textStyle: textTheme.bodyMedium,
                          ),
                          InfoRow(
                            icon: Icons.ev_station,
                            label: AppStrings.connectors,
                            value: station.connector_types?.join(', ') ?? "N/A",
                            textStyle: textTheme.bodyMedium,
                          ),
                          InfoRow(
                            icon: Icons.power_outlined,
                            label: AppStrings.availablePorts,
                            value:
                                "${station.available_ports ?? 0} / ${station.total_ports ?? 0}",
                            textStyle: textTheme.bodyMedium,
                          ),
                          InfoRow(
                            icon: Icons.info,
                            label: AppStrings.status,
                            value: station.status ?? "Unknown",
                            textStyle: textTheme.bodyMedium,
                          ),
                          InfoRow(
                            icon: Icons.update,
                            label: AppStrings.lastUpdated,
                            value: station.last_updated?.toString() ?? "N/A",
                            textStyle: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppSizes.sizeSixteen),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppThemeClass.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppSizes.sizeTwelve,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSizes.sizeFourteen,
                            ),
                          ),
                          onPressed: () {
                            // TODO: Navigate to directions
                          },
                          child: Text(
                            AppStrings.getDirections,
                            style: textTheme.labelMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is HomeErrorState) {
            return Center(
              child: Text(
                AppStrings.failedToLoadStation,
                style: textTheme.bodyLarge,
              ),
            );
          } else {
            return Center(
              child: Text(AppStrings.noStationData, style: textTheme.bodyLarge),
            );
          }
        },
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final TextStyle? textStyle;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sizeSix),
      child: Row(
        children: [
          Icon(
            icon,
            size: AppSizes.sizeTwenty,
            color: AppThemeClass.textSecondary,
          ),
          const SizedBox(width: AppSizes.sizeEight),
          Text(label, style: textStyle?.copyWith(fontWeight: FontWeight.w500)),
          const SizedBox(width: AppSizes.sizeTwelve),
          Expanded(child: Text(value, style: textStyle)),
        ],
      ),
    );
  }
}
