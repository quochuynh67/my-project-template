import 'package:flutterbaseproject/constant/app_state.dart';
import 'package:flutterbaseproject/core/base/base_bloc.dart';
import 'package:flutterbaseproject/repo/user_repo.dart';
import 'package:rxdart/rxdart.dart';

class SplashBloc extends BaseBloc {
  SplashBloc({
    required this.userRepo,
  });

  final UserRepo userRepo;

  final BehaviorSubject<UserLoginState> psUserLoginState = BehaviorSubject();

  void checkLogin() {
    Future<void>.delayed(const Duration(seconds: 2)).then((_) {
      psUserLoginState.add(UserLoginState.LOGGED_IN);
    });
  }

  @override
  void dispose() {
    psUserLoginState.close();
    super.dispose();
  }
}
