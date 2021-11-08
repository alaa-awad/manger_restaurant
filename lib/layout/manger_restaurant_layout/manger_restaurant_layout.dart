import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/cubit.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/states.dart';
import 'package:manager_restaurant/shared/component.dart';
import 'package:manager_restaurant/shared/icon_broken.dart';
import 'package:manager_restaurant/shared/styles/colors.dart';
class MangerRestaurantLayout extends StatelessWidget {
  const MangerRestaurantLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MangerRestaurantCubit, MangerRestaurantStates>(
      listener: (context, state) {},
      builder: (context, state) {
        MangerRestaurantCubit cubit = MangerRestaurantCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(getTranslated(context, cubit.title[cubit.currentIndex]))),
            centerTitle: false,
            actions: [
              /*defaultTextButton(
                  text: 'LogOut',
                  function: () {
                    CacheHelper.removeData(key: 'uId');
                    navigateAndFinish(context, MangerRestaurantLoginScreen());
                  }),*/
              IconButton(onPressed: (){
                MangerRestaurantCubit.get(context).comingSoon(context);
              }, icon: const Icon(IconBroken.Notification)),
              IconButton(onPressed: (){
                MangerRestaurantCubit.get(context).comingSoon(context);
              }, icon: const Icon(IconBroken.Search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changBottomNav(index);
            },
            //backgroundColor: defaultColor,
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(IconBroken.Home), label: getTranslated(context, 'HomePage_title'),backgroundColor: defaultColor),
              BottomNavigationBarItem(
                  icon: const Icon(IconBroken.Message), label: getTranslated(context, 'Feeds_title'),backgroundColor: defaultColor),
              BottomNavigationBarItem(
                  icon: const Icon(IconBroken.Chat), label: getTranslated(context, 'Chats_title'),backgroundColor: defaultColor),
              BottomNavigationBarItem(
                  icon: const Icon(IconBroken.Setting), label: getTranslated(context, 'Setting_title'),backgroundColor: defaultColor),
            ],
          ),
        );
      },
    );
  }
}
