import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/cubit.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/states.dart';
import 'package:manager_restaurant/modules/feeds/feeds_screen.dart';
import 'package:manager_restaurant/shared/component.dart';
import 'package:manager_restaurant/shared/icon_broken.dart';
import 'package:manager_restaurant/shared/styles/colors.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textPostController = TextEditingController();
    print('MangerRestaurantCubit.get(context).userModel?.name is ${MangerRestaurantCubit.get(context).userModel?.name}');
    print('MangerRestaurantCubit.get(context).userModel?.image is ${MangerRestaurantCubit.get(context).userModel?.image}');
    return BlocConsumer<MangerRestaurantCubit, MangerRestaurantStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(getTranslated(context, 'Add_post_appBar_title')),
            actions: [
              defaultTextButton(
                function: () {
                 // var now = DateTime.now();
                  var now = DateFormat.yMMMd().format(DateTime.now());
                  if (MangerRestaurantCubit.get(context).postImage == null) {
                    MangerRestaurantCubit.get(context).createPost(
                        dateTime: now.toString(),
                        text: textPostController.text);
                  } else {
                    MangerRestaurantCubit.get(context).uploadPostImage(
                        dateTime: now.toString(),
                        text: textPostController.text);
                  }
                  MangerRestaurantCubit.get(context).posts = [];
                  MangerRestaurantCubit.get(context).getPosts();
                  navigateAndFinish(context, FeedsScreen());
                },
                text: getTranslated(context, 'Add_post_textButton_title'),
                colorText: defaultColor,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: MangerRestaurantCubit.get(context)
                                  .userModel
                                  ?.image !=
                              null
                          ? NetworkImage(
                              '${MangerRestaurantCubit.get(context).userModel?.image}')
                          : const NetworkImage(
                              'https://image.freepik.com/free-vector/man-holding-phone-illustration_73842-838.jpg'),
                      // fit: BoxFit.cover,
                      radius: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              MangerRestaurantCubit.get(context).userModel?.name
                                  as String,
                              style: const TextStyle(
                                  color: Colors.black, height: 1.2),
                            ),
                          ],
                        ),
                        Text(
                          '${MangerRestaurantCubit.get(context).userModel?.typeUser}',
                          //getTranslated(context, 'Add_post_type_user_title'),
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(height: 1.2),
                          //TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textPostController,
                    decoration: InputDecoration(
                      hintText:
                          getTranslated(context, 'Add_post_textFormFiled_hint'),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (MangerRestaurantCubit.get(context).postImage != null)
                  Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              // margin: EdgeInsets.symmetric(horizontal: 8),
                              elevation: 5,
                              child: Image(
                                image: FileImage(
                                    MangerRestaurantCubit.get(context).postImage
                                        as File),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 170,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  IconBroken.Delete,
                                  size: 18,
                                )),
                            onPressed: () {
                              MangerRestaurantCubit.get(context)
                                  .removePostImage();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            MangerRestaurantCubit.get(context).getPostImage();
                          },
                          child: Container(
                            color: defaultColor,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(IconBroken.Image)),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(getTranslated(
                                    context, 'Add_post_button_addPhoto_title'),style: const TextStyle(color: Colors.white),),
                              ],
                            ),
                          )),
                    ),
                    Expanded(
                      child: Container(
                        color: defaultColor,
                        child: TextButton(
                          onPressed: () {
                            MangerRestaurantCubit.get(context).comingSoon(context);
                          },
                          child: Text(getTranslated(
                              context, 'Add_post_button_addTag_title'),style: const TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
