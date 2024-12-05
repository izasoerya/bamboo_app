import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EntitiesMarker {
  final String uid;
  final String uidCreator;
  final List<String> uidUser;
  final String name;
  final String description;
  final LatLng marker;
  final DateTime createdAt;

  EntitiesMarker({
    required this.uid,
    required this.uidCreator,
    required this.uidUser,
    required this.name,
    required this.description,
    required this.marker,
    required this.createdAt,
  });

  EntitiesMarker copyWith({
    String? uid,
    String? uidCreator,
    List<String>? uidUser,
    String? name,
    String? description,
    LatLng? marker,
    DateTime? createdAt,
  }) {
    return EntitiesMarker(
      uid: uid ?? this.uid,
      uidCreator: uidCreator ?? this.uidCreator,
      uidUser: uidUser ?? this.uidUser,
      name: name ?? this.name,
      description: description ?? this.description,
      marker: marker ?? this.marker,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory EntitiesMarker.fromJSON(Map<String, dynamic> json) {
    return EntitiesMarker(
      uid: json['uid'],
      uidCreator: json['uidCreator'],
      uidUser: List<String>.from(json['uidUser']),
      name: json['name'],
      description: json['description'],
      marker: LatLng(
        (json['latlng'] as GeoPoint).latitude,
        (json['latlng'] as GeoPoint).longitude,
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
      'latlng': [GeoPoint(marker.latitude, marker.longitude)],
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
