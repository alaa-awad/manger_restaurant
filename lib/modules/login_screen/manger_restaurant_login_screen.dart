import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/manger_restaurant_layout.dart';
import 'package:manager_restaurant/modules/login_screen/cubit/cubit.dart';
import 'package:manager_restaurant/modules/login_screen/cubit/states.dart';

import 'package:manager_restaurant/shared/adaptive/adaptive_button.dart';
import 'package:manager_restaurant/shared/adaptive/adaptive_text_field.dart';
import 'package:manager_restaurant/shared/component.dart';
import 'package:manager_restaurant/shared/constant.dart';
import 'package:manager_restaurant/shared/network/local/cache_helper.dart';
import 'package:manager_restaurant/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child:
          BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, const MangerRestaurantLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 300,
                          child: Image(
                            image: NetworkImage(
                                'https://image.freepik.com/free-vector/mobile-login-concept-illustration_114360-83.jpg'),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            //height: 200,
                          ),
                        ),
                        Text(
                          getTranslated(context, 'LogIn_title'),
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          getTranslated(context, 'LogIn_body'),
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          color: Colors.white,
                          child: AdaptiveTextField(
                            os: getOs(),
                            label: getTranslated(
                                context, 'LogIn_email_textFiled_hint'),
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return getTranslated(context,
                                    'LogIn_email_controller_validate_isEmpty');
                              }
                            },
                            prefix: Icons.email,
                            textInputAction: TextInputAction.next,
                            inputBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            boxDecoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: defaultColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          color: Colors.white,
                          child: AdaptiveTextField(
                            os: getOs(),
                            label: getTranslated(
                                context, 'LogIn_password_textFiled_hint'),
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context)
                                    .userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            isPassword: LoginCubit.get(context)
                                .isPassword,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return getTranslated(context,
                                    'LogIn_password_controller_validate_isEmpty');
                              }
                            },
                            prefix: Icons.lock_outline,
                            textInputAction: TextInputAction.done,
                            suffix:
                                LoginCubit.get(context).suffix,
                            suffixPressed: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            inputBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            boxDecoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: defaultColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        (state is! LoginLoadingState)
                            ? AdaptiveButton(
                                os: getOs(),
                                background: defaultColor,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context)
                                        .userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );

                                    //Cubit.get(context).getUserData();
                                  }
                                },
                                text:
                                    getTranslated(context, 'LogIn_button_text'),
                                isUpperCase: true,
                              )
                            : const Center(child: CircularProgressIndicator()),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
