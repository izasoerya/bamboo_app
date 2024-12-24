import 'package:bamboo_app/src/app/presentation/widgets/organism/modal_bottom_sheet.dart';
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
          infoWindow: InfoWindow(
            title: data.name,
            snippet: data.description,
            onTap: () => showModalBottomSheet(
                context: context,
                builder: (parentContext) {
                  return ModalBottomSheet(
                    uidMarker: data.uid,
                    parentContext: context,
                  );
                }),
          ),
        ),
      );
    }
    return listMarker;
  }
}
