import 'package:google_maps_flutter/google_maps_flutter.dart';

class EntitiesPolygon {
  final String uid;
  final List<String> uidUser;
  final String name;
  final List<LatLng> polygon;

  EntitiesPolygon({
    required this.uid,
    required this.uidUser,
    required this.name,
    required this.polygon,
  });

  EntitiesPolygon copyWith({
    String? uid,
    String? name,
    List<String>? uidUser,
    List<LatLng>? polygon,
  }) {
    return EntitiesPolygon(
      uid: uid ?? this.uid,
      uidUser: uidUser ?? this.uidUser,
      name: name ?? this.name,
      polygon: polygon ?? this.polygon,
    );
  }

  factory EntitiesPolygon.fromJSON(Map<String, dynamic> json) {
    return EntitiesPolygon(
      uid: json['uid'],
      uidUser: json['uidUser'],
      name: json['name'],
      polygon: json['polygon'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'uid': uid,
      'uidUser': uidUser,
      'name': name,
      'polygon': polygon,
    };
  }
}
