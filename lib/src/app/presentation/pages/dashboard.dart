import 'package:bamboo_app/src/app/blocs/user_logged_state.dart';
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
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = {};
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _addMarker();
    _addPolygon();
    _addPolyline();
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

  void _addPolygon() {
    _polygons.add(
      Polygon(
        polygonId: const PolygonId('polygon_1'),
        points: const [
          LatLng(37.7749, -122.4194),
          LatLng(37.7849, -122.4294),
          LatLng(37.7949, -122.4194),
          LatLng(37.7849, -122.4094),
        ],
        consumeTapEvents: true,
        strokeColor: Colors.blue,
        strokeWidth: 3,
        fillColor: Colors.blue.withOpacity(0.3),
        onTap: () {
          setState(() {
            print('Tapped on polygon');
          });
        },
      ),
    );
  }

  void _addPolyline() {
    _polylines.add(
      const Polyline(
        polylineId: PolylineId('polyline_1'),
        points: [
          LatLng(37.7749, -122.4194),
          LatLng(37.7849, -122.4294),
          LatLng(37.7949, -122.4194),
        ],
        color: Colors.red,
        width: 3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(defaultUser.name)),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.7749, -122.4194), // San Francisco coordinates
              zoom: 13,
            ),
            markers: _markers,
            polygons: _polygons,
            polylines: _polylines,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
          ),
        ],
      ),
    );
  }
}
