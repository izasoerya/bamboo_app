import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonParser {
  Polygon generator(List<LatLng> points) {
    return Polygon(
      polygonId: const PolygonId('polygon_id'),
      points: points,
      strokeWidth: 2,
      strokeColor: const Color(0xFF000000),
      fillColor: const Color(0x22000000),
    );
  }
}
