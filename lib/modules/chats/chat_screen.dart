import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/cubit.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/states.dart';
import 'package:manager_restaurant/modules/chat_details/chat_details.dart';
import 'package:manager_restaurant/modules/chat_details/work_chat_details.dart';
import 'package:manager_restaurant/shared/component.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MangerRestaurantCubit, MangerRestaurantStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: MangerRestaurantCubit.get(context).users.isNotEmpty ||
                  state is GetUsersSuccessState
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            navigateTo(context, WorkChatDetails());
                          },
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://image.freepik.com/free-vector/membership-join-community-line-vector-icon_116137-1320.jpg'),
                                radius: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                getTranslated(
                                    context, 'Chat_screen_chat_group_name'),
                                style: const TextStyle(
                                    color: Colors.black,
                                    height: 1.2,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                      myDivider(),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (MangerRestaurantCubit.get(context)
                                    .userModel
                                    ?.uId !=
                                MangerRestaurantCubit.get(context)
                                    .users[index]
                                    .uId) {
                              return userCardItem(
                                  context: context, index: index);
                            }
                            return Container();
                          },
                          separatorBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: myDivider(),
                              ),
                          itemCount:
                              MangerRestaurantCubit.get(context).users.length),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }

  Widget userCardItem({required BuildContext context, required index}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          navigateTo(
              context,
              ChatDetails(
                  userModel: MangerRestaurantCubit.get(context).users[index]));
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  MangerRestaurantCubit.get(context).users[index].image),
              radius: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              MangerRestaurantCubit.get(context).users[index].name,
              style: const TextStyle(
                  color: Colors.black,
                  height: 1.2,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
