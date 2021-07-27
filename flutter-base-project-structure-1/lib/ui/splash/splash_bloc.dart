import 'package:flutter/cupertino.dart';
import 'package:flutterbaseproject/base/base_bloc.dart';
import 'package:flutterbaseproject/constant/app_state.dart';
import 'package:flutterbaseproject/repo/user_repo.dart';
import 'package:rxdart/rxdart.dart';

class SplashBloc extends BaseBloc {
  final UserRepo userRepo;

  late BehaviorSubject<UserLoginState> psUserLoginState;

  SplashBloc({
    required this.userRepo,
  }) {
    psUserLoginState = BehaviorSubject();
  }

  void checkLogin() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      psUserLoginState.add(UserLoginState.LOGGED_IN);
    });
  }

  @override
  void dispose() {
    psUserLoginState.close();
    super.dispose();
  }
}
