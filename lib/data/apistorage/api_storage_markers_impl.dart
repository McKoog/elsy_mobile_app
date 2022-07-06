 import 'package:elsy_mobile_app/models/fuelpump/Stations.dart';
import '/constants.dart';
import '/infrastructurestorage/markers/api_storage_interface_markers.dart';
import 'package:http/http.dart' as http;

class ApiStorageMarkerImpl extends ApiStorageInterfaceMarkers {
  @override
  Future<List> getMarkers(String userApiKey) async {

    Uri uri = Uri.https(baseUrl, '/Station/GetStations');
    final response = await http.get(uri,headers: {
    "Accept": "text/plain",
    "Access-Control-Allow-Origin" : "https://192.168.4.22:7242",
    "Access-Control-Allow-Credentials" : 'true',
    "Authorization" : "Bearer " + userApiKey
    });

    print(uri);
    print(response.body);
    if (response.statusCode == 200) {
      final List<Stations> stations = stationsFromJson(response.body);
      return stations;
    } else {
      throw Exception("ERROR! BAD DATA!");
    }
  }
}
