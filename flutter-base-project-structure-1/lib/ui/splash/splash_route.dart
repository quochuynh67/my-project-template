import 'package:flutterbaseproject/repo/user_repo.dart';
import 'package:provider/provider.dart';

import 'splash_bloc.dart';
import 'splash_view.dart';

var splashRoute = ProxyProvider<UserRepo, SplashBloc>(
  create: (context) {
    SplashBloc splashBloc =
        SplashBloc(userRepo: Provider.of<UserRepo>(context, listen: false));

    splashBloc.checkLogin();

    return splashBloc;
  },
  update: (context, userRepo, splashBloc) {
    if (splashBloc != null) return splashBloc;
    return SplashBloc(
      userRepo: userRepo,
    );
  },
  dispose: (context, splashBloc) => splashBloc.dispose(),
  child: SplashView(),
);
