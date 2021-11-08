import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manager_restaurant/models/user_model.dart';

String getOs(){
  return Platform.operatingSystem;
}

var uId;
//var password;
 List<UserModel> usersNumber =[];