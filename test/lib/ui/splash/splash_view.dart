import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterbaseproject/base/base_state_bloc.dart';
import 'package:flutterbaseproject/constant/app_state.dart';
import 'package:flutterbaseproject/ui/home/home_route.dart';
import 'package:flutterbaseproject/ui/splash/splash_bloc.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends BaseStateBloc<SplashView, SplashBloc> {
  late StreamSubscription subUserLoginState;

  @override
  void dispose() {
    subUserLoginState.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    subUserLoginState = getBloc(listen: false).psUserLoginState.listen((state) {
      switch (state) {
        case UserLoginState.LOGGED_IN:
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: Duration(
                seconds: 2,
              ),
              pageBuilder: (_, __, ___) => homeRoute,
            ),
          );
          break;
        case UserLoginState.NOT_LOGIN:
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: Duration(
                seconds: 2,
              ),
              pageBuilder: (_, __, ___) => homeRoute,
            ),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Splash Screen"),
        ),
      ),
    );
  }
}
