import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/cubit.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/states.dart';
import 'package:manager_restaurant/models/post_model.dart';
import 'package:manager_restaurant/modules/add_post/add_post.dart';
import 'package:manager_restaurant/shared/component.dart';
import 'package:manager_restaurant/shared/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  // const FeedsScreen({Key? key}) : super(key: key);

  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MangerRestaurantCubit, MangerRestaurantStates>(
        listener: (context, state) {},
        builder: (context, state) {
          print('posts is ${MangerRestaurantCubit.get(context).posts.length}');
          return state is GetPostSuccessState ||
                  MangerRestaurantCubit.get(context).posts.isNotEmpty
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      if (MangerRestaurantCubit.get(context)
                              .userModel
                              ?.typeUser !=
                          'user')
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0, top: 10),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            // elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        '${MangerRestaurantCubit.get(context).userModel?.image}'),
                                    // fit: BoxFit.cover,
                                    radius: 30,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        navigateTo(context, AddPostScreen());
                                      },
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(getTranslated(context,
                                              'feeds_screen_add_post_card_title')),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.withOpacity(.5),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            elevation: 5,
                          ),
                        ),
                      if (MangerRestaurantCubit.get(context)
                              .userModel
                              ?.typeUser ==
                          'user')
                        const SizedBox(
                          height: 15,
                        ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          // scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => cardItem(
                              MangerRestaurantCubit.get(context).posts[index],
                              context,
                              index),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 15,
                              ),
                          itemCount:
                              MangerRestaurantCubit.get(context).posts.length),
                      const SizedBox(
                        height: 15,
                      ),
                      /* cardItem(context),*/
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Widget cardItem(PostModel model, BuildContext context, index) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      // elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(model.image),
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
                            model.name,
                            style: const TextStyle(
                                color: Colors.black, height: 1.2),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blueAccent,
                            size: 16,
                          )
                        ],
                      ),
                      Text(
                        model.dateTime,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(height: 1.2),
                        //TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                /*  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(IconBroken.More_Circle)),*/
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: myDivider()),
            Text(
              model.text,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.black54),
            ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 8.0),
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('${model.postImage}'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
