import 'dart:convert';

List<Stations> stationsFromJson(String str) => List<Stations>.from(json.decode(str).map((x) => Stations.fromJson(x)));

String stationsToJson(List<Stations> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stations {
  Stations({
    required this.stationId,
    required this.enable,
    required this.name,
    required this.adress,
    required this.location,
  });

  int stationId;
  bool enable;
  String name;
  String adress;
  Location location;

  factory Stations.fromJson(Map<String, dynamic> json) => Stations(
    stationId: json["Station_id"],
    enable: json["Enable"],
    name: json["Name"],
    adress: json["Adress"],
    location: Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "Station_id": stationId,
    "Enable": enable,
    "Name": name,
    "Adress": adress,
    "location": location.toJson(),
  };
}

class Location {
  Location({
    required this.lat,
    required this.long,
  });

  double lat;
  double long;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["Lat"].toDouble(),
    long: json["Long"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Lat": lat,
    "Long": long,
  };
}
