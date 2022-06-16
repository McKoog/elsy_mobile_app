import '/models/fuelpump/markers.dart';
import '/screens/history/controller/historyController.dart';
import '/screens/map/controller/mapController.dart';
import '/widgets/appbarWrapper.dart';
import '/widgets/drawerController.dart';
import '/widgets/drawerWrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants.dart';

class MapScreen extends GetWidget<MapScreenController> {
  final mapController = Get.find<MapScreenController>();
  final drawerController = Get.lazyPut(
          () => DraawerController(localStorageInterfaceUser: Get.find()));
  final historyController = Get.lazyPut(() => HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: DrawerWrapper(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBarWrapper(),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: baseCoords, zoom: 14.5),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        compassEnabled: false,
        mapToolbarEnabled: false,
        markers: mapMarker.toSet(),
        onMapCreated: (GoogleMapController controllerMap) {
          controller.onMapCreated(controllerMap);
        },
      ),
    );
  }
}
