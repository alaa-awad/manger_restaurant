import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/cubit.dart';
import 'package:manager_restaurant/models/user_model.dart';
import 'package:manager_restaurant/modules/add_user_screen/add_user_screen.dart';
import 'package:manager_restaurant/modules/add_user_screen/cubit/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:manager_restaurant/shared/constant.dart';

class AddUserCubit extends Cubit<AddUserStates> {
  AddUserCubit() : super(AddUserInitialState());

  static AddUserCubit get(context) => BlocProvider.of(context);

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage({source = ImageSource.gallery}) async {
    final pickedFile = await picker.getImage(
      source: source,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(AddUserProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AddUserProfileImagePickedErrorState());
    }
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String typeUser,
    required BuildContext context,
    String profileImage =
        'https://image.freepik.com/free-vector/man-holding-phone-illustration_73842-838.jpg',
  }) {
    emit(AddUserLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('starte userCreate');
      userCreate(
          name: name,
          email: email,
          phone: phone,
          uId: '${value.user?.uid}',
          typeUser: typeUser,
          context: context,
          image: profileImage);
      print('Register email is ${value.user?.email.toString()}');
      print('Register id is ${value.user?.uid.toString()}');
    }).catchError((error) {
      print('Register user Error is ${error.toString()}');
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required String typeUser,
    required String image,
    required BuildContext context,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: image,
      typeUser: typeUser,
    );
    print('Starte 2');
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
          //emit(AddUserSuccessState());
          FirebaseFirestore.instance
              .collection('users')
              .doc(uId)
              .set(model.toMap())
              .then((value) {
            emit(AddUserCreateUserSuccessState(uId));
          }).catchError((error) {
            print('Error create user is ${error.toString()}');
            emit(AddUserCreateUserErrorState(error.toString()));
          });
        }).catchError((error) {
          print('Register Error is ${error.toString()}');
          emit(AddUserCreateUserErrorState(error.toString()));
        });
      }).catchError((error) {
        print('Error Upload image is ${error.toString()}');
        emit(AddUserCreateUserErrorState(error.toString()));
      });
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .set(model.toMap())
          .then((value) {
        emit(AddUserCreateUserSuccessState(uId));
      }).catchError((error) {
        print('Error create user is ${error.toString()}');
        emit(AddUserCreateUserErrorState(error.toString()));
      });
    }
    MangerRestaurantCubit.get(context).users = [];
    MangerRestaurantCubit.get(context).getUsers();
  }

  String userType = 'user';
  String chooseUserType(var state) {
    switch (state) {
      case addUserType.user:
        userType = 'user';
        break;
      case addUserType.admin:
        userType = 'admin';
        break;
      case addUserType.supervisor:
        userType = 'supervisor';
        break;
    }

    return userType;
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(AddUserChangePasswordVisibilityState());
  }

  //function update user in page update user
  void updateUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required String typeUser,
    required String image,
    required BuildContext context,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: image,
      typeUser: typeUser,
    );
    if (profileImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users')
          .child('/${Uri.file(profileImage?.path as String).pathSegments.last}')
          .putFile(profileImage as File)
          .then((value) {
        //emit(ChatUploadProfileImageSuccessState());
        value.ref.getDownloadURL().then((value) {
          //emit(AddUserSuccessState());
          model = UserModel(
            name: name,
            email: email,
            phone: phone,
            uId: uId,
            image: value,
            typeUser: typeUser,
          );
          FirebaseFirestore.instance
              .collection('users')
              .doc(uId)
              .update(model.toMap())
              .then((value) {
            emit(UpdateUserSuccessState());
          }).catchError((error) {
            print('Update user is ${error.toString()}');
            emit(UpdateUserErrorState(error.toString()));
          });
        }).catchError((error) {
          print('Update Error is ${error.toString()}');
          emit(UpdateUserErrorState(error.toString()));
        });
      }).catchError((error) {
        print('Error Upload image is ${error.toString()}');
        emit(UpdateUserErrorState(error.toString()));
      });
    } else {
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
    }
    MangerRestaurantCubit.get(context).users = [];
    usersNumber = [];
    MangerRestaurantCubit.get(context).getUsers();
  }
}
