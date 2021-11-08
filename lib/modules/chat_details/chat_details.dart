import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/cubit.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/states.dart';
import 'package:manager_restaurant/models/message_model.dart';
import 'package:manager_restaurant/models/user_model.dart';
import 'package:manager_restaurant/shared/component.dart';
import 'package:manager_restaurant/shared/icon_broken.dart';
import 'package:manager_restaurant/shared/styles/colors.dart';

class ChatDetails extends StatelessWidget {
  // const ChatDetails({Key? key}) : super(key: key);
  UserModel userModel;
  bool isRecording = false;
  ChatDetails({Key? key, required this.userModel}) : super(key: key);
  TextEditingController messageController = TextEditingController();
  bool isWriting = false;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        MangerRestaurantCubit.get(context)
            .getMessage(receiverId: userModel.uId);
        print(MangerRestaurantCubit.get(context).messages);
        return BlocConsumer<MangerRestaurantCubit, MangerRestaurantStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userModel.image),
                      radius: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      userModel.name,
                      style: const TextStyle(
                          color: Colors.black,
                          height: 1.2,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message = MangerRestaurantCubit.get(context)
                                .messages[index];
                            if (MangerRestaurantCubit.get(context)
                                    .userModel
                                    ?.uId ==
                                message.senderId) return sendMyMessage(message);

                            return sendMessage(message);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: MangerRestaurantCubit.get(context)
                              .messages
                              .length),
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
                                        MangerRestaurantCubit.get(context)
                                            .postImage as File),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 170,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
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
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    icon: const CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          IconBroken.Send,
                                          size: 18,
                                        )),
                                    onPressed: () {
                                      MangerRestaurantCubit.get(context)
                                          .uploadMessageImage(
                                        context: context,
                                        receiverId: userModel.uId,
                                      );
                                      MangerRestaurantCubit.get(context)
                                          .removePostImage();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.grey.withOpacity(.2),
                                )),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    MangerRestaurantCubit.get(context)
                                        .comingSoon(context);
                                  },
                                  icon:
                                      const Icon(Icons.emoji_emotions_outlined),
                                  color: Colors.grey[500],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: getTranslated(context,
                                          'ChatDetails_screen_textFiled_hint'),
                                      hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    onChanged: (value) {
                                      isWriting = true;
                                      if (value == '') isWriting = false;
                                      MangerRestaurantCubit.get(context)
                                          .emit(ChangeMessageIconState());
                                      print('isWriting = $isWriting');
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    MangerRestaurantCubit.get(context)
                                        .getPostImage();
                                  },
                                  icon: const Icon(IconBroken.Image),
                                  color: Colors.grey[500],
                                ),
                                IconButton(
                                  onPressed: () {
                                    MangerRestaurantCubit.get(context)
                                        .comingSoon(context);
                                  },
                                  icon: const Icon(IconBroken.Document),
                                  color: Colors.grey[500],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: defaultColor.withOpacity(.8),
                          ),
                          child:
                              messageController.text != '' || isWriting == true
                                  ? IconButton(
                                      onPressed: () {
                                        if (isWriting == true) {
                                          MangerRestaurantCubit.get(context)
                                              .sendMessage(
                                                  receiverId: userModel.uId,
                                                  dateTime:
                                                      DateTime.now().toString(),
                                                  text: messageController.text);
                                          messageController.text = '';
                                          isWriting = false;
                                          // MangerRestaurantCubit.get(context).emit(ChatChangeMessageIconState());
                                        }
                                      },
                                      icon: const Icon(
                                        IconBroken.Send,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    )
                                  : isRecording
                                      ? IconButton(
                                          onPressed: () {
                                            MangerRestaurantCubit.get(context)
                                                .comingSoon(context);
                                            /*    MangerRestaurantCubit.get(context)
                                                .stopRecorde();
                                            isRecording = false;*/
                                          },
                                          icon: const Icon(
                                            IconBroken.Voice_2,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            MangerRestaurantCubit.get(context)
                                                .comingSoon(context);
                                            /*     MangerRestaurantCubit.get(context)
                                                .startRecorde();
                                            isRecording = true;*/
                                          },
                                          icon: const Icon(
                                            IconBroken.Voice,
                                            color: Colors.white,
                                            size: 25,
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
      },
    );
  }

  Widget sendMessage(MessageModel messageModel) {
    if (messageModel.type == 'image') {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
            decoration: BoxDecoration(
              color: defaultColor.withOpacity(.2),
              borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                bottomStart: Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(8.0),
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(messageModel.text),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            )),
      );
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            bottomEnd: Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(messageModel.text),
        ),
      ),
    );
  }

  Widget sendMyMessage(MessageModel messageModel) {
    if (messageModel.type == 'image') {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
            decoration: BoxDecoration(
              color: defaultColor.withOpacity(.2),
              borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                bottomStart: Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(8.0),
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(messageModel.text),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            )),
      );
    }

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: defaultColor.withOpacity(.2),
          borderRadius: const BorderRadiusDirectional.only(
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            bottomStart: Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(messageModel.text),
        ),
      ),
    );
  }
}
