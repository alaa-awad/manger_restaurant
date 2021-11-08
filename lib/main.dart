import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/cubit.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/manger_restaurant_layout.dart';
import 'package:manager_restaurant/modules/on_boarding/on_boarding.dart';
import 'package:manager_restaurant/shared/bloc_observer.dart';
import 'package:manager_restaurant/shared/constant.dart';
import 'package:manager_restaurant/shared/localization/app_local.dart';
import 'package:manager_restaurant/shared/network/local/cache_helper.dart';
import 'package:manager_restaurant/shared/styles/themes.dart';
import 'modules/login_screen/manger_restaurant_login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  //discuss any widget will open
  Widget screenWidget;
  //uId = CacheHelper.getData(key: 'uId');
  uId = 'zCyKu9AdyCTRilLwcQK9sSA51E82';
  if (uId != null) {
    screenWidget = const MangerRestaurantLayout();
  } else {
    screenWidget = LoginScreen();
  }

  runApp(MyApp(
    screen: screenWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget screen;
  const MyApp({Key? key, required this.screen}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => MangerRestaurantCubit()
            ..getPosts()
            ..getUserData()
            ..getUsers()
            ..getWorkShifts()
          ..getHoliday(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        //   locale: const Locale('ar', ''),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocale.delegate,
        ],
        localeResolutionCallback: (currentLocale, supportedLocale) {
          if (currentLocale != null) {
            for (Locale locale in supportedLocale) {
              if (currentLocale.languageCode == locale.languageCode) {
                return currentLocale;
              }
            }
          }
          return supportedLocale.first;
          //
        },
        locale: const Locale('ar', ''),
        debugShowCheckedModeBanner: false,
        home: Builder(builder: (context) {
          String os = Platform.operatingSystem;
          print('Operator system is $os');
          return screen;
        }),
      ),
    );
  }
}
