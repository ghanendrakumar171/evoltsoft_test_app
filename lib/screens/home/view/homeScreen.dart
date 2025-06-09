// ignore_for_file: file_names

import 'package:evolesoft_app/helper/routeDirectory/route.dart';
import 'package:evolesoft_app/models/model.dart';
import 'package:evolesoft_app/screens/home/bloc/homeScreenEvents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../customWidget/circularProcessIndicator.dart';
import '../../../customWidget/dialogDialog.dart';
import '../../../utils/appStrings.dart';
import '../../../utils/appSizes.dart';
import '../bloc/homeScreenBloc.dart';
import '../bloc/homeScreenState.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeScreenBloc homeScreenBloc;
  List<ChargingStationListModel> stationList = [];
  bool errorShown = false;
  Set<Marker> _markers = {};
  late GoogleMapController _mapController;
  bool isLoading = false;
  bool hasLocationPermission = false;

  @override
  void initState() {
    super.initState();
    homeScreenBloc = context.read<HomeScreenBloc>();
    requestLocationPermission();
    homeScreenBloc.add(GetChargingStationDataEvent());
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    setState(() {
      hasLocationPermission = status.isGranted;
    });
  }

  void _updateMarkers(List<ChargingStationListModel> stations) {
    final markers = <Marker>{};
    for (var station in stations) {
      if (station.latitude != null && station.longitude != null) {
        markers.add(
          Marker(
            markerId: MarkerId(
              station.id ?? station.name ?? 'id_${stations.indexOf(station)}',
            ),
            position: LatLng(station.latitude!, station.longitude!),
            infoWindow: InfoWindow(
              title: station.name,
              snippet:
                  '${AppStrings.statusLabel}: ${station.status}\n${AppStrings.availablePortsLabel}: ${station.available_ports ?? AppStrings.notAvailable}',
            ),
          ),
        );
      }
    }

    setState(() {
      _markers = markers;
      stationList = stations;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: AppSizes.sizeFour,
        title: const Text(AppStrings.evoltsoft),
      ),
      body: BlocListener<HomeScreenBloc, HomeScreenState>(
        listener: (context, state) {
          if (state is HomeLoadingState) {
            setState(() {
              isLoading = true;
              errorShown = false;
            });
          } else if (state is GetChargingStationSuccessState) {
            _updateMarkers(state.chargingStationList ?? []);
            setState(() {
              isLoading = false;
              errorShown = false;
            });
          } else if (state is HomeErrorState) {
            setState(() {
              isLoading = false;
            });
            if (!errorShown) {
              errorShown = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                renderBasicAlert(
                  context: context,
                  message: AppStrings.commonErrorMessage,
                );
              });
            }
          }
        },
        child: isLoading
            ? const CustomCircularProcessIndicator(isLoading: true)
            : !hasLocationPermission
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.sizeSixteen),
                  child: Text(
                    AppStrings.locationPermissionRequired,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge,
                  ),
                ),
              )
            : stationList.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.sizeSixteen),
                  child: Text(
                    AppStrings.noChargingStationsFound,
                    style: textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.outline.withOpacity(
                        AppSizes.sizeZeroPointSix,
                      ),
                    ),
                  ),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          stationList.first.latitude ?? 28.6139,
                          stationList.first.longitude ?? 77.2090,
                        ),
                        zoom: AppSizes.sizeTwelve,
                      ),
                      markers: _markers,
                      onMapCreated: (controller) => _mapController = controller,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.sizeEight,
                        horizontal: AppSizes.sizeTwelve,
                      ),
                      itemCount: stationList.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSizes.sizeSix),
                      itemBuilder: (context, index) {
                        final station = stationList[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.all(
                            AppSizes.sizeTwelve,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.sizeTwelve,
                            ),
                            side: BorderSide(
                              color: theme.dividerColor,
                              width: AppSizes.sizeTwo,
                            ),
                          ),
                          tileColor: theme.cardColor,
                          leading: const Icon(
                            Icons.ev_station_rounded,
                            size: AppSizes.sizeThirtyTwo,
                          ),
                          title: Text(
                            station.name ?? AppStrings.unnamedStation,
                          ),
                          subtitle: Text(
                            '${AppStrings.statusLabel}: ${station.status}\n${AppStrings.availablePortsLabel}: ${station.available_ports ?? AppStrings.notAvailable}',
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoute.stationView,
                              arguments: station.id,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
