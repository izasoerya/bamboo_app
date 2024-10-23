import 'package:google_maps_flutter/google_maps_flutter.dart';

class EntitiesPolygon {
  final String uid;
  final List<String> uidUser;
  final String name;
  final List<LatLng> polygon;
  final DateTime createdAt;

  EntitiesPolygon({
    required this.uid,
    required this.uidUser,
    required this.name,
    required this.polygon,
    required this.createdAt,
  });

  EntitiesPolygon copyWith({
    String? uid,
    String? name,
    List<String>? uidUser,
    List<LatLng>? polygon,
    DateTime? createdAt,
  }) {
    return EntitiesPolygon(
      uid: uid ?? this.uid,
      uidUser: uidUser ?? this.uidUser,
      name: name ?? this.name,
      polygon: polygon ?? this.polygon,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory EntitiesPolygon.fromJSON(Map<String, dynamic> json) {
    return EntitiesPolygon(
      uid: json['uid'],
      uidUser: json['uidUser'],
      name: json['name'],
      polygon: json['polygon'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'uid': uid,
      'uidUser': uidUser,
      'name': name,
      'polygon': polygon,
      'createdAt': createdAt,
    };
  }
}
