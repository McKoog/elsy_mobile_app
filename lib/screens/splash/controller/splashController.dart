import '/infrastructurestorage/markers/api_storage_interface_markers.dart';
import '/infrastructurestorage/user/api_storage_user_infrastructure.dart';
import '/infrastructurestorage/user/local_storage_user_interface.dart';
import '/routes/navigation.dart';
import '/screens/map/controller/mapController.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final mapController = Get.put(MapScreenController(
      localStorageInterfaceUser: Get.find(),
      apiStorageInterfaceUser: Get.find(),
      apiStorageInterfaceMarkers: Get.find()));

  // Подключаем нужные нам контроллеры.
  final LocalStorageInterfaceUser localStorageInterfaceUser;
  final ApiStorageInterfaceUser apiStorageInterfaceUser;
  final ApiStorageInterfaceMarkers apiStorageInterfaceMarkers;

  SplashController(
      {required this.localStorageInterfaceUser,
      required this.apiStorageInterfaceUser,
      required this.apiStorageInterfaceMarkers});

  //TODO: Добавить проверку на наличие интернета на устройстве.

  @override
  void onReady() {
    apiStorageInterfaceMarkers
        .getMarkers(); //Подгружаем объекты на карте на этом этапе, до инициализации самой карты.
    mapController.addMarkersToMap(); //Добавляем объекты на камеру.
    validateSession();
    super.onReady();
  }

  //Проверка на токен хранящийся в локальном хранилище, если он есть, сверяемся с токеном аккаунта на сервере и переходим на основной экран
  //Если его нет, переходим на экран логина
  void validateSession() async {
    final token = await localStorageInterfaceUser.getToken();

    if (token != null) {
      final user = await apiStorageInterfaceUser.getUserFromToken(token);
      await localStorageInterfaceUser.setUserSettings(user);
      Get.offNamed(Routes.map);
    } else {
      Get.offNamed(Routes.login);
    }
  }

  //Save this code for add to test server.

  // void createMarkers() {
  //   markers.add(Markers(
  //       id: '0',
  //       lat: 54.5047558,
  //       lng: 36.2976054,
  //       name: 'АЗС №1',
  //       info: 'Улица Серверная, стр. 1',
  //       pumpId: 3));
  //   markers.add(Markers(
  //       id: '1',
  //       lat: 54.6047558,
  //       lng: 36.2976054,
  //       name: 'АЗС №2',
  //       info: 'Улица Фуллстековая, стр. 4',
  //       pumpId: 2));
  //   markers.add(Markers(
  //       id: '2',
  //       lat: 54.5047558,
  //       lng: 36.4976054,
  //       name: 'АЗС №3',
  //       info: 'Улица Фронтендческая, стр. 5',
  //       pumpId: 4));
  //   markers.add(Markers(
  //       id: '3',
  //       lat: 54.6047558,
  //       lng: 36.1976054,
  //       name: 'АЗС №4',
  //       info: 'Улица Бекендческая, стр. 2',
  //       pumpId: 1));
  //}
}
