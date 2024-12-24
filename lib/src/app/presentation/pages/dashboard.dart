import 'package:bamboo_app/src/app/presentation/widgets/organism/floating_map_button.dart';
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
  GoogleMapController? _controller; // Make controller nullable
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
        _markers = MarkerController().fetchListMarker(state.markers, context);

        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.7749, -122.4194), // San Francisco coordinates
                zoom: 14,
              ),
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                setState(() => _controller = controller);
              },
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: _controller == null
                  ? Container()
                  : FloatingMapButton(controller: _controller!),
            ),
          ],
        );
      },
    );
  }
}
