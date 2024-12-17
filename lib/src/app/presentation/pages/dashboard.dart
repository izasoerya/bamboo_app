import 'package:bamboo_app/src/app/presentation/widgets/atom/add_button.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/my_location_button.dart';
import 'package:bamboo_app/src/app/presentation/widgets/organism/modal_bottom_sheet.dart';
import 'package:bamboo_app/src/app/use_cases/marker_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bamboo_app/src/app/blocs/marker_state.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late GoogleMapController _controller;
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
              onMapCreated: (GoogleMapController controller) =>
                  _controller = controller,
            ),
            Positioned(
              bottom: 100,
              right: 20,
              child: MyLocationButton(onTap: () async {
                final position = await Geolocator.getCurrentPosition();
                _controller.animateCamera(
                  CameraUpdate.newLatLng(
                      LatLng(position.latitude, position.longitude)),
                );
              }),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: AddButton(onTap: () async {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext modalContext) =>
                      ModalBottomSheet(parentContext: context),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
