import 'dart:async';
import 'package:flutter/material.dart';

import '../AppTheme.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildSplashPage();
  }

  _buildSplashPage() {
    return Container(
      alignment: Alignment.center,
        child: Text(
      "Android Assesment",
      style:
          Theme.of(context).textTheme.headline4.copyWith(color: Colors.white),
    ),
    color: blueDark,);
  }


}
