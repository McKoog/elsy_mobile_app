import '/infrastructurestorage/user/api_storage_user_infrastructure.dart';
import '/models/user/signUpUser.dart';
import '/routes/navigation.dart';
import '/toster/exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum SignUpState { initial, loading }

class SignUpController extends GetxController {
  final ApiStorageInterfaceUser apiStorageInterfaceUser;

  SignUpController({required this.apiStorageInterfaceUser});

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final mobileTextController = TextEditingController();

  var signUpState = SignUpState.initial.obs;

  final registerFormState = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> signUp() async {
    final name = nameTextController.text;
    final email = emailTextController.text;
    final mobile = mobileTextController.text;
    final password = passwordTextController.text;
    if (nameValidation(name) &&
        emailValidation(email) &&
        numberValidation(mobile) &&
        passwordValidation(password)) {
      try {
        signUpState(SignUpState.loading);
        await apiStorageInterfaceUser.registerUser(SignUpUser(
            name: name, mobile: mobile, email: email, password: password));
        await 2.delay();
        signUpState(SignUpState.initial);
        return true;
      } on ExceptionToaster catch (_) {
        signUpState(SignUpState.initial);
        return false;
      }
    } else {
      return false;
    }
  }

  onSignUpButtonClick() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    final result = await signUp();
    if (result) {
      Get.snackbar("register_success_toaster_title".tr,
          "register_success_toaster_body".tr);
      await 2.delay();
      Get.offAllNamed(Routes.login);
    } else {
      Get.snackbar(
          "register_error_toaster_title".tr, "register_error_toaster_body".tr,
          borderWidth: 2, borderColor: Colors.red);
    }
  }

  onBackButtonClick() {
    Get.back();
  }

  bool nameValidation(String name) {
    if (name != "") {
      return true;
    } else {
      return false;
    }
  }

  bool numberValidation(String number) {
    if (number != "" && GetUtils.isPhoneNumber(number)) {
      return true;
    } else {
      return false;
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
}
