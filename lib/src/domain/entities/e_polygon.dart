import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EntitiesPolygon {
  final String uid;
  final String uidCreator;
  final List<String> uidUser;
  final String name;
  final String description;
  final LatLng polygon;
  final DateTime createdAt;

  EntitiesPolygon({
    required this.uid,
    required this.uidCreator,
    required this.uidUser,
    required this.name,
    required this.description,
    required this.polygon,
    required this.createdAt,
  });

  EntitiesPolygon copyWith({
    String? uid,
    String? uidCreator,
    List<String>? uidUser,
    String? name,
    String? description,
    LatLng? polygon,
    DateTime? createdAt,
  }) {
    return EntitiesPolygon(
      uid: uid ?? this.uid,
      uidCreator: uidCreator ?? this.uidCreator,
      uidUser: uidUser ?? this.uidUser,
      name: name ?? this.name,
      description: description ?? this.description,
      polygon: polygon ?? this.polygon,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory EntitiesPolygon.fromJSON(Map<String, dynamic> json) {
    return EntitiesPolygon(
      uid: json['uid'],
      uidCreator: json['uidCreator'],
      uidUser: List<String>.from(json['uidUser']),
      name: json['name'],
      description: json['description'],
      polygon: LatLng(
        (json['polygon'] as GeoPoint).latitude,
        (json['polygon'] as GeoPoint).longitude,
      ),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'uid': uid,
      'uidCreator': uidCreator,
      'uidUser': uidUser,
      'name': name,
      'description': description,
      'polygon': [GeoPoint(polygon.latitude, polygon.longitude)],
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
