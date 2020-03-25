import 'dart:async';

import 'package:dualarim/util/string.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.pushReplacementNamed(context, homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/imgs/logo-dark.png', scale: 2),
    );
  }
}
