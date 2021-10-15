import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterbaseproject/base/base_state_bloc.dart';
import 'package:flutterbaseproject/constant/app_state.dart';
import 'package:flutterbaseproject/generated/l10n.dart';
import 'package:flutterbaseproject/ui/home/home_route.dart';
import 'package:flutterbaseproject/ui/splash/splash_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _SplashViewState();
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
          Navigator.of(context).pushReplacement(PageRouteBuilder<void>(
            transitionDuration: const Duration(
              seconds: 2,
            ),
            pageBuilder: (_, __, ___) => homeRoute,
          ));
          break;
        case UserLoginState.NOT_LOGIN:
          Navigator.of(context).pushReplacement(
            PageRouteBuilder<void>(
              transitionDuration: const Duration(
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
      body: Center(
        child: Text(S.of(context).splash_title),
      ),
    );
  }
}
