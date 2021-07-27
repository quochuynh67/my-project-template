import 'package:flutter/cupertino.dart';
import 'package:flutterbaseproject/base/base_bloc.dart';
import 'package:flutterbaseproject/repo/user_repo.dart';

class HomeBloc extends BaseBloc {
  final UserRepo userRepo;

  HomeBloc({
    required this.userRepo,
  });

  @override
  void dispose() {
    super.dispose();
  }
}
