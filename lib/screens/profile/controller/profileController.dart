import '/infrastructurestorage/user/api_storage_user_infrastructure.dart';
import '/infrastructurestorage/user/local_storage_user_interface.dart';
import '/models/user/settingsUser.dart';
import '/toster/exception.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ProfileState { initial, loading }

class ProfileController extends GetxController {
  final LocalStorageInterfaceUser localStorageInterfaceUser;
  final ApiStorageInterfaceUser apiStorageInterfaceUser;

  ProfileController(
      {required this.localStorageInterfaceUser,
      required this.apiStorageInterfaceUser});

  @override
  void onInit() {
    loadUserSettings();
    super.onInit();
  }

  var profileState = ProfileState.initial.obs;
  final fuelTypeStandart = "АИ-92".obs;

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final fuelTypeTextController = TextEditingController();
  final fuelSizeTextController = TextEditingController();

  loadUserSettings() async {
    final user = await localStorageInterfaceUser.getUserSettings();

    print("$user.name $user.email $user.fuelType");

    nameTextController.text = user.name.toString();
    emailTextController.text = user.email.toString();
    fuelSizeTextController.text = user.fuelSize.toString();
    fuelTypeStandart.value = user.fuelType.toString();
  }

  Future<bool> changeUserSettings() async {
    final token = await localStorageInterfaceUser.getToken();

    final name = nameTextController.text;
    final email = emailTextController.text;
    final fuelType = fuelTypeStandart.value;
    final fuelSize = fuelSizeTextController.text;

    profileState(ProfileState.loading);
    await apiStorageInterfaceUser.changeUserSettings(
        token.toString(),
        UserSettings(
            name: name, email: email, fuelType: fuelType, fuelSize: fuelSize));
    try {
      await localStorageInterfaceUser.setUserSettings(UserSettings(
          name: name, email: email, fuelType: fuelType, fuelSize: fuelSize));
      profileState(ProfileState.initial);
      return true;
    } on ExceptionToaster catch (_) {
      profileState(ProfileState.initial);
      return false;
    }
  }

  onSetSettingsButtonTap() async {
    changeUserSettings();
  }
}
