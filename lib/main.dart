import 'dart:async';

import 'package:assesmentexample/preference/PreferenceHelper.dart';
import 'package:assesmentexample/login/register.dart';
import 'package:assesmentexample/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AppTheme.dart';
import 'home/HomePage.dart';
import 'splash/SplashPage.dart';

Future main() async {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool splashFinish = false;

  bool isLogged;

  @override
  Future<void> initState() {
    super.initState();
    splashDelay();
    checkForLoggedInSession();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: splashFinish ? _getNextScreen() : SplashPage(),
      theme: AppTheme.getThemeData(context),
    );
  }

  void splashDelay() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        splashFinish = true;
      });
    });
  }

  Future<bool> checkForLoggedInSession() async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    return localStorageService.isLoggedIn();
  }

  _getNextScreen() {
    return FutureBuilder(
      builder: (context, data) {
        if (data.data == null || data.data == false)
          return Registeration();
        else
          return HomePage();
      },
      future: checkForLoggedInSession(),
    );
  }
}
