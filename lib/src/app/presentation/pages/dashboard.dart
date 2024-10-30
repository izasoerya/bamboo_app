import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bamboo_app/src/app/blocs/polygon_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/modal_callback.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late GoogleMapController _mapController;
  final Set<Polygon> _polygons = {};

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PolygonStateBloc>(context).add(FetchPolygonData());
  }

  void _tapCallBack(String polygonID, GoogleMapController controller) {
    controller.animateCamera(CameraUpdate.newLatLng(_polygons
        .where((element) => element.polygonId.value == polygonID)
        .first
        .points
        .first));
    showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) {
          return const ModalCallback();
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PolygonStateBloc, PolygonState>(
      builder: (context, state) {
        final polygonsUser = state.polygons;
        for (var data in polygonsUser) {
          _polygons.add(Polygon(
            polygonId: PolygonId(data!.uid),
            points: data.polygon,
            strokeWidth: 2,
            strokeColor: Colors.lightBlue,
            fillColor: Colors.lightBlue.withOpacity(0.5),
            consumeTapEvents: true,
            onTap: () => _tapCallBack(data.uid, _mapController),
          ));
        }
        return GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.7749, -122.4194), // San Francisco coordinates
              zoom: 13,
            ),
            polygons: _polygons,
            onMapCreated: (GoogleMapController controller) =>
                _mapController = controller);
      },
    );
  }
}
