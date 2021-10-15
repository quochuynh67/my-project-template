import 'package:flutter/cupertino.dart';
import 'package:flutterbaseproject/base/base_bloc.dart';
import 'package:flutterbaseproject/repo/user_repo.dart';

class HomeBloc extends BaseBloc {
  HomeBloc({
    required this.userRepo,
  });

  final UserRepo userRepo;

  @override
  void dispose() {
    debugPrint('dispose');
    super.dispose();
  }
}
