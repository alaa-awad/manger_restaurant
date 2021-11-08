import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/cubit.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/states.dart';
import 'package:manager_restaurant/modules/change_password_screen/change_password_screen.dart';
import 'package:manager_restaurant/shared/adaptive/adaptive_button.dart';
import 'package:manager_restaurant/shared/component.dart';
import 'package:manager_restaurant/shared/constant.dart';
import 'package:manager_restaurant/shared/icon_broken.dart';
import 'package:manager_restaurant/shared/styles/colors.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MangerRestaurantCubit, MangerRestaurantStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = MangerRestaurantCubit.get(context).userModel;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 17.0, bottom: 10),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      radius: 63.0,
                      child: CircleAvatar(
                        backgroundImage:
                            MangerRestaurantCubit.get(context).profileImage ==
                                    null
                                ? NetworkImage(
                                    '${userModel?.image}',
                                  )
                                : FileImage(MangerRestaurantCubit.get(context)
                                    .profileImage as File) as ImageProvider,
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
                        MangerRestaurantCubit.get(context).getProfileImage();
                         /*   .then((value){
                          MangerRestaurantCubit.get(context).updateImageProfile();
                        });*/
                      },
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${userModel?.name}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${userModel?.typeUser}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    defaultTextButton(
                        colorText: defaultColor,
                        fontSize: 17,
                        text: getTranslated(
                            context, 'Setting_screen_button_change_password'),
                        function: () {
                          navigateTo(context, ChangePasswordScreen());
                        }),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AdaptiveButton(
                    os: getOs(),
                    function: () {
                      MangerRestaurantCubit.get(context).logOut(context);
                    },
                    text: getTranslated(context, 'Setting_screen_button_LogOut')),
              )
            ],
          );
        },
      ),
    );
  }
}
