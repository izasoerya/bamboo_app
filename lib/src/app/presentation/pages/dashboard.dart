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
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MarkerStateBloc>(context).add(FetchMarkerData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarkerStateBloc, MarkerState>(
      builder: (context, state) {
        _markers = MarkerController().fetchListMarker(state.markers);

        return GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(37.7749, -122.4194), // San Francisco coordinates
            zoom: 14,
          ),
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          markers: _markers,
        );
      },
    );
  }
}
