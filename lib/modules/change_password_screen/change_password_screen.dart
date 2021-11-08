import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manager_restaurant/modules/login_screen/manger_restaurant_login_screen.dart';
import 'package:manager_restaurant/shared/adaptive/adaptive_button.dart';
import 'package:manager_restaurant/shared/adaptive/adaptive_text_field.dart';
import 'package:manager_restaurant/shared/component.dart';
import 'package:manager_restaurant/shared/constant.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),

              /* AdaptiveTextField(
                      os: getOs(),
                      label: getTranslated(
                          context, 'ChangePassword_screen_textFiled_oldPassword'),
                      controller: _oldPasswordController),
                  const SizedBox(
                    height: 20,
                  ),*/
              AdaptiveTextField(
                  os: getOs(),
                  label: getTranslated(
                      context, 'ChangePassword_screen_textFiled_newPassword'),
                  controller: _newPasswordController),
              const SizedBox(
                height: 20,
              ),
              AdaptiveTextField(
                  os: getOs(),
                  label: getTranslated(context,
                      'ChangePassword_screen_textFiled_confirmPassword'),
                  controller: _confirmPasswordController),
              const SizedBox(
                height: 20,
              ),
              //const Spacer(),
              AdaptiveButton(
                  os: getOs(),
                  function: () {
                    if (_confirmPasswordController.text ==
                        _newPasswordController.text) {
                      FirebaseAuth.instance.currentUser
                          ?.updatePassword(_newPasswordController.text);
                    }
                    navigateAndFinish(context, LoginScreen());
                  },
                  text: getTranslated(
                      context, 'ChangePassword_screen_button_change_password')),
            ],
          ),
        ),
      )),
    );
  }
}
