import 'package:assesmentexample/main.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home/HomePage.dart';

class Routes {
  static String root = "/";
  static String dashboard = "/home";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    });

    router.define(root, handler: rootHandler);
    router.define(dashboard, handler: dashboardHandler);

  }
}

class Application {
  static Router router;
}

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return  MainApp();
});

var dashboardHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return HomePage();
    });

