import '/screens/signup/controller/signUpController.dart';
import '/screens/signup/signUpComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetWidget<SignUpController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromRGBO(63, 81, 181, 1),
        body: SingleChildScrollView(
            child: Form(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height),
                    child: Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/backgroundLogin.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              svgPicture,
                              signupTitle,
                              spacingH,
                              nameField(controller),
                              spacingH,
                              mobileField(controller),
                              spacingH,
                              emailField(controller),
                              spacingH,
                              passwordField(controller),
                              additionalButton,
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    registerButton(controller),
                                    spacingW,
                                    backButton(controller),
                                  ])
                            ],
                          ),
                        ),
                      ),
                      Positioned.fill(child: Obx(() {
                        if (controller.signUpState.value ==
                            SignUpState.loading) {
                          return Container(
                              color: Colors.black54,
                              child: Center(
                                  child: SizedBox(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                                width: 50,
                                height: 50,
                              )));
                        } else {
                          return const SizedBox.shrink();
                        }
                      }))
                    ])))));
  }
}
