import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/states.dart';
import 'package:manager_restaurant/models/holiday_model.dart';
import 'package:manager_restaurant/models/message_model.dart';
import 'package:manager_restaurant/models/post_model.dart';
import 'package:manager_restaurant/models/user_model.dart';
import 'package:manager_restaurant/models/work_shift_model.dart';
import 'package:manager_restaurant/modules/chats/chat_screen.dart';
import 'package:manager_restaurant/modules/feeds/feeds_screen.dart';
import 'package:manager_restaurant/modules/home_page_screen/home_page_screen.dart';
import 'package:manager_restaurant/modules/login_screen/manger_restaurant_login_screen.dart';
import 'package:manager_restaurant/modules/setting_screen/setting_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:manager_restaurant/shared/component.dart';
import 'package:manager_restaurant/shared/constant.dart';
import 'package:manager_restaurant/shared/network/local/cache_helper.dart';

class MangerRestaurantCubit extends Cubit<MangerRestaurantStates> {
  MangerRestaurantCubit() : super(MangerRestaurantInitialState());

  static MangerRestaurantCubit get(context) => BlocProvider.of(context);

  // All variable and function to bottom navigate in layout screen
  int currentIndex = 0;

  // this list is not name page , it is the key for name page in language.json
  List<String> title = [
    'HomePage_title',
    'Feeds_title',
    'Chats_title',
    'Setting_title',
  ];
  List<Widget> screens = [
    const HomePageScreen(),
    FeedsScreen(),
    const ChatScreen(),
    const SettingScreen(),
  ];

  void changBottomNav(int index) {
    currentIndex = index;
    emit(LayoutChangeBottomNavState());
  }

  // All variable and function to  get user
  UserModel? userModel;

  void getUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      //value.data() is type from Map<String,dynamic>
      userModel = UserModel.fromJson(value.data());
      emit(GetUserSuccessState());
    }).catchError((error) {
      print('Get User error is ${error.toString()}');
      emit(GetUserErrorState(error.toString()));
    });
  }

  // All variable and function to  addPost Screen and Feeds screen
  File? postImage;
  var picker = ImagePicker();

  Future<void> getPostImage({source = ImageSource.gallery}) async {
    final pickedFile = await picker.getImage(
      source: source,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage?.path as String).pathSegments.last}')
        .putFile(postImage as File)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
        print(value);
      }).catchError((error) {
        emit(CreatePostErrorState());
        print('error getDownloadURL ${error.toString()}');
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
      print('error putFile ${error.toString()}');
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
    //required String userId,
  }) {
    // emit(ChatCreatePostLoadingState());
    PostModel postModel = PostModel(
      name: userModel?.name as String,
      uId: userModel?.uId as String,
      image: userModel?.image as String,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
      //getUserData();
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> posts = [];

  void getPosts() {
    emit(GetPostLoadingState());
    FirebaseFirestore.instance.collection('posts').orderBy('dateTime',descending:true).get().then((value) {
      for (var element in value.docs) {
        posts.add(PostModel.fromJson(element.data()));
      }
      emit(GetPostSuccessState());
    }).catchError((error) {
      print('Get Post Error is ${error.toString()}');
      emit(GetPostErrorState(error.toString()));
    });
  }

  // all variable and function to Chat Screen
  List<UserModel> users = [];

  void getUsers() {
    emit(GetUsersLoadingState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (userModel?.uId != element.data()['uId']) {
            users.add(UserModel.fromJson(element.data()));
          }
          usersNumber.add(UserModel.fromJson(element.data()));
        }
        emit(GetUsersSuccessState());
      }).catchError((error) {
        print('Get Users Error is ${error.toString()}');
        emit(GetUsersErrorState(error.toString()));
      });
    }
  }

  void logOut(BuildContext context) {
    CacheHelper.removeData(key: 'uId');
    navigateAndFinish(context, LoginScreen());
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
    String type = 'text',
  }) {
    MessageModel messageModel = MessageModel(
      receiverId: receiverId,
      text: text,
      senderId: userModel?.uId as String,
      dateTime: dateTime,
      type: type,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error.toString()));
    });
  }

  List<MessageModel> messages = [];

  void getMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      for (var element in event.docs) {
        print(element.data());
        messages.add(MessageModel.fromJson(element.data()));
      }
      print('new messages $messages');
      emit(GetMessagesSuccessState());
    });
  }

  void uploadMessageImage({
    required BuildContext context,
    required String receiverId,
  }) {
    emit(CreateMessageImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'messagesImage/${Uri.file(postImage?.path as String).pathSegments.last}')
        .putFile(postImage as File)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //createMessageImage(dateTime: dateTime, text: text, postImage: value);
        sendMessage(
          receiverId: receiverId,
          dateTime: DateTime.now().toString(),
          text: value,
          type: 'image',
        );
        emit(CreateMessageImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(CreateMessageImageErrorState(error.toString()));
        print('error getDownloadURL ${error.toString()}');
      });
    }).catchError((error) {
      emit(CreateMessageImageErrorState(error.toString()));
      print('error putFile ${error.toString()}');
    });
  }

  // function Message group work
  void sendMessageWork({
    required String dateTime,
    required String text,
    String type = 'text',
  }) {
    MessageModel messageModel = MessageModel(
      text: text,
      senderId: userModel?.uId as String,
      dateTime: dateTime,
      type: type,
    );
    FirebaseFirestore.instance
        .collection('Work chats')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error.toString()));
    });
  }

  List<MessageModel> messagesWork = [];

  void getMessageWork() {
    FirebaseFirestore.instance
        .collection('Work chats')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messagesWork = [];

      for (var element in event.docs) {
        print(element.data());
        messagesWork.add(MessageModel.fromJson(element.data()));
      }
      print('new messages $messages');
      emit(GetMessagesSuccessState());
    });
  }

  void uploadMessageImageWork({
    required BuildContext context,
  }) {
    emit(CreateMessageImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'messagesImage/${Uri.file(postImage?.path as String).pathSegments.last}')
        .putFile(postImage as File)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //createMessageImage(dateTime: dateTime, text: text, postImage: value);
        sendMessageWork(
          dateTime: DateTime.now().toString(),
          text: value,
          type: 'image',
        );
        emit(CreateMessageImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(CreateMessageImageErrorState(error.toString()));
        print('error getDownloadURL ${error.toString()}');
      });
    }).catchError((error) {
      emit(CreateMessageImageErrorState(error.toString()));
      print('error putFile ${error.toString()}');
    });
  }

  // all function and variable to setting screen
  File? profileImage;

  Future<void> getProfileImage({source = ImageSource.gallery}) async {
    final pickedFile = await picker.getImage(
      source: source,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      updateImageProfile();
      emit(ChangeProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ChangeProfileImagePickedErrorState());
    }
  }

  void updateImageProfile() {
    print('profileImage is $profileImage');
    if (profileImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users')
          .child('/${Uri.file(profileImage?.path as String).pathSegments.last}')
          .putFile(profileImage as File)
          .then((value) {
        //emit(ChatUploadProfileImageSuccessState());
        value.ref.getDownloadURL().then((value) {
          UserModel model = UserModel(
            name: "${userModel?.name}",
            email: "${userModel?.email}",
            phone: "${userModel?.phone}",
            uId: "${userModel?.uId}",
            typeUser: "${userModel?.typeUser}",
            image: value,
          );
          //emit(AddUserSuccessState());
          FirebaseFirestore.instance
              .collection('users')
              .doc(uId)
              .update(model.toMap())
              .then((value) {
            emit(UpdateUserSuccessState());
          }).catchError((error) {
            print('Error create user is ${error.toString()}');
            emit(UpdateUserErrorState(error.toString()));
          });
        }).catchError((error) {
          print('Register Error is ${error.toString()}');
          emit(UpdateUserErrorState(error.toString()));
        });
      }).catchError((error) {
        print('Error Upload image is ${error.toString()}');
        emit(UpdateUserErrorState(error.toString()));
      });
    }
  }

  //all variable and function to Workers Screen
  void deleteUser({required String uId}) {
    FirebaseAuth.instance.userChanges();
    FirebaseFirestore.instance.doc(uId).delete().then((value) {
      emit(DeleteUserSuccessState());
    }).catchError((error) {
      emit(DeleteUserErrorState(error.toString()));
    });
  }

  // function coming soon
  void comingSoon(BuildContext context) {
    showToast(
        text: getTranslated(context, 'Function_Coming_Soon'),
        state: ToastStates.WARNING);
  }

