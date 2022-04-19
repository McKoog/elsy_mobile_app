import 'dart:convert';
import '/constants.dart';
import '/infrastructurestorage/markers/api_storage_interface_markers.dart';
import '/models/fuelpump/markers.dart';
import 'package:http/http.dart' as http;

class ApiStorageMarkerImpl extends ApiStorageInterfaceMarkers {
  @override
  Future<List> getMarkers() async {
    var request = await http.get(Uri.parse(baseUrl + "/api/markers"));
    if (request.statusCode == 200) {
      Iterable listJson = json.decode(request.body);
      List<Markers> markersList =
          List<Markers>.from(listJson.map((model) => Markers.fromJson(model)));
      return markersList;
    } else {
      throw Exception("ERROR! BAD DATA!");
    }
  }
}
