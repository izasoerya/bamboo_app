import 'package:bamboo_app/src/app/presentation/widgets/atom/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bamboo_app/src/domain/entities/e_marker.dart';

class MarkerController {
  Set<Marker> fetchListMarker(
      Set<EntitiesMarker> markers, BuildContext context) {
    final Set<Marker> listMarker = {};
    for (var data in markers) {
      listMarker.add(
        Marker(
          markerId: MarkerId(data.uid),
          position: data.location,
          onTap: () => showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.black54,
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder:
                (BuildContext buildContext, Animation a1, Animation a2) {
              return Align(
                alignment: Alignment.center,
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  child: CustomInfoWindow(marker: data),
                ),
              );
            },
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        ),
      );
    }
    return listMarker;
  }
}
