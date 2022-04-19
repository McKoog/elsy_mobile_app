import '/infrastructurestorage/user/api_storage_user_infrastructure.dart';
import '/infrastructurestorage/user/local_storage_user_interface.dart';
import '/models/user/loginUser.dart';
import '/routes/navigation.dart';
import '/toster/exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum LoginState { initial, loading }

class LoginController extends GetxController {
  final ApiStorageInterfaceUser apiStorageInterface;
  final LocalStorageInterfaceUser localStorageInterface;

  LoginController(
      {required this.localStorageInterface, required this.apiStorageInterface});

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  var loginState = LoginState.initial.obs;

  @override
  onInit() {
    loginState = LoginState.initial.obs;
    super.onInit();
  }

  /*
    Обращаемся к тексту в полях.
    Выполняем проверку.
    Если все окей, получаем токен с сервера, сохраняем в локале, получаем инфу о пользователе для последующих страниц.
  */
  Future<bool> login() async {
    final email = emailTextController.text;
    final password = passwordTextController.text;
    if (emailValidation(email) && passwordValidation(password)) {
      try {
        loginState(LoginState.loading);
        final loginResponse = await apiStorageInterface
            .loginUser(LoginUser(email: email, password: password));
        if (loginResponse != "") {
          final user = await apiStorageInterface
              .getUserFromToken(loginResponse.toString());
          await localStorageInterface.saveToken(loginResponse.toString());
          await localStorageInterface.setUserSettings(user);
          await 2.delay();
          loginState(LoginState.initial);
          return true;
        } else {
          loginState(LoginState.initial);
          return false;
        }
      } on ExceptionToaster catch (_) {
        return false;
      }
    } else {
      return false;
    }
  }

  navigateToSignUpScreen() {
    Get.toNamed(Routes.signup);
  }

  navigateToMapScreen() {
    Get.toNamed(Routes.map);
  }

  onLoginButtonClick() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    final result = await login();
    if (result) {
      Get.offAllNamed(Routes.map);
    } else {
      Get.snackbar(
          "login_error_toaster_title".tr, "login_error_toaster_body".tr,
          borderWidth: 2, borderColor: Colors.red);
    }
  }

  bool emailValidation(String email) {
    if (email != "" && GetUtils.isEmail(email)) {
      return true;
    } else {
      return false;
    }
  }

  bool passwordValidation(String password) {
    if (password.length >= 6 && GetUtils.isUsername(password)) {
      return true;
    } else {
      return false;
    }
  }

  onRegisterButtonClick() {
    Get.toNamed(Routes.signup);
  }
}
