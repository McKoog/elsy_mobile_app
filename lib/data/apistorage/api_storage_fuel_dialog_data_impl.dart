import 'dart:convert';
import '../../infrastructurestorage/data/api_storage_interface_data.dart';
import '../../models/dataServer/fuelDialogData.dart';
import '/constants.dart';
import 'package:http/http.dart' as http;

class ApiStorageFuelDialogData extends ApiStorageInterfaceData {
  @override

  Future<FuelDialogData> getFuelDialogData(String StationId,String UserApiKey) async {
    Uri uri = Uri.https(baseUrl, '/Data/GetFuelDialogData',
        {"stationId" : StationId});
    final response = await http.get(uri,headers: {
    "Accept": "text/plain",
    "Access-Control-Allow-Origin" : "https://192.168.4.22:7242",
    "Access-Control-Allow-Credentials" : 'true',
    "Authorization" : "Bearer " + UserApiKey
    });
    print(uri);
    print("${response.body}");
    if (response.statusCode == 200) {
      var fuelDD = json.decode(response.body);
      final FuelDialogData fuelDialogData = FuelDialogData.fromJson(fuelDD);
      return fuelDialogData;
    } else {
      throw Exception("ERROR! BAD DATA!");
    }
  }
}