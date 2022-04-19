import '/infrastructurestorage/user/local_storage_user_interface.dart';
import '/models/user/settingsUser.dart';
import 'package:get/get.dart';

enum DraawerState { initial, loading }

class DraawerController extends GetxController{
  final LocalStorageInterfaceUser localStorageInterfaceUser;

  DraawerController(
      {required this.localStorageInterfaceUser});


  @override
  void onInit() {
    loadUserSettings();
    super.onInit();
  }
  var profileState = DraawerState.initial.obs;

   UserSettings? user;

  loadUserSettings() async {
    user = await localStorageInterfaceUser.getUserSettings();

    print("$user.name $user.email $user.fuelType");
  }

  String NameOfUser(){
    return user!.name.toString();
  }
  String EmailOfUser(){
    return user!.email.toString();
  }
}