import '../../models/dataServer/fuelDialogData.dart';

abstract class ApiStorageInterfaceData {
  Future<FuelDialogData> getFuelDialogData(String StationId, String UserApiKey);

}