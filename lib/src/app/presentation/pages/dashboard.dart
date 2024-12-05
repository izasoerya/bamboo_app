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
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MarkerStateBloc>(context).add(FetchMarkerData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarkerStateBloc, MarkerState>(
      builder: (context, state) {
        final markerBamboo = state.polygons;
        for (var data in markerBamboo) {
          if (data == null) {
            continue;
          }
          _markers.add(
            Marker(
              markerId: MarkerId(data.uid),
              position: data.marker,
              infoWindow:
                  InfoWindow(title: data.name, snippet: data.description),
            ),
          );
        }
        return GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(37.7749, -122.4194), // San Francisco coordinates
            zoom: 14,
          ),
          zoomControlsEnabled: false,
          markers: _markers,
        );
      },
    );
  }
}
