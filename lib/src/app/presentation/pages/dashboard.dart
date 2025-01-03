import 'package:bamboo_app/src/app/presentation/widgets/organism/floating_map_button.dart';
import 'package:bamboo_app/src/app/use_cases/gps_controller.dart';
import 'package:bamboo_app/src/app/use_cases/marker_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bamboo_app/src/app/blocs/marker_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  GoogleMapController? _controller;
  Set<Marker> _markers = {};
  LatLng? _sLocation;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    BlocProvider.of<MarkerStateBloc>(context).add(FetchMarkerData());
  }

  Future<void> _getUserLocation() async {
    LatLng position = await GpsController().getCurrentPosition();
    setState(() => _sLocation = position);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarkerStateBloc, MarkerState>(
      builder: (builderContext, state) {
        _markers = MarkerController(
                markerStateBloc: BlocProvider.of<MarkerStateBloc>(context))
            .fetchListMarker(state.markers, context);

        return (_sLocation == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _sLocation!, // Use the user's current location
                      zoom: 15,
                    ),
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    compassEnabled: false,
                    markers: _markers,
                    onMapCreated: (GoogleMapController controller) {
                      setState(() => _controller = controller);
                    },
                  ),
                  if (_controller != null)
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: FloatingMapButton(controller: _controller!),
                    ),
                  // Positioned(
                  //   top: 40,
                  //   right: 20,
                  //   child: SubmitButton(
                  //       onTap: () async =>
                  //           await ServiceMarker().testDeleteImageMarker(),
                  //       text: 'Refresh'),
                  // ),
                ],
              ));
      },
    );
  }
}
