import 'package:bamboo_app/src/app/blocs/polygon_state.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/modal_callback.dart';
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
    BlocProvider.of<PolygonStateBloc>(context).add(FetchPolygonData());
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

  void _tapCallBack(LatLng argument) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) {
          return const ModalCallback();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(defaultUser.name)),
      body: BlocBuilder<PolygonStateBloc, PolygonState>(
        builder: (context, state) {
          final data = state.polygons;
          for (var element in data) {
            _polygons.add(Polygon(
              polygonId: PolygonId(element!.uid),
              points: element.polygon,
              strokeWidth: 2,
              strokeColor: Colors.lightBlue,
              fillColor: Colors.lightBlue.withOpacity(0.5),
            ));
          }
          return GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.7749, -122.4194), // San Francisco coordinates
                zoom: 13,
              ),
              markers: _markers,
              polygons: _polygons,
              polylines: _polylines,
              onTap: (argument) {
                _mapController.animateCamera(CameraUpdate.newLatLng(argument));
                _tapCallBack(argument);
              },
              onMapCreated: (GoogleMapController handler) =>
                  _mapController = handler);
        },
      ),
    );
  }
}
