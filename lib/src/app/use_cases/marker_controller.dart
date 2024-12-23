import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bamboo_app/src/domain/entities/e_marker.dart';

class MarkerController {
  Set<Marker> fetchListMarker(Set<EntitiesMarker> markers) {
    final Set<Marker> listMarker = {};
    for (var data in markers) {
      listMarker.add(
        Marker(
          markerId: MarkerId(data.uid),
          position: data.location,
          infoWindow: InfoWindow(
            title: data.name,
            snippet: data.description,
            onTap: () => print('Tapped Again'),
          ),
        ),
      );
    }
    return listMarker;
  }
}
