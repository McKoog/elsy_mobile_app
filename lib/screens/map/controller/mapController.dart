import '/infrastructurestorage/markers/api_storage_interface_markers.dart';
import '/infrastructurestorage/user/api_storage_user_infrastructure.dart';
import '/infrastructurestorage/user/local_storage_user_interface.dart';
import '/models/fuelpump/markers.dart';
import '/screens/fueldialog/fuelDialogScreen.dart';
import '/screens/navigationdialog/navigationDialog.dart';
import '/utils/checkDist.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

enum MapController { initial, loading }

class MapScreenController extends GetxController {
  final LocalStorageInterfaceUser localStorageInterfaceUser;
  final ApiStorageInterfaceUser apiStorageInterfaceUser;
  final ApiStorageInterfaceMarkers apiStorageInterfaceMarkers;
  final Location location = new Location();

  

  MapScreenController({
    required this.localStorageInterfaceUser,
    required this.apiStorageInterfaceUser,
    required this.apiStorageInterfaceMarkers,
  });

  getLocation() async{
    bool _serviceEnabled;
PermissionStatus _permissionGranted;
LocationData _locationData;

_serviceEnabled = await location.serviceEnabled();
if (!_serviceEnabled) {
  _serviceEnabled = await location.requestService();
  if (!_serviceEnabled) {
    return;
  }
}

_permissionGranted = await location.hasPermission();
if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = await location.requestPermission();
  if (_permissionGranted != PermissionStatus.granted) {
    return;
  }

}

_locationData = await location.getLocation();

  }
  @override
  void onInit() {
    getLocation();
    addMarkersToMap();
    super.onInit();
  }

  addMarkersToMap() async {
    final markers = await apiStorageInterfaceMarkers.getMarkers();
    print("$markers");
    for (var i in markers) {
      var id = i.id;
      var lat = i.lat;
      var lng = i.lng;
      var title = i.name;
      var info = i.info;
      var markerPosLat = i.lat;
      var markerPosLng = i.lng;

      var nextMarker = new Marker(
          markerId: MarkerId(id),
          position: new LatLng(lat.toDouble(), lng.toDouble()),
          onTap: () => onMarkerTap(id, title, info, markerPosLat.toDouble(),
              markerPosLng.toDouble()),
          infoWindow: InfoWindow(title: title));

      mapMarker.add(nextMarker);
    }
  }

  onMarkerTap(id, title, info, markerPosLat, markerPosLng) async {
    var pos = await location.getLocation();
    print(calculateDistance(
        pos.latitude!, pos.longitude!, markerPosLat, markerPosLng));
    if (calculateDistance(
            pos.latitude!, pos.longitude!, markerPosLat, markerPosLng) <
        0.05) {
      goToFuelDialog(id, title, info, markerPosLat, markerPosLng);
    } else {
      goToNavigationDialog(id, title, info, markerPosLat, markerPosLng);
    }
  }

  goToFuelDialog(String id, String title, String info, double markerPosLat,
      double markerPosLng) async {
    final user = await localStorageInterfaceUser.getUserSettings();
    print("$id $title $markerPosLat $info");
    Get.dialog(FuelDialog(), barrierDismissible: true, arguments: [
      "$id",
      "$title",
      "$info",
      "$markerPosLat",
      "$markerPosLng",
      "${user.name}"
    ]);
  }

  goToNavigationDialog(String id, String title, String info,
      double markerPosLat, double markerPosLng) {
    print("$id $title $markerPosLat $info");
    Get.dialog(NavigationDialog(), barrierDismissible: true, arguments: [
      "$id",
      "$title",
      "$info",
      "$markerPosLat",
      "$markerPosLng"
    ]);
  }

  animateToUser(controllerMap) async {
    var pos = await location.getLocation();
    controllerMap.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(pos.latitude!, pos.longitude!), zoom: 17.0)));
  }

  onMapCreated(GoogleMapController controllerMap) {
    animateToUser(controllerMap);
  }
}
