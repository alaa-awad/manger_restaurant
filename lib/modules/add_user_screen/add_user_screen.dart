import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/manger_restaurant_layout.dart';
import 'package:manager_restaurant/modules/add_user_screen/cubit/cubit.dart';
import 'package:manager_restaurant/modules/add_user_screen/cubit/states.dart';
import 'package:manager_restaurant/shared/adaptive/adaptive_button.dart';
import 'package:manager_restaurant/shared/adaptive/adaptive_text_field.dart';
import 'package:manager_restaurant/shared/component.dart';
import 'package:manager_restaurant/shared/constant.dart';
import 'package:manager_restaurant/shared/icon_broken.dart';
import 'package:manager_restaurant/shared/network/local/cache_helper.dart';
import 'package:manager_restaurant/shared/styles/colors.dart';

class AddUserScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();

  AddUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    addUserType? userTypeEnum = addUserType.user;
    return BlocProvider(
      create: (BuildContext context) => AddUserCubit(),
      child: BlocConsumer<AddUserCubit, AddUserStates>(
        listener: (context, state) {
          if (state is AddUserCreateUserErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if (state is AddUserCreateUserSuccessState) {
          /*  CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, const MangerRestaurantLayout());
            });*/
            navigateAndFinish(context, const MangerRestaurantLayout());
          }
        },
        builder: (context, state) {
          AddUserCubit userCubit = AddUserCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            getTranslated(context, 'Add_user_title'),
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Center(
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                radius: 63.0,
                                child: CircleAvatar(
                                  backgroundImage: userCubit.profileImage ==
                                          null
                                      ? const NetworkImage(
                                          'https://image.freepik.com/free-vector/man-holding-phone-illustration_73842-838.jpg')
                                      : FileImage(
                                              userCubit.profileImage as File)
                                          as ImageProvider,

                                  /*profileImage == null
                                      ? NetworkImage('${userModel?.image}')
                                      : FileImage(profileImage) as ImageProvider,*/
                                  // fit: BoxFit.cover,
                                  radius: 60,
                                ),
                              ),
                              IconButton(
                                icon: const CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 18,
                                    )),
                                onPressed: () {
                                  userCubit.getProfileImage();
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        AdaptiveTextField(
                          os: getOs(),
                          label: getTranslated(context, 'Add_user_label_name'),
                          controller: nameController,
                          type: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return getTranslated(
                                  context, 'Add_user_validate_name');
                            }
                          },
                          prefix: Icons.person,
                          inputBorder: const OutlineInputBorder(),
                          boxDecoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: defaultColor,
                              width: 1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        AdaptiveTextField(
                          os: getOs(),
                          label: getTranslated(context, 'Add_user_label_email'),
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return getTranslated(
                                  context, 'Add_user_validate_email');
                            }
                          },
                          prefix: Icons.email,
                          inputBorder: const OutlineInputBorder(),
                          boxDecoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: defaultColor,
                              width: 1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        AdaptiveTextField(
                          os: getOs(),
                          label:
                              getTranslated(context, 'Add_user_label_password'),
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return getTranslated(
                                  context, 'Add_user_validate_password');
                            }
                            if (value.length < 4) {
                              return getTranslated(context,
                                  'add_user_password_controller_validate_isWeek');
                            }
                          },
                          prefix: Icons.lock_outline,
                          inputBorder: const OutlineInputBorder(),
                          boxDecoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: defaultColor,
                              width: 1,
                            ),
                          ),
                          suffix: userCubit.suffix,
                          suffixPressed: () {
                            userCubit.changePasswordVisibility();
                          },
                          isPassword: userCubit.isPassword,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        AdaptiveTextField(
                          os: getOs(),
                          label: getTranslated(context, 'Add_user_label_phone'),
                          controller: phoneController,
                          type: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return getTranslated(
                                  context, 'Add_user_validate_phone');
                            }
                          },
                          prefix: Icons.phone,
                          inputBorder: const OutlineInputBorder(),
                          boxDecoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: defaultColor,
                              width: 1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getTranslated(
                                context,
                                'Add_user_radio_text',
                              ),
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            RadioListTile<addUserType>(
                              title: Text(getTranslated(
                                  context, 'Add_user_radio_text_user')),
                              value: addUserType.user,
                              groupValue: userTypeEnum,
                              onChanged: (addUserType? value) {
                                userTypeEnum = value;
                                userCubit.userType =
                                    userCubit.chooseUserType(value);
                                userCubit.emit(AddUserChangeRadioButton());
                              },
                              activeColor: defaultColor,
                            ),
                            RadioListTile<addUserType>(
                              title: Text(getTranslated(
                                  context, 'Add_user_radio_text_supervisor')),
                              value: addUserType.supervisor,
                              groupValue: userTypeEnum,
                              onChanged: (addUserType? value) {
                                userTypeEnum = value;
                                userCubit.userType =
                                    userCubit.chooseUserType(value);
                                userCubit.emit(AddUserChangeRadioButton());
                              },
                              activeColor: defaultColor,
                            ),
                            RadioListTile<addUserType>(
                              title: Text(getTranslated(
                                  context, 'Add_user_radio_text_admin')),
                              value: addUserType.admin,
                              groupValue: userTypeEnum,
                              onChanged: (addUserType? value) {
                                userTypeEnum = value;
                                userCubit.userType =
                                    userCubit.chooseUserType(value);
                                userCubit.emit(AddUserChangeRadioButton());
                              },
                              activeColor: defaultColor,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        state is! AddUserLoadingState ||
                                state is AddUserCreateUserErrorState
                            ? AdaptiveButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    userCubit.userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password:
                                          passwordController.text.toString(),
                                      phone: phoneController.text.toString(),
                                      typeUser: userCubit.userType,
                                      context: context,
                                    );
                                    // navigateTo(context,ProductsScreen());
                                  }
                                },
                                text: getTranslated(
                                    context, 'Add_user_text_button'),
                                isUpperCase: true,
                                background: defaultColor,
                                os: getOs(),
                              )
                            : const Center(child: CircularProgressIndicator())
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

enum addUserType { user, supervisor, admin }
