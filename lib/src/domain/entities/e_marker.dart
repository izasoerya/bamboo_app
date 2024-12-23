import 'package:google_maps_flutter/google_maps_flutter.dart';

class EntitiesMarker {
  final String uid;
  final String uidCreator;
  final List<String> uidUser;
  final String name;
  final String description;
  final String strain;
  final int qty;
  final String urlImage;
  final String ownerName;
  final String ownerContact;
  final LatLng location;
  final DateTime createdAt;

  EntitiesMarker({
    required this.uid,
    required this.uidCreator,
    required this.uidUser,
    required this.name,
    required this.description,
    required this.strain,
    required this.qty,
    required this.urlImage,
    required this.ownerName,
    required this.ownerContact,
    required this.location,
    required this.createdAt,
  });

  EntitiesMarker copyWith({
    String? uid,
    String? uidCreator,
    List<String>? uidUser,
    String? name,
    String? description,
    String? strain,
    int? qty,
    String? urlImage,
    String? ownerName,
    String? ownerContact,
    LatLng? location,
    DateTime? createdAt,
  }) {
    return EntitiesMarker(
      uid: uid ?? this.uid,
      uidCreator: uidCreator ?? this.uidCreator,
      uidUser: uidUser ?? this.uidUser,
      name: name ?? this.name,
      description: description ?? this.description,
      strain: strain ?? this.strain,
      qty: qty ?? this.qty,
      urlImage: urlImage ?? this.urlImage,
      ownerName: ownerName ?? this.ownerName,
      ownerContact: ownerContact ?? this.ownerContact,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory EntitiesMarker.fromJSON(Map<String, dynamic> json) {
    return EntitiesMarker(
      uid: json['uid'],
      uidCreator: json['uidCreator'],
      uidUser: json['uidUser'].toString().split(','),
      name: json['name'],
      description: json['description'],
      strain: json['strain'],
      qty: json['qty'],
      urlImage: json['urlImage'],
      ownerName: json['ownerName'],
      ownerContact: json['ownerContact'],
      location: json['location'].toString().split(',').length == 2
          ? LatLng(
              double.parse(json['location'].toString().split(',')[0]),
              double.parse(json['location'].toString().split(',')[1]),
            )
          : const LatLng(0, 0),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'uid': uid,
      'uidCreator': uidCreator,
      'uidUser': uidUser,
      'name': name,
      'description': description,
      'strain': strain,
      'qty': qty,
      'urlImage': urlImage,
      'ownerName': ownerName,
      'ownerContact': ownerContact,
      'location': '${location.latitude},${location.longitude}',
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