//all variable and function to Work Shift Screen
  List<WorkShiftsModel> workShiftModels = [];

  void getWorkShifts() {
    workShiftModels = [];
    if (workShiftModels.isEmpty) {
      emit(GetWorkShiftLoadingState());
      FirebaseFirestore.instance.collection('Work Shifts').orderBy('dateBegan').get().then((value) {
        for (var element in value.docs) {
          workShiftModels.add(WorkShiftsModel.fromJson(element.data()));
        }
        emit(GetWorkShiftSuccessState());
      }).catchError((error) {
        print('GetWorkShiftErrorState is ${error.toString()}');
        emit(GetWorkShiftErrorState(error.toString()));
      });
    }
  }

  void addWorkShifts({
    required String title,
    required String dateBegan,
    required String dateEnd,
    required List<String> users,
  }) {
    emit(AddWorkShiftLoadingState());
    WorkShiftsModel workShiftsModel = WorkShiftsModel(
        title: title, dateBegan: dateBegan, dateEnd: dateEnd, users: users);
    FirebaseFirestore.instance
        .collection('Work Shifts')
        .doc()
        .set(workShiftsModel.toMap())
        .then((value) {
      emit(AddWorkShiftSuccessState());
    }).catchError((error) {
      print('Error Add WorkShift is ${error.toString()}');
      emit(AddWorkShiftErrorState(error.toString()));
    });
  }

  //all function to holiday screen
  List<HolidayModel> holidayModels = [];

  void getHoliday() {
    holidayModels = [];
    if (holidayModels.isEmpty) {
      emit(GetHolidayLoadingState());
      FirebaseFirestore.instance.collection('Holiday').orderBy('dateHoliday',descending: true).get().then((value) {
        for (var element in value.docs) {
          holidayModels.add(HolidayModel.fromJson(element.data()));
        }
        emit(GetHolidaySuccessState());
      }).catchError((error) {
        print('GetHolidayErrorState is ${error.toString()}');
        emit(GetWorkShiftErrorState(error.toString()));
      });
    }
  }

  void addHoliday({
    required String dateHoliday,
    String? dateFinishHoliday,
    required List<String> users,

  }) {
    emit(AddHolidayLoadingState());
    HolidayModel holidaysModel = HolidayModel(dateHoliday: dateHoliday, users: users,dateFinishHoliday: dateFinishHoliday);
    FirebaseFirestore.instance
        .collection('Holiday')
        .doc()
        .set(holidaysModel.toMap())
        .then((value) {
      emit(AddHolidaySuccessState());
    }).catchError((error) {
      print('Error Add Holiday is ${error.toString()}');
      emit(AddHolidayErrorState(error.toString()));
    });
  }

}
