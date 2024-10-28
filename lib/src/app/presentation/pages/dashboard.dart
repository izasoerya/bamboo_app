import 'package:bamboo_app/src/app/blocs/user_logged_state.dart';
import 'package:bamboo_app/src/domain/infrastructure/i_polygon.dart';
import 'package:bamboo_app/utils/default_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late GoogleMapController _mapsHandler;
  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = {};
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _addMarker();
  }

  void _addMarker() {
    _markers.add(
      const Marker(
        markerId: MarkerId('marker_1'),
        position: LatLng(37.7749, -122.4194), // San Francisco coordinates
        infoWindow: InfoWindow(
          title: 'San Francisco',
          snippet: 'An interesting city',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(defaultUser.name)),
      body: Stack(
        children: [
          FutureBuilder(
              future: InfrastructurePolygon().readPolygons(defaultUser.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final data = snapshot.data;
                  data!.forEach((element) {
                    _polygons.add(Polygon(
                      polygonId: PolygonId(element!.uid),
                      points: element.polygon,
                      strokeWidth: 2,
                      strokeColor: Colors.red,
                      fillColor: Colors.red.withOpacity(0.5),
                    ));
                  });
                  return GoogleMap(
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(
                            37.7749, -122.4194), // San Francisco coordinates
                        zoom: 13,
                      ),
                      markers: _markers,
                      polygons: _polygons,
                      polylines: _polylines,
                      onMapCreated: (GoogleMapController handler) =>
                          _mapsHandler = handler);
                }
                return const Center(child: Text('No data'));
              }),
          ElevatedButton(
              onPressed: () async =>
                  await InfrastructurePolygon().readPolygons(defaultUser.uid),
              child: const Text('Read Polygon')),
        ],
      ),
    );
  }
}
