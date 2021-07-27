import 'package:flutterbaseproject/repo/user_repo.dart';
import 'package:provider/provider.dart';

import 'home_bloc.dart';
import 'home_view.dart';

var homeRoute = ProxyProvider<UserRepo, HomeBloc>(
  create: (context) {
    HomeBloc splashBloc =
        HomeBloc(userRepo: Provider.of<UserRepo>(context, listen: false));

    return splashBloc;
  },
  update: (context, userRepo, splashBloc) {
    if (splashBloc != null) return splashBloc;
    return HomeBloc(
      userRepo: userRepo,
    );
  },
  dispose: (context, splashBloc) => splashBloc.dispose(),
  child: HomeView(),
);
