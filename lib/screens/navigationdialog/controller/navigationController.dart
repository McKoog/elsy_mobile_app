import '/infrastructurestorage/user/local_storage_user_interface.dart';
import '/screens/fueldialog/fuelDialogScreen.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDialogController extends GetxController {
  final LocalStorageInterfaceUser localStorageInterfaceUser;

  NavigationDialogController({required this.localStorageInterfaceUser});

  final argumentData = Get.arguments;

  openGoogleMap() async {
    var markerPosLat = argumentData[3].toString();
    var markerPosLng = argumentData[4].toString();
    String googleMapUrl =
        'https://www.google.com/maps/search/?api=1&query=$markerPosLat,$markerPosLng';
    if (await canLaunch(googleMapUrl)) {
      await launch(googleMapUrl);
    } else {
      //TODO: Create error toaster
      throw 'Could not open the map.';
    }
  }

  openYandexMap() async {
    var markerPosLat = argumentData[3].toString();
    var markerPosLng = argumentData[4].toString();
    String yandexMapUrl =
        'yandexnavi://build_route_on_map?lat_to=$markerPosLat&lon_to=$markerPosLng';
    if (await canLaunch(yandexMapUrl)) {
      await launch(yandexMapUrl);
    } else {
      //TODO: Create error toaster
      throw 'Could not open the map.';
    }
  }

  goToFuelDialog() async {
    var id = argumentData[0].toString();
    var title = argumentData[1].toString();
    var info = argumentData[2].toString();
    Get.back();
    final user = await localStorageInterfaceUser.getUserSettings();
    Get.dialog(FuelDialog(), barrierDismissible: true, arguments: [
      "$id",
      "$title",
      "$info",
      argumentData[5]
    ]);
  }
}
