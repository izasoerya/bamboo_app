import 'package:bamboo_app/src/app/presentation/widgets/atom/add_button.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/my_location_button.dart';
import 'package:bamboo_app/src/app/presentation/widgets/organism/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FloatingMapButton extends StatelessWidget {
  const FloatingMapButton({
    super.key,
    required GoogleMapController controller,
  }) : _controller = controller;

  final GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyLocationButton(onTap: () async {
          final position = await Geolocator.getCurrentPosition();
          _controller.animateCamera(
            CameraUpdate.newLatLng(
                LatLng(position.latitude, position.longitude)),
          );
        }),
        const Padding(padding: EdgeInsets.only(top: 15)),
        AddButton(
          onTap: () async => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext modalContext) =>
                ModalBottomSheet(parentContext: context),
          ),
        ),
      ],
    );
  }
}
