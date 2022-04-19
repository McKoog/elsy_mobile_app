import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Marker> mapMarker = [];

class Markers {
  late String id;
  late num lat;
  late num lng;
  late String name;
  late String info;
  late int pumpId;

  Markers(
      {required this.id,
      required this.lat,
      required this.lng,
      required this.name,
      required this.info,
      required this.pumpId});

  factory Markers.fromJson(Map<String, dynamic> json) {
    return Markers(
        id: json['Id'],
        lat: json['coordinate1'],
        lng: json['coordinate2'],
        name: json['Name'],
        info: json['Info'],
        pumpId: 0);
  }
}
