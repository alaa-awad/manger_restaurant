import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/cubit.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/states.dart';
import 'package:manager_restaurant/models/user_model.dart';
import 'package:manager_restaurant/modules/add_user_screen/add_user_screen.dart';
import 'package:manager_restaurant/modules/update_user/update_user.dart';
import 'package:manager_restaurant/shared/component.dart';
import 'package:manager_restaurant/shared/constant.dart';
import 'package:manager_restaurant/shared/icon_broken.dart';

class WorkersScreen extends StatelessWidget {
  const WorkersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MangerRestaurantCubit, MangerRestaurantStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navigateTo(context, AddUserScreen());
              },
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: ListView.separated(
                itemBuilder: (context, index) {
                  return cardItemUser(
                      usersNumber[index], context);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemCount:  usersNumber.length));
      },
    );
  }
}

Widget cardItemUser(UserModel user, BuildContext context) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('${user.name} ( ${user.typeUser} )'),
            const SizedBox(height: 7,),
            Text(user.phone),
          ],),
          const Spacer(),
          IconButton(
              onPressed: () {
                navigateTo(context, UpdateUserScreen(user: user,));
              },
              icon: const Icon(
                IconBroken.Edit,
                color: Colors.yellow,
              )),
          IconButton(
              onPressed: () {
                MangerRestaurantCubit.get(context).comingSoon(context);
                // MangerRestaurantCubit.get(context).deleteUser(uId: user.uId);
              },
              icon: const Icon(
                IconBroken.Delete,
                color: Colors.red,
              )),
        ],
      ),
    ),
  );
}

