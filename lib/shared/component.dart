import 'package:fluttertoast/fluttertoast.dart';
import 'package:manager_restaurant/modules/login_screen/manger_restaurant_login_screen.dart';
import 'package:manager_restaurant/shared/localization/app_local.dart';
import 'package:flutter/material.dart';
import 'package:manager_restaurant/shared/network/local/cache_helper.dart';
import '';

//function get current text from key
String getTranslated(BuildContext context, String key) {
  return AppLocale.of(context).getTranslate(key);
}

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

void navigateAndFinish2(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return true;
      },
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget defaultTextButton({
  required var function,
  required String text,
  Color colorText = Colors.white,
  double fontSize = 15
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style:  TextStyle(color: colorText,fontSize: fontSize),
      ),
    );

Widget myDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );
