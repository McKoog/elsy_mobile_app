import 'dart:convert';
import 'package:elsy_mobile_app/models/fuelpump/Stations.dart';

import '/constants.dart';
import '/infrastructurestorage/markers/api_storage_interface_markers.dart';
import '/models/fuelpump/markers.dart';
import 'package:http/http.dart' as http;

class ApiStorageMarkerImpl extends ApiStorageInterfaceMarkers {
  @override
  Future<List> getMarkers() async {
    Uri uri = Uri.http(baseUrl, '/Station/GetStations');
    var request = await http.get(uri);
    print(uri);
    print("${request.body}");
    if (request.statusCode == 200) {
      Iterable listJson = json.decode(request.body);
      final List<Stations> stations = stationsFromJson(request.body.toString());
      List<Markers> markersList =
          List<Markers>.from(listJson.map((model) => Markers.fromJson(model)));
      return stations;
    } else {
      throw Exception("ERROR! BAD DATA!");
    }
  }
}
